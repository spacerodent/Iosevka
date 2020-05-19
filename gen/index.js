"use strict";

const fs = require("fs-extra");
const path = require("path");

const BuildFont = require("./build-font.js");
const Parameters = require("../support/parameters");
const FormVariantData = require("../support/variant-data");
const FormLigationData = require("../support/ligation-data");
const Toml = require("toml");

module.exports = async function main(argv) {
	const para = await getParameters(argv);
	const font = BuildFont(para);
	if (argv.oCharMap) await saveCharMap(argv, font);
	if (argv.o) await saveOtd(argv, font);
};

// Parameter preparation
async function getParameters(argv) {
	const PARAMETERS_TOML = path.resolve(__dirname, "../parameters.toml");
	const PRIVATE_TOML = path.resolve(__dirname, "../private.toml");
	const VARIANTS_TOML = path.resolve(__dirname, "../variants.toml");
	const LIGATIONS_TOML = path.resolve(__dirname, "../ligation-set.toml");

	const parametersData = Object.assign(
		{},
		await tryParseToml(PARAMETERS_TOML),
		(await fs.exists(PRIVATE_TOML)) ? await tryParseToml(PRIVATE_TOML) : []
	);
	const rawVariantsData = await tryParseToml(VARIANTS_TOML);
	const rawLigationData = await tryParseToml(LIGATIONS_TOML);

	const para = Parameters.build(parametersData, argv.hives, { shapeWeight: argv.shape.weight });

	const variantsData = FormVariantData(rawVariantsData, para);
	para.variants = variantsData;
	para.variantSelector = Parameters.build(variantsData, ["default", ...argv.hives]);
	para.defaultVariant = variantsData.default;

	const ligationData = FormLigationData(rawLigationData, para);
	para.defaultBuildup = ligationData.defaultBuildup;
	para.ligation = Parameters.build(ligationData.hives, ["default", ...argv.hives]);

	if (argv.excludedCharRanges) para.excludedCodePointRanges = argv.excludedCharRanges;
	if (argv.compatibilityLigatures) para.compLig = argv.compatibilityLigatures;
	if (argv.metricOverride) Parameters.applymetricOverride(para, argv.metricOverride);

	para.naming = {
		family: argv.menu.family,
		version: argv.menu.version,
		weight: argv.menu.weight - 0,
		width: argv.menu.width - 0,
		slant: argv.menu.slant
	};

	return para;
}

async function tryParseToml(str) {
	try {
		return Toml.parse(await fs.readFile(str, "utf-8"));
	} catch (e) {
		throw new Error(
			`Failed to parse configuration file ${str}.\nPlease validate whether there's syntax error.\n${e}`
		);
	}
}

// Save OTD
async function saveOtd(argv, font) {
	if (argv.o === "|") {
		process.stdout.write(JSON.stringify(font));
	} else {
		await fs.writeFile(argv.o, JSON.stringify(font, null, "    "));
	}
}

// Save char map
function objHashNonEmpty(obj) {
	if (!obj) return false;
	for (let k in obj) if (obj[k]) return true;
	return false;
}

async function saveCharMap(argv, font) {
	let charMap = [];
	for (const gid in font.glyf) {
		const glyph = font.glyf[gid];
		if (!glyph) continue;

		const glyphIsHidden = /^\./.test(gid);
		const typographicFeatures = [];
		if (!glyphIsHidden) {
			if (/\.NWID$/.test(gid) || /\.WWID$/.test(gid))
				typographicFeatures.push("NWID", "WWID");
			if (/\.lnum$/.test(gid) || /\.onum$/.test(gid))
				typographicFeatures.push("lnum", "onum");
		}

		charMap.push([
			glyph.name,
			glyph.unicode,
			typographicFeatures,
			glyph.featureSelector ? Object.keys(glyph.featureSelector) : []
		]);
	}
	await fs.writeFile(argv.oCharMap, JSON.stringify(charMap), "utf8");
}

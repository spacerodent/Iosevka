default: fonts

TARGETUPM = 1000
OBJDIR = build
include makesupport.mk
PREFIX = $(VARIANTNAME)iosevka$(SUFFIX)
ARCPREFIXB = iosevka$(SUFFIX)

# Change this when an error reports
# On windows, maybe `2> NUL`.

ifeq ($(OS),Windows_NT)
SHELL = C:\\Windows\\System32\\cmd.exe
SUPPRESS_ERRORS = 2> NUL
else
SUPPRESS_ERRORS = 2> /dev/null
endif

NODE_FDT = node --expose-gc
NODE = node

UPRIGHT = $(OBJDIR)/$(PREFIX)-thin.ttf $(OBJDIR)/$(PREFIX)-extralight.ttf $(OBJDIR)/$(PREFIX)-light.ttf $(OBJDIR)/$(PREFIX)-regular.ttf $(OBJDIR)/$(PREFIX)-medium.ttf $(OBJDIR)/$(PREFIX)-bold.ttf $(OBJDIR)/$(PREFIX)-heavy.ttf
ITALIC  = $(OBJDIR)/$(PREFIX)-thinitalic.ttf $(OBJDIR)/$(PREFIX)-extralightitalic.ttf $(OBJDIR)/$(PREFIX)-lightitalic.ttf $(OBJDIR)/$(PREFIX)-italic.ttf $(OBJDIR)/$(PREFIX)-mediumitalic.ttf $(OBJDIR)/$(PREFIX)-bolditalic.ttf $(OBJDIR)/$(PREFIX)-heavyitalic.ttf
EXTUPRG = 
EXTITAL = 
OUTPUTS = $(UPRIGHT) $(ITALIC)
TARGETS = $(UPRIGHT) $(ITALIC) $(EXTUPRG) $(EXTITAL)
MAPS    = $(subst .ttf,.charmap,$(TARGETS))


FDTS    = $(subst .ttf,.fdt,$(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(TARGETS)))
SVG0    = $(subst .ttf,.svg,$(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(TARGETS)))

PASS0   = $(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(TARGETS))
ABFEAT  = $(subst .ttf,.ab.fea,$(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(TARGETS)))
FEATURE = $(subst .ttf,.fea,$(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(UPRIGHT) $(EXTUPRG)))
FEATITA = $(subst .ttf,.fea,$(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(ITALIC) $(EXTITAL)))
PASS1   = $(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(TARGETS))
PASS1   = $(subst $(OBJDIR)/,$(OBJDIR)/.pass1-,$(TARGETS))
PASS2   = $(subst $(OBJDIR)/,$(OBJDIR)/.pass2-,$(TARGETS))
PASS3   = $(subst $(OBJDIR)/,$(OBJDIR)/.pass3-,$(TARGETS))
PASS4   = $(subst $(OBJDIR)/,$(OBJDIR)/.pass4-,$(TARGETS))

fonts : $(OUTPUTS)

OUTPUT_FDTS    = $(subst .ttf,.fdt,$(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(OUTPUTS)))
OUTPUT_SVG0    = $(subst .ttf,.svg,$(subst $(OBJDIR)/,$(OBJDIR)/.pass0-,$(OUTPUTS)))

fdts : $(OUTPUT_FDTS)
svgs : $(OUTPUT_SVG0)

	
# Pass 0 : file construction
$(OBJDIR)/.pass0-$(PREFIX)-thin.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-thin s-upright $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-thinitalic.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-thin s-italic $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-extralight.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-extralight s-upright $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-extralightitalic.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-extralight s-italic $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-light.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-light s-upright $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-lightitalic.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-light s-italic $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-regular.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-book s-upright $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-italic.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-book s-italic  $(STYLE_ITALIC) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-medium.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-medium s-upright $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-mediumitalic.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-medium s-italic  $(STYLE_ITALIC) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-bold.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-bold s-upright $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-bolditalic.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-bold s-italic  $(STYLE_ITALIC) $(STYLE_SUFFIX)
#$(OBJDIR)/.pass0-$(PREFIX)-extrabold.fdt : $(SCRIPTS) | $(OBJDIR)
#	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-extrabold s-upright $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
#$(OBJDIR)/.pass0-$(PREFIX)-extrabolditalic.fdt : $(SCRIPTS) | $(OBJDIR)
#	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-extrabold s-italic  $(STYLE_ITALIC) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-heavy.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-heavy s-upright $(STYLE_UPRIGHT) $(STYLE_SUFFIX)
$(OBJDIR)/.pass0-$(PREFIX)-heavyitalic.fdt : $(SCRIPTS) | $(OBJDIR)
	$(NODE_FDT) generate -o $@ iosevka $(STYLE_COMMON) w-heavy s-italic  $(STYLE_ITALIC) $(STYLE_SUFFIX)

$(PASS0) : $(OBJDIR)/.pass0-%.ttf : $(OBJDIR)/.pass0-%.fdt
	$(NODE) extract --upm 16000 --uprightify 1 --ttf $@ $<
$(SVG0) : $(OBJDIR)/.pass0-%.svg : $(OBJDIR)/.pass0-%.fdt
	$(NODE) extract --uprightify 1 --svg $@ $<
$(ABFEAT) : $(OBJDIR)/.pass0-%.ab.fea : $(OBJDIR)/.pass0-%.fdt
	$(NODE) extract --feature $@ $<
$(MAPS) : $(OBJDIR)/%.charmap : $(OBJDIR)/.pass0-%.fdt
	$(NODE) extract --charmap $@ $<
$(FEATURE) : $(OBJDIR)/.pass0-%.fea : $(OBJDIR)/.pass0-%.ab.fea features/common.fea features/uprightonly.fea
	cat $^ > $@
$(FEATITA) : $(OBJDIR)/.pass0-%.fea : $(OBJDIR)/.pass0-%.ab.fea features/common.fea features/italiconly.fea
	cat $^ > $@


# Pass 1 : Outline cleanup and merge
$(PASS1) : $(OBJDIR)/.pass1-%.ttf : pass1-cleanup.py $(OBJDIR)/.pass0-%.svg
	fontforge -quiet -script $^ $@ $(if $(findstring italic,$@),10,0) $(FAST) $(SUPPRESS_ERRORS)
$(PASS2) : $(OBJDIR)/.pass2-%.ttf : pass2-smartround.js $(OBJDIR)/.pass1-%.ttf $(OBJDIR)/.pass0-%.fdt
	$(NODE) $^ -o $@ --upm $(TARGETUPM)
$(PASS3) : $(OBJDIR)/.pass3-%.ttf : pass3-features.py $(OBJDIR)/.pass2-%.ttf $(OBJDIR)/.pass0-%.fea
	fontforge -quiet -script $^ $@ $(TARGETUPM) $(SUPPRESS_ERRORS)
$(PASS4) : $(OBJDIR)/.pass4-%.ttf : pass4-finalize.js $(OBJDIR)/.pass3-%.ttf
	@$(NODE) $^ $@.a.ttf
	@ttx -q -o $@.a.ttx $@.a.ttf $(SUPPRESS_ERRORS)
	@ttx -q -o $@ $@.a.ttx $(SUPPRESS_ERRORS)
	@rm $@.a.ttf $@.a.ttx
$(TARGETS) : $(OBJDIR)/%.ttf : $(OBJDIR)/.pass4-%.ttf
	ttfautohint $< $@

$(OBJDIR) :
	@- mkdir $@

# releaseing
RELEASEDIR = releases
ARCHIVEDIR = release-archives

RELEASES = $(subst $(OBJDIR)/,$(RELEASEDIR)/,$(OUTPUTS))
$(RELEASES) : $(RELEASEDIR)/%.ttf : $(OBJDIR)/%.ttf
	cp $< $@

PAGEDIR = pages/assets
PAGESTTF = $(subst $(OBJDIR)/,$(PAGEDIR)/,$(OUTPUTS))
$(PAGESTTF) : $(PAGEDIR)/%.ttf : $(OBJDIR)/%.ttf
	cp $< $@
PAGESWOFF = $(subst .ttf,.woff,$(PAGESTTF))
$(PAGESWOFF) : $(PAGEDIR)/%.woff : $(PAGEDIR)/%.ttf
	sfnt2woff $<
PAGESMAPS = $(subst $(OBJDIR)/,$(PAGEDIR)/,$(MAPS))
$(PAGESMAPS) : $(PAGEDIR)/%.charmap : $(OBJDIR)/%.charmap
	cp $< $@

$(ARCHIVEDIR)/$(ARCPREFIX)$(ARCPREFIXB)-$(VERSION).tar.bz2 : $(OUTPUTS)
	cd $(OBJDIR) && tar -cjvf ../$@ $(subst $(OBJDIR)/,,$^)
$(ARCHIVEDIR)/$(ARCPREFIX)$(ARCPREFIXB)-$(VERSION).zip : $(OUTPUTS)
	cd $(OBJDIR) && 7z a -tzip ../$@ $(subst $(OBJDIR)/,,$^)

archives : $(ARCHIVEDIR)/$(ARCPREFIX)$(ARCPREFIXB)-$(VERSION).tar.bz2 $(ARCHIVEDIR)/$(ARCPREFIX)$(ARCPREFIXB)-$(VERSION).zip
pages : $(PAGESTTF) $(PAGESWOFF) $(PAGESMAPS)
release : $(RELEASES) archives pages

# testdrive
TESTDIR = testdrive/assets
TESTTTF = $(subst $(OBJDIR)/,$(TESTDIR)/,$(OUTPUTS))
$(TESTTTF) : $(TESTDIR)/%.ttf : $(OBJDIR)/%.ttf
	cp $< $@
TESTWOFF = $(subst .ttf,.woff,$(TESTTTF))
$(TESTWOFF) : $(TESTDIR)/%.woff : $(TESTDIR)/%.ttf
	sfnt2woff $<
OUTMAPS    = $(subst .ttf,.charmap,$(OUTPUTS))
TESTMAPS = $(subst $(OBJDIR)/,$(TESTDIR)/,$(OUTMAPS))
$(TESTMAPS) : $(TESTDIR)/%.charmap : $(OBJDIR)/%.charmap
	cp $< $@

test : $(TESTTTF) $(TESTWOFF) $(TESTMAPS)
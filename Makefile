# Main file 
MAIN := discrete_mathematics

# Directories
CHAPTERSDIR := chapters
OUTPUTDIR := output
OUTPUTCHAPTERSDIR := $(OUTPUTDIR)/chapters

export TEXINPUTS = ../:.:../watermark:

# List of chapter files 
CHAPTERFILES := $(notdir $(wildcard $(CHAPTERSDIR)/*.tex))

# List of chapter PDFs that will be created (in OUTPUTCHAPTERSDIR)
CHAPTERPDFS := $(addprefix $(OUTPUTCHAPTERSDIR)/, $(CHAPTERFILES:.tex=.pdf))

.PHONY: all delete clean cleanall

# The "all" target builds both the main document and chapters
all: main chapters

# ---------------------------------------
# Main document compilation
# ---------------------------------------
main:	$(OUTPUTDIR) $(OUTPUTDIR)/$(MAIN).pdf

$(OUTPUTDIR):
	mkdir -p $(OUTPUTDIR)

$(OUTPUTDIR)/$(MAIN).pdf: $(MAIN).tex preamble.tex watermark/watermark.tex $(addprefix $(CHAPTERSDIR)/, $(CHAPTERFILES)) | $(OUTPUTDIR)
	latexmk -pdf -output-directory=$(OUTPUTDIR) $<

# ---------------------------------------
# Chapters compilation target (phony)
# This compiles only those chapter files that have changed and moves the PDFs to OUTPUTCHAPTERSDIR
# ---------------------------------------
chapters: $(OUTPUTCHAPTERSDIR) $(CHAPTERPDFS)

$(OUTPUTCHAPTERSDIR):
	mkdir -p $(OUTPUTCHAPTERSDIR)

$(OUTPUTCHAPTERSDIR)/%.pdf: $(CHAPTERSDIR)/%.tex preamble.tex watermark/watermark.tex | $(OUTPUTCHAPTERSDIR)
	latexmk -pdf -output-directory=$(OUTPUTCHAPTERSDIR) $<
# ---------------------------------------
# Delete auxiliary files recursively after building
# ---------------------------------------
delete: all
	$(MAKE) clean
	@echo "Build complete. Auxiliary files were deleted recursively..."

# ---------------------------------------
# Clean auxiliary files (from latexmk and chapter directory)
# ---------------------------------------
clean:
	-@latexmk -C
	@find . -type f \
	    \( -name '*.aux' -o -name '*.log' -o -name '*.fls' \
	    -o -name '*.fdb_latexmk' -o -name '*.out' -o -name '*.toc' \
	    \) -delete
	@clear

# ---------------------------------------
# Clean everything including generated PDFs and output directory
# ---------------------------------------
cleanall: clean
	rm -f $(MAIN).pdf $(CHAPTERSDIR)/*.pdf
	rm -rf $(OUTPUTDIR)
	clear


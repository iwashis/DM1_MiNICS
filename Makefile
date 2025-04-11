# Main file 
MAIN = discrete_mathematics

# Directories
CHAPTERSDIR = chapters
OUTPUTDIR = output
OUTPUTCHAPTERSDIR = $(OUTPUTDIR)/chapters

export TEXINPUTS = ../:.:../watermark:

# List of chapter files 
CHAPTERFILES = Catalan_Numbers.tex Counting.tex Functions_between_sets.tex \
               Generating_functions.tex Inclusion_Exclusion.tex \
               Partitions_StirlingNumbers.tex Permutations_Derangements.tex \
               Preparation_tasks1.tex Preparation_tasks2.tex

# List of chapter PDFs that will be created (in OUTPUTCHAPTERSDIR)
CHAPTERPDFS = $(addprefix $(OUTPUTCHAPTERSDIR)/, $(CHAPTERFILES:.tex=.pdf))

.PHONY: all main chapters delete clean cleanall

# The "all" target builds both the main document and chapters
all: main chapters

# ---------------------------------------
# Main document compilation
# ---------------------------------------
main: $(MAIN).tex preamble.tex watermark/watermark.tex $(addprefix $(CHAPTERSDIR)/, $(CHAPTERFILES))
	latexmk -pdf $(MAIN).tex
	mkdir -p $(OUTPUTDIR)
	mv $(MAIN).pdf $(OUTPUTDIR)/

# ---------------------------------------
# Chapters compilation target (phony)
# This compiles only those chapter files that have changed and moves the PDFs to OUTPUTCHAPTERSDIR
# ---------------------------------------
chapters: $(OUTPUTCHAPTERSDIR) $(CHAPTERPDFS)

$(OUTPUTCHAPTERSDIR):
	mkdir -p $(OUTPUTCHAPTERSDIR)

$(OUTPUTCHAPTERSDIR)/%.pdf: $(CHAPTERSDIR)/%.tex
	latexmk -cd -pdf $<
	mv $(CHAPTERSDIR)/$*.pdf $@

# ---------------------------------------
# Delete auxiliary files recursively after building
# ---------------------------------------
delete: all
	@echo "Build complete. Now deleting auxiliary files recursively..."
	@bash -c 'find . -type f \( -name "*.log" -o -name "*.fls" -o -name "*.fdb_latexmk" -o -name "*.toc" -o -name "*.aux" \) -delete'

# ---------------------------------------
# Clean auxiliary files (from latexmk and chapter directory)
# ---------------------------------------
clean:
	latexmk -C
	rm -f $(CHAPTERSDIR)/*.aux $(CHAPTERSDIR)/*.log $(CHAPTERSDIR)/*.fls $(CHAPTERSDIR)/*.fdb_latexmk

# ---------------------------------------
# Clean everything including generated PDFs and output directory
# ---------------------------------------
cleanall: clean
	rm -f $(MAIN).pdf $(CHAPTERSDIR)/*.pdf
	rm -rf $(OUTPUTDIR)


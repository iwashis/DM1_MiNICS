# Main file
MAIN = discrete_mathematics

# Directories
CHAPTERSDIR = chapters
OUTPUTDIR = output
OUTPUTCHAPTERSDIR = $(OUTPUTDIR)/chapters

# Chapter files
CHAPTERFILES = Catalan_Numbers.tex Counting.tex Functions_between_sets.tex \
               Generating_functions.tex Inclusion_Exclusion.tex \
               Partitions_StirlingNumbers.tex Permutations_Derangements.tex

# Full paths for chapter files
CHAPTERS = $(addprefix $(CHAPTERSDIR)/, $(CHAPTERFILES))

# All targets
all: main chapters

# Main target compiles just the main document
main: $(OUTPUTDIR)/$(MAIN).pdf

# Chapters target compiles all individual chapter PDFs
chapters: $(OUTPUTCHAPTERPDFS)

# Chapter PDFs with output paths
OUTPUTCHAPTERPDFS = $(addprefix $(OUTPUTCHAPTERSDIR)/, $(CHAPTERPDFS))
CHAPTERPDFS = $(CHAPTERFILES:.tex=.pdf)

# Main document compilation
$(OUTPUTDIR)/$(MAIN).pdf: $(MAIN).tex $(CHAPTERS) preamble.tex
	latexmk -pdf $(MAIN).tex
	mkdir -p $(OUTPUTDIR)
	cp $(MAIN).pdf $(OUTPUTDIR)/

# Compile each chapter individually
define compile_chapter
$(OUTPUTCHAPTERSDIR)/$(1:.tex=.pdf): $(CHAPTERSDIR)/$(1)
	mkdir -p $(OUTPUTCHAPTERSDIR)
	TEXINPUTS=.:./$(CHAPTERSDIR): latexmk -pdf $(CHAPTERSDIR)/$(1)
	cp $(CHAPTERSDIR)/$(1:.tex=.pdf) $(OUTPUTCHAPTERSDIR)/
endef

# Generate rules for each chapter
$(foreach ch,$(CHAPTERFILES),$(eval $(call compile_chapter,$(ch))))

# Clean up auxiliary files
clean:
	latexmk -C
	rm -f $(CHAPTERSDIR)/*.aux $(CHAPTERSDIR)/*.log $(CHAPTERSDIR)/*.fls $(CHAPTERSDIR)/*.fdb_latexmk

# Clean everything including PDFs
cleanall: clean
	rm -f *.pdf $(CHAPTERSDIR)/*.pdf
	rm -rf $(OUTPUTDIR)

.PHONY: all main chapters clean cleanall

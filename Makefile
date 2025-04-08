# Main file (adjust to match your file’s actual name)
MAIN = discrete_mathematics

# Directories
CHAPTERSDIR = chapters
OUTPUTDIR = output
OUTPUTCHAPTERSDIR = $(OUTPUTDIR)/chapters

export TEXINPUTS = ../:.:../watermark:

# List of chapter files (exact filenames)
CHAPTERFILES = Catalan_Numbers.tex Counting.tex Functions_between_sets.tex \
               Generating_functions.tex Inclusion_Exclusion.tex \
               Partitions_StirlingNumbers.tex Permutations_Derangements.tex \
               Preparation_tasks1.tex

.PHONY: all main chapters clean cleanall

# The "all" target builds both the main document and chapters
all: main chapters

# ---------------------------------------
# Main document compilation
# ---------------------------------------
# Main document compilation
main: $(MAIN).tex preamble.tex watermark/watermark.tex $(addprefix $(CHAPTERSDIR)/, $(CHAPTERFILES))
	latexmk -pdf $(MAIN).tex
	mkdir -p $(OUTPUTDIR)
	cp $(MAIN).pdf $(OUTPUTDIR)/


# ---------------------------------------
# Chapters compilation target (phony)
# This compiles every chapter file and copies the PDF to output/chapters/
# ---------------------------------------
chapters:
	mkdir -p $(OUTPUTCHAPTERSDIR)
	@for file in $(CHAPTERFILES); do \
	  echo "Compiling $$file"; \
	  latexmk -cd -pdf $(CHAPTERSDIR)/$$file; \
	  pdfname=`echo $$file | sed 's/\.tex$$/.pdf/'`; \
	  cp $(CHAPTERSDIR)/$$pdfname $(OUTPUTCHAPTERSDIR)/; \
	done

# ---------------------------------------
# Clean auxiliary files (from latexmk and chapter directory)
# ---------------------------------------
clean:
	latexmk -C
	rm -f $(CHAPTERSDIR)/*.aux $(CHAPTERSDIR)/*.log $(CHAPTERSDIR)/*.fls $(CHAPTERSDIR)/*.fdb_latexmk
	rm -f *.log
	rm -f *.fls
	rm -f *.fdb_latexmk
# ---------------------------------------
# Clean everything including generated PDFs and output directory
# ---------------------------------------
cleanall: clean
	rm -f $(MAIN).pdf $(CHAPTERSDIR)/*.pdf
	rm -rf $(OUTPUTDIR)
		rm -f *.log
	rm -f *.fls
	rm -f *.fdb_latexmk

MPFILES := $(foreach file, $(basename $(wildcard feynmandiag/*mp)), $(file).1)

all: Thesis.pdf

# Don't try to compile feynmp.mp
feynmandiag/feynmp.1:
	true

feynmandiag/%.1: feynmandiag/%.mp
	cd feynmandiag && mpost $*

Thesis.gls:
	makeglossaries Thesis

Thesis.bbl: Thesis.bib
	bibtex Thesis

Thesis.aux: Thesis.tex $(MPFILES)
	pdflatex Thesis.tex

Thesis.aux_draft: Thesis.tex Thesis.gls $(MPFILES)
	pdflatex Thesis.tex -draftmode

Thesis.pdf: Thesis.aux Thesis.gls Thesis.bbl
	pdflatex Thesis.tex -draftmode
	pdflatex Thesis.tex


draft: Thesis.aux_draft Thesis.bbl
	pdflatex Thesis.tex -draftmode 
	pdflatex Thesis.tex -draftmode

clean: cleandiag
	rm -f *.aux *.log *.out *.dvi *.toc *.lof *.lot *.bbl *.blg *.gls *.glo *.glsdefs

cleandiag:
	rm -f feynmnandiag/ccqe.* feynmnandiag/mec.* feynmnandiag/coh.* 
	rm -f feynmnandiag/respion.* feynmnandiag/dis.* 
	rm -f feynmnandiag/*direct*.* feynmnandiag/pionex.*
	rm -f feynmnandiag/anomaly.* feynmnandiag/contact.*
	rm -f feynmandiag/qsqw.*

all: refguide.pdf
refguide.dvi: refguide.tex
	latex refguide.tex
	latex refguide.tex
refguide.pdf: refguide.dvi
	dvipdfm -p a4 refguide.dvi
clean:
	rm -f *.pdf *.dvi *~ *.aux *.log *.blg *.end *.bbl


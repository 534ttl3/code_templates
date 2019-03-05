main.pdf : main-crop.pdf
	mv main-crop.pdf main.pdf

main-crop.pdf : main.aux
	pdfcrop main.pdf

main.aux : main.tex
	-latexmk -pdf -latex=lualatex main.tex

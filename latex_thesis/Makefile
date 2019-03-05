all : 
	-latexmk -pdf -pdflatex=lualatex main.tex
	-makeglossaries main
	-latexmk -pdf -pdflatex=lualatex main.tex -g

clean : 
	-latexmk -CA
	-find . -name "*.bbl" -o -name "*.run.xml" -o -name "*.aux" | xargs rm
	-rm titlepage.tex explanation.tex glossaries.tex

remake : 
	make clean
	make all

glossaryFiles = main.lof main.lot \
				main.syg main.acn \
				main.glo main.glsdefs main.ist \
				main.feg  main.fei  main.felg \
				main.mtg  main.mti  main.mtlg

main.pdf : main.aux $(glossaryFiles)
	latexmk -pdf -pdflatex=lualatex main.tex

$(glossaryFiles) : main.aux
# Then make index files, which are later inserted in the last run
	makeglossaries main

main.aux : main.tex
# only one compile step, creates main.aux, which makeglossaries needs
	lualatex main.tex 

.PHONY : clean redoeverything

clean : 
	-latexmk -CA
	-find . -name "*.bbl" -o -name "*.run.xml" -o -name "*.aux" | xargs rm
	-find . -name "*.feg" -o -name "*.fei" -o -name "*.felg" -o -name "*.mtg" -o -name "*.mti" -o -name "*.mtlg" | xargs rm

redoeverything : 
	make clean
	make	

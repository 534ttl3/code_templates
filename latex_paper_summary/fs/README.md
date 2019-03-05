### Compilation instructions

If you are in the "whole" folder, do 
```
cd listings
# assuming you have also cloned the code repo
# the appropriate commit is cdb8050
ln -s ~/projects/dlw  
cd ..
# clean up (almost) every auto-generated file
latexmk -CA
# first run of latexmk, a.o. prepares the glossaries' indices
latexmk -pdf -pdflatex=lualatex main.tex
# now, some preliminary glossary files have been 
# generated, but the glossaries don't appear yet in the 
# generated pdf output. 
# To change that, run this simple command on your main.tex file, 
# to generate even more glossary-related files
makeglossaries main
# now reprocess everything to produce the final document
# the -g option forces latexmk to reprocess the entire document, 
# so that the glossaries are now also being integrated
latexmk -pdf -pdflatex=lualatex main.tex -g
```

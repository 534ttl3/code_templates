# Compilation instructions

Clean up auto-generated files

```
latexmk -CA
find . -name "*.bbl" -o -name "*.run.xml" -o -name "*.aux" | xargs rm
rm titlepage.tex explanation.tex glossaries.tex
```

Then, run latexmk for the 1st time, a.o. preparing the glossaries' indices

```
latexmk -pdf -pdflatex=lualatex main.tex
```

Now, some preliminary glossary files have been generated, but the glossaries don't appear yet in the generated pdf output.  To change that, run this simple command on your main.tex file, to generate even more glossary-related files.

```
makeglossaries main
```

Now reprocess everything to produce the final document the -g option forces latexmk to reprocess the entire document, so that the glossaries are now also being integrated.

```
latexmk -pdf -pdflatex=lualatex main.tex -g
```

All of these instructions are packaged up in a Makefile. To clean up all
auto-generated files, use 

```
make clean
```
Then use  

```
make
```
or

```
make all
```

to go through the whole build process. By running

```
make remake
```

you automatically run

```
make clean 
make all
```

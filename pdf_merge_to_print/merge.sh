#!/bin/bash

cat<<EoF > all.tex
\documentclass{article}
\usepackage{pdfpages}
\begin{document}
EoF

## rename the PDFs to something safe
c=0;
for f in *pdf
do
        ## Link the PDF with a safe name
        ln -s "$f" "$c".pdf
        ## Include the PDF in the tex file
        printf '\includepdf[pages=-]{%s.pdf}\n' "$c" >> all.tex;
        ## Get the number of pages
        pages=$(pdfinfo "$c".pdf | grep -oP '^Pages:\s*\K\d+')
        ## Add an empty page if they are odd
        [[ $(expr "$pages" % 2) != 0 ]] && 
            printf '%s\n' "\newpage\null" >> all.tex

        ((c++));
done

printf '\\end{document}' >> all.tex;
pdflatex all.tex

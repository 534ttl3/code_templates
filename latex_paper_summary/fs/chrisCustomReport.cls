\NeedsTeXFormat{LaTeX2e}[2018/03/01]
\ProvidesClass{chrisCustomReport}[2018/05/26 chrisCustomReport LaTeX class]

\LoadClass[twoside,11pt,DIV=15,BCOR=20mm,listof=totoc,listof=leveldown,captions=tableheading, twocolumn]{scrreprt}

\usepackage[automark,headsepline,footsepline]{scrlayer-scrpage}
%\addtokomafont{headsepline}{\color{blue}}
%\addtokomafont{footsepline}{\color{orange}}

\RequirePackage{kvoptions}
\DeclareStringOption[./bib/references.bib]{bibfilename}[./bib/references.bib]
\DeclareStringOption[./graphics/]{graphicspath}[./graphics/]
\DeclareStringOption[./listings/]{listingspath}[./listings/]
\DeclareStringOption[english]{chosenlanguage}[english]
\ProcessKeyvalOptions*

\def\german{german}

%{{{ Preamble
\RequirePackage{fontspec} % Schriftumschaltung mit den nativen XeTeX-Anweisungen
                      % vornehmen. Voreinstellung: Latin Modern
\ifx\chrisCustomReport@chosenlanguage\german
    \RequirePackage[ngerman]{babel} % Sprachumschaltung: Deutsch nach neuer Rechtschreibung
\else
    \RequirePackage[english]{babel}
\fi
\RequirePackage[left=1cm, right=1cm, bottom=3cm, top=3cm]{geometry}
\ifx\chrisCustomReport@chosenlanguage\german
    \RequirePackage[ngerman]{datetime}
\else
    \RequirePackage{datetime}
\fi 
\RequirePackage{microtype} % dnk
\RequirePackage{amsmath} % text, mathrm
\RequirePackage{amsfonts} % dnk
\RequirePackage{amssymb} % dnk
\RequirePackage{mathtools} % dnk
\RequirePackage{calc} % dnk
\RequirePackage{graphicx} % includegraphics, probably also input
\graphicspath{{./}{\chrisCustomReport@graphicspath}} % relative file path for graphics
\RequirePackage{xcolor} % dnk
\RequirePackage{color} % for eps (specifically when exported with inkscape)
\RequirePackage{import}
\RequirePackage{pgfplots}
%\pgfplotsset{compat=1.15}  % for backwards-compatibility
%\RequirePackage{floatrow}  % this is a very good package but a lot to learn
%\floatsetup[table]{capposition=top}  % caption position with floatrow (overrides KOMA-settings)
\RequirePackage{subfig}
%\RequirePackage[margin=10pt,font=small,labelfont=bf,format=plain]{caption} % customize captions
%\captionsetup[table]{position=above}
\RequirePackage{upgreek} % for upright pi, etc, but you have to specify it yourself

\ifx\chrisCustomReport@chosenlanguage\german
    \RequirePackage[autostyle=true,german=quotes]{csquotes} % for literal quotes
\else
    \RequirePackage[autostyle=true]{csquotes} % for literal quotes
\fi 

\RequirePackage{booktabs}
%\setlength{\abovecaptionskip}{10pt} % proper spacing
%\setlength{\belowcaptionskip}{10pt} % proper spacing 
\RequirePackage{array}  % for \newcolumntype macro
\newcolumntype{L}{>{$}l<{$}}  % math-mode version of "l" column type
\newcolumntype{R}{>{$}r<{$}}  % math-mode version of "l" column type
\RequirePackage{siunitx}
\RequirePackage{physics}
\RequirePackage{enumerate} % customizable enumerations (1), (i), ...
\RequirePackage[shortlabels]{enumitem} % customizable enumerations (1), (i), ...
\RequirePackage{hyperref}

\ifx\chrisCustomReport@chosenlanguage\german
    \RequirePackage[ngerman]{cleveref} % automatisch tab., abb, ... hinschreiben
\else
    \RequirePackage{cleveref} % automatisch tab., abb, ... hinschreiben
\fi 

%{{{ cleverref settings 
\crefname{figure}{Abb.}{Abb.}
\crefname{equation}{Gl.}{Gl.}
%\crefname{lstlisting}{listing}{listings}
\crefname{lstlisting}{Listing}{Listings}
%}}}
\RequirePackage[backend=biber, style=alphabetic, sorting=nyt]{biblatex}
\addbibresource{\chrisCustomReport@bibfilename}

%{{{ code listings settings
% --- begin code listings ---
\RequirePackage{accsupp} % for code listings to make line numbers not copiable
\RequirePackage{listings}
% Default fixed font does not support bold face
\DeclareFixedFont{\ttb}{T1}{txtt}{bx}{n}{10} % for bold
\DeclareFixedFont{\ttm}{T1}{txtt}{m}{n}{10}  % for normal
% Custom colors, requires \RequirePackage{color}
\definecolor{numberinggray}{rgb}{0.3,0.3,0.3}
\definecolor{deepblue}{rgb}{0,0,0.5}
\definecolor{deepred}{rgb}{0.6,0,0}
\definecolor{deepgreen}{rgb}{0,0.5,0}
\definecolor{commentred}{rgb}{1,0,0}
\lstset{
language=Python,
basicstyle=\ttm,
otherkeywords={self},             % Add keywords here
keywordstyle=\ttb\color{deepblue},
emphstyle=\ttb\color{deepred},    % Custom highlighting style
stringstyle=\color{deepgreen},
numbers=left,                    
numbersep=5pt,                  
numberstyle=\tiny\color{numberinggray}\noncopynumber,
stepnumber=1,
%columns=fixed, % when using a fixed-width char font, inserts spaces to accomodate
columns=flexible, % when using a non-fixed width char font
keepspaces=true,
linewidth=80pt, 
commentstyle=\color{commentred}, 
}
\newcommand{\noncopynumber}[1]{% make code line numbers unselectable (in some pdf viewers)
    \BeginAccSupp{method=escape,ActualText={}}% requires \RequirePackage{accsupp} 
    #1%
    \EndAccSupp{}%
}
\lstset{inputpath=\chrisCustomReport@listingspath}% relative file path for listings
%}}}

\RequirePackage{floatpag}  % altering the pagestyle where a particular float appears
\RequirePackage[figuresright]{rotating}  % sidewaysfigure

% --- Abkürzungsverzeichnis, Symbolverzeichnis
\RequirePackage[nonumberlist, %keine Seitenzahlen anzeigen
acronym,      %ein Abkürzungsverzeichnis erstellen
toc,          %Einträge im Inhaltsverzeichnis
section,
nopostdot]
{glossaries}  % first run latex, then run "$ makeglossaries main" then run latex again

%Ein eigenes Symbolverzeichnis erstellen

\ifx\chrisCustomReport@chosenlanguage\german
    \def\listofsymbolslabel{Symbolverzeichnis}
    \def\listofmaintakeawayslabel{Erkenntnisse}
    \def\listoffigureexplanationslabel{Abbildungen}
    \def\mainglossarylabel{Sonstige Begriffe}
    \def\listofacronymslabel{Abkürzungsverzeichnis}
\else
    \def\listofsymbolslabel{List of Symbols}
    \def\listofmaintakeawayslabel{Main Takeaways}
    \def\listoffigureexplanationslabel{Figures}
    \def\mainglossarylabel{Misc. Terms}
    \def\listofacronymslabel{List of Acronyms}
\fi 

\newglossary[slg]{symbolslist}{syi}{syg}{\listofsymbolslabel}
\newglossary[mtlg]{maintakeawayslist}{mti}{mtg}{\listofmaintakeawayslabel}
\newglossary[felg]{figureexplanationslist}{fei}{feg}{\listoffigureexplanationslabel}

\makeglossaries % must occur after including hyperref 

% --- KOMA script settings
\setcapindent{0pt}
%\addtokomafont{caption}{\centering}
\addtokomafont{captionlabel}{\bfseries}
\addtokomafont{disposition}{\rmfamily}  % computer modern headings like in the
% standard classes

\newcommand{\snote}[1]{{\scriptsize \textcolor{red}{\textbf{#1}}}}


\newcommand*\customsignature[2][5cm]{\vspace*{1.5cm}\parbox{#1}{\hrulefill\par#2}}

% \RequirePackage[]{showframe}
%}}}

\def\printTocAndGlossaries{
%\tableofcontents
%\clearpage
%\thispagestyle{empty}
%\listoffigures
%\listoftables
\begin{mdframed}
\printglossary[type=maintakeawayslist]
\end{mdframed}
\begin{mdframed}
\printglossary[type=figureexplanationslist]
\end{mdframed}
\begin{mdframed}
\printglossary[type=symbolslist]
\end{mdframed}
\begin{mdframed}
\printglossary[type=\acronymtype, title={\listofacronymslabel}]
\end{mdframed}
\begin{mdframed}
\printglossary[title={\mainglossarylabel}]  % main glossary
\end{mdframed}
}


\RequirePackage[linecolor=white!60!black, topline=true, bottomline=false, rightline=false, linewidth=2pt]{mdframed} % put boxes around text

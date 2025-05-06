%#######################################################################
%#######################################################################
%   CLASS DrKaepsele
%#######################################################################
%#######################################################################
\newcommand\fileversion{1.0}
\newcommand\filedate{02/02/2025}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{DrKaepsele}[\filedate\space A simple PhD thesis class 
based on scrbook by Pascal Becht (v\fileversion)]

%=======================================================================
%   BASIC OPTIONS
%=======================================================================

% Font Size
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{scrbook}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{scrbook}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{scrbook}}

% Page Size
\newcommand\paper{a4paper}
\DeclareOption{a4paper}{\renewcommand\paper{a4paper}}
%\DeclareOption{a5paper}{\renewcommand\paper{a5paper}}
\PassOptionsToClass{\paper}{scrbook}

% Draft
\DeclareOption{draft}{\PassOptionsToClass{draft}{scrbook}}

%=======================================================================
%   CUSTOM OPTIONS
%=======================================================================

% Define a boolean flag for print
\newif\if@print\@printfalse
\DeclareOption{print}{\@printtrue}

% Process options
\ProcessOptions\relax

%=======================================================================
%   INPUT
%=======================================================================

\RequirePackage[utf8]{inputenc} % utf8 input encoding
\RequirePackage[T1]{fontenc}		% latin, central European letters [T1]

%=======================================================================
%   LAYOUT
%=======================================================================

% One or two sided document
\newcommand\layout{twoside}
\if@print
  \renewcommand\layout{twoside}
\else
  \renewcommand\layout{oneside}
\fi
\PassOptionsToClass{\layout}{scrbook}

% Load base class (scrbook)
\LoadClass{scrbook}

% General layout settings
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
\setlength{\abovecaptionskip}{2mm}
\setlength{\belowcaptionskip}{0mm}

% Blankpage
\newcommand*{\blankpage}{
 \clearpage\thispagestyle{empty}\null\newpage
}

\newcommand*{\condblankpage}{%
  \if@print
    \clearpage
    \thispagestyle{empty}
    \null
    \newpage
  \fi
}

\if@print
  \KOMAoptions{open=right}  % Enforce chapters on odd pages when printing
\else
  \KOMAoptions{open=any}    % Allow chapters to start on any page when not printing
\fi

% Pagestyle
%\PassOptionsToPackage{automark}{scrlayer-scrpage}
\PassOptionsToPackage{headsepline=0.4pt}{scrlayer-scrpage}
\RequirePackage{scrlayer-scrpage} % Use scrlayer-scrpage instead of fancyhdr
\clearpairofpagestyles
\setkomafont{pagehead}{\normalfont}
\newpairofpagestyles[scrheadings]{printstyle}{
	\ohead[]{\headmark}
	\ihead*{}
	\chead*{}
	\ofoot[]{\pagemark}
	\ifoot*{}
	\cfoot*{}
}
\newpairofpagestyles[scrheadings]{printstylechap}{
	\ohead*{}
	\ihead*{}
	\chead*{}
	\ofoot[]{\pagemark}
	\ifoot*{}
	\cfoot*{}
  \setkomafont{headsepline}{\color{white}} % Get rid of headsepline for chapter beginning
}
\newpairofpagestyles[scrheadings]{onlinestyle}{
	\ohead*{}
	\ihead[]{\rightmark}
	\chead*{}
	\ofoot[]{\pagemark}
	\ifoot*{}
	\cfoot*{}
}
\newpairofpagestyles[scrheadings]{onlinestylechap}{
	\ohead*{}
	\ihead*{}
	\chead*{}
	\ofoot[]{\pagemark}
	\ifoot*{}
	\cfoot*{}
  \setkomafont{headsepline}{\color{white}} % Get rid of headsepline for chapter beginning
}
\newpairofpagestyles[scrheadings]{abstractstyle}{
	\ohead*{}
	\ihead*{}
	\chead*{}
	\ofoot[]{\pagemark}
	\ifoot*{}
	\cfoot*{}
  \setkomafont{headsepline}{\color{white}}
}
\if@print
  \pagestyle{printstyle}
  \renewcommand{\chapterpagestyle}{printstylechap}
\else
  \makeatletter
  \def\sectionmark#1{\markboth{\thechapter.\ \thesection\ #1}{\thesection\ #1}}
  \def\subsectionmark#1{\markboth{\thechapter.\ \thesection\ \thesubsection\ #1}{\thesection\ \thesubsection\ #1}}
  \makeatother
  \pagestyle{onlinestyle}
  \renewcommand{\chapterpagestyle}{onlinestylechap}
\fi

% Chapter titles
\addtokomafont{chapter}{{
  %\color{gray}
  \rule{\textwidth}{2pt}}\\} % Thick line above
\renewcommand{\chapterformat}{
  {\normalfont\huge\bfseries Chapter \thechapter\autodot\enskip} % Chapter number
  \par\nobreak
  \vspace{0.5\baselineskip} % Space between number and title
}

\renewcommand{\chapterlinesformat}[3]{%
  #2
  #3 % Actual chapter title
  \par\vspace{-1.0\baselineskip}
  \begin{center}
    \rule{\textwidth}{1pt} % Thin line below  
  \end{center}
  \vspace{-0.2\baselineskip}
}

%=======================================================================
%   ENVIRONMENTS
%=======================================================================

% Abstract
\newcommand{\abstracttitle}{Abstract} % Default title
\newcommand{\doctitle}{Document title} % Document title

\RequirePackage{ragged2e}
\newenvironment{Kabstract}{
  \chapter*{
    \vspace{-1.4\baselineskip}
    \begin{center}
      \normalfont\Large\bfseries \abstracttitle
    \end{center}
    \vspace{-0.4\baselineskip}
  }
  \addcontentsline{toc}{chapter}{\abstracttitle}
  \renewcommand{\refname}{\abstracttitle}
  \begin{center}
  \begin{minipage}{0.9\textwidth}
      \begin{RaggedRight}
        \setlength{\parindent}{0pt}\normalfont\large\bfseries \doctitle \hfill
      \end{RaggedRight}
    \end{minipage}
  \end{center}
  \begingroup
  \leftskip=0.05\textwidth \rightskip=0.05\textwidth % Adjust text width
  \par\vspace{0.5\baselineskip}\setlength{\parindent}{0pt}
}
{\par\endgroup\vspace{\baselineskip}}

% Nomenclature
\RequirePackage[]{glossaries}
\renewcommand{\glsnamefont}[1]{\textbf{#1}} 
\setglossarystyle{super}
\setacronymstyle{long-short}
\setglossarysection{section}
\renewcommand*{\glossarysection}[2][]{}
\renewcommand{\glossaryname}{Nomenclature}
\makeglossaries

% Bibliography
\RequirePackage[backend=biber,style=numeric,sorting=none]{biblatex}
\DeclareFieldFormat{url}{\mkbibacro{URL}\addcolon\space\href{#1}{#1}}
\DeclareFieldFormat{doi}{\mkbibacro{DOI}\addcolon\space\href{https://doi.org/#1}{#1}}

% Declarations
\newcommand{\dectitle}{Declaration of originality}
\newcommand{\decsigname}{FirstName LastName}
\newcommand{\decplace}{Some place}
\newcommand{\decdate}{\today}
\newcommand{\declabels}{Place, Date \hfill Author}

\newenvironment{Kdeclaration}{
  \chapter*{
    \vspace{-1.4\baselineskip}
    \begin{center}
      \normalfont\Large\bfseries \dectitle
    \end{center}
    \vspace{-0.4\baselineskip}
  }
  \addcontentsline{toc}{chapter}{\dectitle}
  \renewcommand{\refname}{\dectitle}
  \begingroup
  \leftskip=0.05\textwidth \rightskip=0.05\textwidth % Adjust text width
  \par\vspace{0.5\baselineskip}\setlength{\parindent}{0pt}
}
{
  \par\endgroup
  \vspace{4\baselineskip}
  \begin{minipage}{0.9\textwidth}
    \decplace, \decdate \hfill \decsigname \\
    {\color{gray}\rule{\textwidth}{0.5pt}} \\
    {\small \declabels}
  \end{minipage}
}

%=======================================================================
%   PACKAGES
%=======================================================================

% Geometry
\PassOptionsToPackage{top=2.5cm,bottom=3.2cm,left=2.5cm,right=2.5cm}{geometry}
\if@print % Binding offset for print version
  \PassOptionsToPackage{bindingoffset=10mm}{geometry}
\else
  \PassOptionsToPackage{bindingoffset=0mm}{geometry}
\fi
\RequirePackage{geometry} % Finally loads package

% Hyperref
\RequirePackage[unicode=true]{hyperref}
\if@print
  \hypersetup{
    final=true,
    plainpages=false,
    pdfstartview=FitV,
    pdftoolbar=true,
    pdfmenubar=true,
    bookmarksopen=true,
    bookmarksnumbered=true,
    breaklinks=true,
    linktocpage,
    colorlinks=true,
    linkcolor=black,
    urlcolor=black,
    citecolor=black,
    anchorcolor=black
  }
\else
  \hypersetup{
    final=true,
    plainpages=false,
    pdfstartview=FitV,
    pdftoolbar=true,
    pdfmenubar=true,
    bookmarksopen=true,
    bookmarksnumbered=true,
    breaklinks=true,
    linktocpage,
    colorlinks=true,
    linkcolor=blue,
    urlcolor=blue,
    citecolor=blue,
    anchorcolor=green
  }
\fi
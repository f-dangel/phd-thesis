\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{preamble/thesis}[2021/07/14 v0.0.1 Thesis]

\LoadClassWithOptions{preamble/kaobook}

%----------------------------------------------------------------------------------------
%	CUSTOM FRONT-, MAIN-, BACK- MATTERS BEHAVIOUR
%----------------------------------------------------------------------------------------


% CHANGED: AUTOMATICALLY USE CUSTOMKAO WHEN IN MAIN MATTER
% Main matter
\let\kaomainmatter\mainmatter % Store the old command
\renewcommand{\mainmatter}{%
	\kaomainmatter% Call the old command
	\pagestyle{scrheadings}% Use a fancy style for the header and the footer
	\pagelayout{margin}% Use a 1.5 column layout
	\setchapterstyle{customkao} % Choose the default chapter heading style
}

%----------------------------------------------------------------------------------------
%	CUSTOM CHAPTER HEADING STYLES
%----------------------------------------------------------------------------------------

% CHANGED: INCLUDE CUSTOMKAO
\DeclareDocumentCommand{\setchapterstyle}{m}{%
	\ifthenelse{\equal{plain}{#1}}{\chapterstyleplain}{}
	\ifthenelse{\equal{bar}{#1}}{\chapterstylebar}{}
	\ifthenelse{\equal{lines}{#1}}{\chapterstylelines}{}
	\ifthenelse{\equal{kao}{#1}}{\chapterstylekao}{}
	\ifthenelse{\equal{customkao}{#1}}{\chapterstylecustomkao}{}
}

% The Custom Kao style
% CHANGED: COLORED NUMBER AN LINE
% CHANGED: THICKER LINE
\DeclareDocumentCommand{\chapterstylecustomkao}{}{%
	\renewcommand*{\chapterformat}{%
		\mbox{\chapappifchapterprefix{\nobreakspace}\scalebox{2.85}{\color{maincolor}\thechapter\autodot}}%
	}%
	\renewcommand\chapterlinesformat[3]{%
		\vspace{3.5\vscale}%
		\if@twoside%
		\Ifthispageodd{%
			\smash{\makebox[0pt][l]{%
					\parbox[b]{\textwidth}{\flushright{##3}}%
					\makebox[\marginparsep][c]{\color{maincolor}\rule[-2\vscale]{2pt}{27.4\vscale+\f@size mm}}%
					\parbox[b]{\marginparwidth}{##2}%
			}}%
		}{
			\smash{\makebox[\textwidth][r]{%
					\parbox[b]{\marginparwidth}{\flushright{##2}}%
					\makebox[\marginparsep][c]{\color{maincolor}\rule[-2\vscale]{2pt}{27.4\vscale+\f@size mm}}%
					\parbox[b]{\textwidth}{\flushleft{##3}}%
			}}%
		}
		\else%
		\smash{\makebox[0pt][l]{%
				\parbox[b]{\textwidth}{\flushright{##3}}%
				\makebox[\marginparsep][c]{\color{maincolor}\rule[-2\vscale]{2pt}{27.4\vscale+\f@size mm}}%
				\parbox[b]{\marginparwidth}{##2}%
		}}%
		\fi%
	}%
	\RedeclareSectionCommand[beforeskip=0cm,afterskip=10\vscale]{chapter}%
	\setlength{\mtocshift}{-3\vscale}%
}

%----------------------------------------------------------------------------------------
%	CUSTOM HEADERS AND FOOTERS
%---------------------------------------------------------------------------------------

% Style with chapter number, chapter title, and page in the header (used throughout the document)
\renewpagestyle{scrheadings}{%
	{\smash{\hspace{-\headmarginparwidth}\hspace{-\headmarginparsep}\makebox[\headtotal][l]{%
			\makebox[7\hscale][r]{\normalfont\sffamily\LARGE\color{lightgraycolor}\textbf\thepage}%
			\makebox[3\hscale]{}{\color{maincolor}\rule[-1mm]{1.5pt}{19\vscale-1mm}}\makebox[3\hscale]{}%
			\makebox[\headtextwidth][l]{\leftmark}}}}%
	{\smash{\makebox[0pt][l]{\makebox[\headtotal][r]{%
			\makebox[\headtextwidth][r]{\hfill\rightmark}%
			\makebox[3\hscale]{}{\color{maincolor}\rule[-1mm]{1.5pt}{19\vscale-1mm}}\makebox[3\hscale]{}%
			\makebox[7\hscale][l]{\normalfont\sffamily\LARGE\color{lightgraycolor}\textbf\thepage}}}}}%
	{\smash{\makebox[0pt][l]{\makebox[\headtotal][r]{%
			\makebox[\headtextwidth][r]{\hfill\rightmark}%
			\makebox[3\hscale]{}{\color{maincolor}\rule[-1mm]{1.5pt}{19\vscale-1mm}}\makebox[3\hscale]{}%
			\makebox[7\hscale][l]{\normalfont\sffamily\LARGE\color{lightgraycolor}\textbf\thepage}}}}}%
}{%
	{}%
	{}%
	{}%
}

%----------------------------------------------------------------------------------------
%	MARGIN TOC
%----------------------------------------------------------------------------------------

% CHANGED: FIX BUG THAT SHOWED A "POP EMPTY COLOR PAGE STACK 0" WARNING

% Command to print a table of contents in the margin
\NewDocumentCommand{\custommargintoc}{O{\mtocshift}}{ % The first parameter is the vertical offset; by default it is \mtocshift
	\begingroup%
	% Move regular section and subsection to level 6 so that they won't be included and instead set let the mtoc versions take their place.
	% Adapted from https://tex.stackexchange.com/a/133559/226693
	\etocsetlevel{section}{6}
	\etocsetlevel{subsection}{6}
	\etocsetlevel{mtocsection}{1}
	\etocsetlevel{mtocsubsection}{2}

	% Define default widths
	\def\margintocnumwidth{-.8mm}%
	\def\margintocpagenumwidth{8pt}%
	\setlength{\RaggedRightParfillskip}{0pt}

	% Dry run to get the needed widths
	\etocsetstyle{mtocsection}%
	{}%
	{\sbox0{\usekomafont{section}\small\etocthenumber\kern.8mm}%%
		\sbox1{\usekomafont{section}\small\etocthepage}}%
	{\ifdim\wd0>\margintocnumwidth \edef\margintocnumwidth{\the\wd0} \fi%%
		\ifdim\wd1>\margintocpagenumwidth \edef\margintocpagenumwidth{\the\wd1} \fi}%
	{}%
	\etocsetstyle{mtocsubsection}%
	{}%
	{\sbox0{\usekomafont{section}\small\etocthenumber\kern.8mm}%
		\sbox1{\usekomafont{section}\small\etocthepage}}%
	{\ifdim\wd0>\margintocnumwidth \edef\margintocnumwidth{\the\wd0} \fi%
		\ifdim\wd1>\margintocpagenumwidth \edef\margintocpagenumwidth{\the\wd1} \fi}%
	{}%
	\etocsetstyle{subsubsection}%
	{}%
	{}%
	{}%
	{}%
	\etocsetstyle{paragraph}%
	{}%
	{}%
	{}%
	{}%
	\etocsettocstyle{}{%
		\global\let\margintocnumwidth\margintocnumwidth%
		\global\let\margintocpagenumwidth\margintocpagenumwidth%
	}%
	\localtableofcontents%

	% Set the style for section entries
	\etocsetstyle{mtocsection}%
	{\parindent 0pt \parskip 2.5pt \parfillskip 0pt \RaggedRight}%
	{\leftskip \margintocnumwidth \rightskip \margintocpagenumwidth} %
	{\makebox[0pt][r]{\makebox[\margintocnumwidth][l]{\etocnumber}}\etocname\nobreak\leaders\hbox{\hbox to 1.5ex {\hss.\hss}}\hfill\rlap{\makebox[\margintocpagenumwidth][r]{\etocpage}}\par}%
	{}%
	% Set the style for subsection entries
	\etocsetstyle{mtocsubsection}%
	{\parindent 0pt \parskip 0pt \parfillskip 0pt \RaggedRight}%
	{\leftskip \margintocnumwidth \rightskip \margintocpagenumwidth}%
	{\makebox[0pt][r]{\makebox[\margintocnumwidth][l]{\etocnumber}}\etocname\nobreak\leaders\hbox{\hbox to 1.5ex {\hss.\hss}}\hfill\rlap{\makebox[\margintocpagenumwidth][r]{\etocpage}}\par}%
	{\parskip 2.5pt}%
	% Set the global style of the toc
	\etocsettocstyle{\usekomafont{section}\small}{}%
	\etocsetnexttocdepth{\themargintocdepth}%
	% Print the table of contents in the margin
	\marginnote[#1]{\localtableofcontents}%
	\FloatBarrier%
	\endgroup%
}
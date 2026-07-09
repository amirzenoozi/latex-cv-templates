\ProvidesClass{detroit}[2026/07/09 Detroit - a bold, graphical, industry CV]
\LoadClass[10pt]{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  DETROIT CV                                                         %%
%%  A bold, graphical two-column template aimed at industry / technical%%
%%  roles (engineering, manufacturing, operations, product, ...).      %%
%%  Full-height coloured sidebar (via paracol, so it flows across      %%
%%  pages), skill rings, proficiency dots, tag chips and a timeline of %%
%%  experience cards. Compile with pdflatex (run twice).               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[a4paper, top=1.15cm, bottom=1.15cm, left=0.9cm, right=1.0cm]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{microtype}
\RequirePackage{paracol}
\RequirePackage{eso-pic}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{tcolorbox}
\tcbuselibrary{skins, breakable}
\RequirePackage{enumitem}
\RequirePackage{graphicx}
\RequirePackage{ragged2e}
\RequirePackage{accsupp}     % keep icons speakable for screen readers
\RequirePackage{fontawesome}
\RequirePackage{xcolor}

%%%%%%%%%%%%%%%%%%%%%%%%%
%% Font Style Settings %%
%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[sfdefault]{FiraSans}
\renewcommand{\familydefault}{\sfdefault}
\linespread{1.05}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define Color Variables %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{SteelDark}{HTML}{222A31}   % sidebar background
\definecolor{SteelLight}{HTML}{333F49}  % chips / cards on the sidebar
\definecolor{RingTrack}{HTML}{46525C}   % unfilled part of skill rings/dots
\definecolor{Accent}{HTML}{F26430}      % industrial safety orange
\definecolor{AccentSoft}{HTML}{F9A03F}  % secondary warm accent
\definecolor{MainDark}{HTML}{20262B}    % headings / body in main column
\definecolor{Muted}{HTML}{7C858C}       % secondary text
\definecolor{RuleG}{HTML}{DCE0E4}       % hairlines in main column
\definecolor{White}{HTML}{FFFFFF}

\colorlet{accent}{Accent}
\colorlet{body}{MainDark}

%%%%%%%%%%%%%%%%%%%%%
%% FontAwesome map %%
%%%%%%%%%%%%%%%%%%%%%
\newcommand{\emailsymbol}{\faEnvelope}
\newcommand{\phonesymbol}{\faPhone}
\newcommand{\locationsymbol}{\faMapMarker}
\newcommand{\homepagesymbol}{\faChain}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\githubsymbol}{\faGithub}

%% hyperref last. hidelinks keeps link text in its surrounding colour
%% (white in the dark sidebar, dark in the main column).
\RequirePackage{hyperref}
\hypersetup{hidelinks, pdflang={en}}

%%%%%%%%%%%%%%%%%%%%%%%%
%% Skips & list style  %%
%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\parindent}{0pt}
\setlength{\smallskipamount}{4pt}
\setlength{\medskipamount}{8pt}
\setlength{\bigskipamount}{12pt}
\newcommand{\itemmarker}{\color{accent}\small\faCaretRight}
\setlist{leftmargin=1.1em, labelsep=0.5em, topsep=2pt, itemsep=2pt, parsep=0pt}
\setlist[itemize]{label=\itemmarker}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Accessible icon helper: draw glyph, speak the label                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\ttsicon}[2]{\BeginAccSupp{method=escape,ActualText={#2: }}#1\EndAccSupp{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  P A G E   L A Y O U T                                              %%
%%  A full-bleed SteelDark bar is painted on every page by eso-pic;    %%
%%  paracol then flows the two text columns over it (sidebar text sits %%
%%  on the dark bar, main text on white). Content flows normally, so   %%
%%  experience cards break across pages and the CV can span 2 pages.   %%
%%  Wrap the whole body between \begin{cv}...\end{cv}.                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\sidebarwidth}{7cm}
\AddToShipoutPictureBG{%
    \AtPageLowerLeft{\color{SteelDark}\rule{\sidebarwidth}{\paperheight}}%
}

%% Left text column ~5.5cm; gap 1.2cm; right column takes the rest.
\columnratio{0.288}
\setlength{\columnsep}{1.2cm}

\newenvironment{cv}{%
    \pagestyle{empty}%
    \begin{paracol}{2}%
    % ---- left (sidebar) column, over the dark bar ----
    \color{White}\RaggedRight
    \vspace*{0.35cm}
}{%
    \end{paracol}%
}

%% Move to the right (main) column inside the cv environment.
\newcommand{\mainstart}{%
    \switchcolumn
    \color{MainDark}\RaggedRight
    \vspace*{0.35cm}
}
\newcommand{\mainend}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  S I D E B A R   B U I L D I N G   B L O C K S                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Circular avatar with an accent ring.
\newcommand{\profilepic}[1]{%
    \begin{center}
    \begin{tikzpicture}
        \node[circle, draw=Accent, line width=2.5pt, inner sep=0pt,
              minimum size=3.1cm,
              path picture={\node at (path picture bounding box.center)
              {\includegraphics[width=3.1cm]{#1}};}] {};
    \end{tikzpicture}
    \end{center}
}

%% Sidebar section heading: white caps with a short accent underline.
\newcommand{\sidesection}[1]{%
    \par\vspace{9pt}
    {\color{White}\bfseries\normalsize\MakeUppercase{#1}}\par
    \vspace{1pt}{\color{Accent}\rule{1.5cm}{2.2pt}}\par\vspace{5pt}
}

%% One contact line: accent icon (with spoken label) + value.
\newcommand{\infoline}[3]{%
    \mbox{\textcolor{Accent}{\ttsicon{#1}{#2}}\hspace{0.6em}{\small #3}}\par\vspace{3pt}
}
\newcommand{\cvlocation}[1]{\infoline{\locationsymbol}{Location}{#1}}
\newcommand{\cvemail}[1]{\infoline{\emailsymbol}{Email}{\href{mailto:#1}{\color{White}#1}}}
\newcommand{\cvphone}[1]{\infoline{\phonesymbol}{Phone}{\href{tel:#1}{\color{White}#1}}}
\newcommand{\cvweb}[1]{\infoline{\homepagesymbol}{Website}{\href{https://#1}{\color{White}#1}}}
\newcommand{\cvlinkedin}[1]{\infoline{\linkedinsymbol}{LinkedIn}{\href{https://linkedin.com/in/#1}{\color{White}#1}}}
\newcommand{\cvgithub}[1]{\infoline{\githubsymbol}{GitHub}{\href{https://github.com/#1}{\color{White}#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Skill ring:  \skillring{percent}{label}                             %%
%% A fixed 2.7cm block (ring + caption) so two sit side by side.       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\skillring}[2]{%
    \begin{minipage}[t]{2cm}
        \centering
        \begin{tikzpicture}
            \draw[line width=3.2pt, color=RingTrack] (0,0) circle (0.55cm);
            \draw[line width=3.2pt, color=Accent, line cap=round]
                  (90:0.55cm) arc (90:{90 - 3.6*#1}:0.55cm);
            \node[color=White, font=\small\bfseries] at (0,0) {#1\%};
        \end{tikzpicture}\\[1pt]
        {\scriptsize\color{White} #2}
    \end{minipage}%
}

%% \skillgrid{p1}{l1}{p2}{l2}{p3}{l3}{p4}{l4}
%% Lays four rings out 2x2 with a built-in >=30px (26pt) margin between
%% every item, horizontally and vertically.
\newcommand{\ringmargin}{26pt} % ~34px, comfortably above the 30px minimum
\newcommand{\skillgrid}[8]{%
    \begingroup
    \centering
    \vspace{5pt}\par
    \begin{tabular}{@{}c@{\hspace{\ringmargin}}c@{}}
        \skillring{#1}{#2} & \skillring{#3}{#4}\\[\ringmargin]
        \skillring{#5}{#6} & \skillring{#7}{#8}
    \end{tabular}\par
    \vspace{9pt}
    \endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Proficiency dots:  \level{label}{n}    (n filled out of 5)          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\level}[2]{%
    \mbox{}{\small\color{White} #1}\hfill
    \begin{tikzpicture}[baseline=-0.6ex]
        \foreach \i in {1,...,5}{%
            \ifnum\i>#2 \definecolor{dotc}{named}{RingTrack}\else
                        \definecolor{dotc}{named}{Accent}\fi
            \fill[dotc] ({0.32*\i},0) circle (2.4pt);
        }
    \end{tikzpicture}\par\vspace{3pt}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tag chips:  \tags{item one, item two, ...}                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\chip}[1]{%
    \tcbox[on line, colback=SteelLight, colframe=Accent, coltext=White,
           boxrule=0.6pt, arc=2.5pt, boxsep=1.5pt,
           left=4pt, right=4pt, top=1.5pt, bottom=1.5pt,
           nobeforeafter]{\scriptsize #1}%
}
\newcommand{\tagsep}{\hspace{2pt}\vspace{4pt}}
\NewDocumentCommand{\tags}{ >{\SplitList{,}} m }{%
    \setlength{\parskip}{4pt}\raggedright
    \ProcessList{#1}{\tagitem}%
}
\newcommand{\tagitem}[1]{\chip{#1}\hspace{2pt}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simple sidebar entry (e.g. certifications / education in sidebar).  %%
%% \sideentry{title}{subtitle}                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\sideentry}[2]{%
    {\small\color{White}\bfseries #1}\par
    {\scriptsize\color{RuleG} #2}\par\vspace{4pt}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  M A I N   C O L U M N   B U I L D I N G   B L O C K S              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Header: big name + accent role + a small three-square motif.
\newcommand{\cvheader}[2]{%
    \hypersetup{pdftitle={#1 -- CV}, pdfauthor={#1}}%
    {\color{MainDark}\fontsize{30}{33}\selectfont\bfseries #1}\par
    \vspace{2pt}
    {\color{Accent}\large\bfseries\MakeUppercase{#2}}\par
    \vspace{5pt}
    \begin{tikzpicture}
        \fill[Accent]     (0,0) rectangle (0.32,0.14);
        \fill[AccentSoft] (0.42,0) rectangle (0.74,0.14);
        \fill[RuleG]      (0.84,0) rectangle (1.16,0.14);
    \end{tikzpicture}\par\vspace{4pt}
}

%% Main section heading: accent square + title + hairline rule.
\newcommand{\mainsection}[1]{%
    \par\vspace{11pt}
    \noindent{\color{Accent}\rule[0.3mm]{3.2mm}{3.2mm}}\hspace{2mm}%
    {\color{MainDark}\large\bfseries\MakeUppercase{#1}}\par
    \vspace{1pt}{\color{RuleG}\rule{\linewidth}{0.8pt}}\par\vspace{5pt}
}

%% Timeline experience card: accent left bar + node dot.
\newtcolorbox{tlcard}{%
    enhanced, breakable, colback=white, boxrule=0pt, sharp corners,
    borderline west={2.2pt}{0pt}{Accent},
    left=13pt, right=2pt, top=3pt, bottom=4pt,
    before skip=3pt, after skip=7pt,
    overlay unbroken and first={%
        \fill[Accent] ([xshift=1.1pt, yshift=-6pt]frame.north west) circle (3.6pt);
    },
}

%% \experience{role}{company}{dates}{location}{description}
\newcommand{\experience}[5]{%
    \begin{tlcard}
        {\color{MainDark}\bfseries\large #1}\hfill
        {\color{Accent}\bfseries\small #3}\\[1pt]
        {\color{AccentSoft}\bfseries\small #2}%
        \ifx\relax#4\relax\else\quad{\color{Muted}\footnotesize\faMapMarker~#4}\fi
        \par\vspace{3pt}
        {\color{MainDark}\small #5}
    \end{tlcard}%
}

%% \education{degree}{institution}{dates}
\newcommand{\education}[3]{%
    {\color{MainDark}\bfseries #1}\hfill{\color{Accent}\bfseries\small #3}\\[1pt]
    {\color{Muted}\small #2}\par\vspace{6pt}
}

%% \achievement{icon}{text}  - graphical highlight bullet
\newcommand{\achievement}[2]{%
    \mbox{\color{Accent}\large #1}\hspace{6pt}%
    \begin{minipage}[t]{0.9\linewidth}\color{MainDark}\small #2\end{minipage}\par\vspace{5pt}
}

\AtBeginDocument{\pagestyle{empty}\pagenumbering{gobble}\color{MainDark}\RaggedRight}

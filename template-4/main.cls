\ProvidesClass{oslo}[2026/07/09 Oslo - a clean, single-column, TTS-friendly academic CV]
\LoadClass[11pt]{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  OSLO CV  -  Accessibility / TTS notes                              %%
%%  --------------------------------------------------------------     %%
%%  This template is built to be as Text-To-Speech (TTS) and screen    %%
%%  reader friendly as a LaTeX CV reasonably can be:                   %%
%%   * Single column  -> one linear top-to-bottom reading order.       %%
%%   * No decorative photo -> nothing that TTS has to skip or mislabel.%%
%%   * Contact icons are wrapped with \BeginAccSupp{ActualText=...}    %%
%%     so a screen reader speaks "Email", "Phone", ... instead of an   %%
%%     unknown symbol glyph.                                           %%
%%   * Skills / languages are written as plain words ("Advanced",      %%
%%     "Native") instead of progress bars, which TTS cannot read.      %%
%%   * PDF language + title + author metadata are set for assistive    %%
%%     technology (see \makeheader / \hypersetup below).               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[margin=1.8cm]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{microtype}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{accsupp}   % ActualText for screen readers / TTS
\RequirePackage{fontawesome}

%%%%%%%%%%%%%%%%%%%%%%%%%
%% Font Style Settings %%
%%%%%%%%%%%%%%%%%%%%%%%%%
%% Linux Libertine: a warm, readable serif well suited to long
%% academic CVs, with genuine small caps used for section titles.
\RequirePackage{libertine}
\renewcommand{\familydefault}{\rmdefault}
\linespread{1.06}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define Color Variables %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{OxfordBlue}{HTML}{10263B}  % primary accent
\definecolor{Amber}{HTML}{9A6B1F}       % secondary accent (dates, links)
\definecolor{Ink}{HTML}{1B1B1B}         % body text
\definecolor{Slate}{HTML}{5A5A5A}       % muted / secondary text
\definecolor{Rule}{HTML}{C9CFD6}        % hairlines

\colorlet{accent}{OxfordBlue}
\colorlet{second}{Amber}
\colorlet{body}{Ink}
\colorlet{muted}{Slate}

%% hyperref last, so it can hook everything. Metadata is filled in by
%% \makeheader using the values passed to \name / \tagline.
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,
    urlcolor=second,
    linkcolor=second,
    pdflang={en},
    pdfstartview={FitH},
}

%%%%%%%%%%%%%%%%%%%%%%%%
%% Set Skip Variables %%
%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\parindent}{0pt}
\setlength{\smallskipamount}{4pt}
\setlength{\medskipamount}{7pt}
\setlength{\bigskipamount}{11pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Accessible icon helper                                              %%
%% \ttsicon{<glyph>}{<spoken words>} draws the glyph but hands assistive%%
%% technology the spoken words via ActualText.                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\ttsicon}[2]{%
    \BeginAccSupp{method=escape,ActualText={#2: }}%
    \textcolor{accent}{#1}%
    \EndAccSupp{}%
}

%%%%%%%%%%%%%%%%%%%
%% Personal Data %%
%%%%%%%%%%%%%%%%%%%
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}

%%%%%%%%%%%%%%%%%%%%%
%% Contact Details %%
%%%%%%%%%%%%%%%%%%%%%
%% Each item = accessible icon + spoken label + value. The trailing
%% space keeps items from running together when read aloud.
\newcommand{\contactitem}[3]{%
    \mbox{\ttsicon{#1}{#2}\hspace{0.45em}#3}\hspace{1.4em}\ignorespaces
}
\newcommand{\email}[1]{\contactitem{\faEnvelope}{Email}{\href{mailto:#1}{#1}}}
\newcommand{\phone}[1]{\contactitem{\faPhone}{Phone}{\href{tel:#1}{#1}}}
\newcommand{\location}[1]{\contactitem{\faMapMarker}{Location}{#1}}
\newcommand{\homepage}[1]{\contactitem{\faChain}{Website}{\href{https://#1}{#1}}}
\newcommand{\linkedin}[1]{\contactitem{\faLinkedin}{LinkedIn}{\href{https://linkedin.com/in/#1}{#1}}}
\newcommand{\github}[1]{\contactitem{\faGithub}{GitHub}{\href{https://github.com/#1}{#1}}}
\newcommand{\orcid}[1]{\contactitem{\faGraduationCap}{ORCID}{\href{https://orcid.org/#1}{#1}}}
\newcommand{\scholar}[1]{\contactitem{\faGraduationCap}{Google Scholar}{\href{#1}{Google Scholar}}}

%%%%%%%%%%%%%%
%% Header   %%
%%%%%%%%%%%%%%
%% Name is letterspaced small caps; tagline sits under a thin accent
%% rule; contact line follows. PDF metadata is set here so it always
%% matches the visible name/tagline.
\newcommand{\makeheader}{%
    \hypersetup{pdftitle={\@name\ -- Curriculum Vitae}, pdfauthor={\@name}}%
    \begingroup
    \centering
    {\color{accent}\fontsize{26}{30}\selectfont\scshape\textls[120]{\@name}\par}
    \vspace{4pt}
    {\color{accent}\rule{3.2cm}{0.9pt}\par}
    \vspace{6pt}
    {\color{second}\large\itshape\@tagline\par}
    \vspace{9pt}
    {\small\@personalinfo\par}
    \endgroup
    \vspace{2pt}
}

%%%%%%%%%%%%%%%%%%%%%%
%% Section Headings %%
%%%%%%%%%%%%%%%%%%%%%%
%% Small-caps letterspaced accent title with a full-width hairline.
\titleformat{\section}
    {\color{accent}\normalfont\large\scshape}
    {}{0pt}
    {\textls[80]}
    [{\color{Rule}\titlerule[0.8pt]}]
\titlespacing*{\section}{0pt}{10pt}{5pt}

%% Optional subsection label (e.g. "Journal Articles" under Publications)
\newcommand{\cvsubsection}[1]{%
    \smallskip
    {\color{second}\normalsize\scshape\textls[40]{#1}}\par
    \vspace{2pt}
}

%%%%%%%%%%%%%%%%%%%%
%% Divider (thin) %%
%%%%%%%%%%%%%%%%%%%%
\newcommand{\divider}{\smallskip{\color{Rule}\rule{\linewidth}{0.4pt}}\smallskip}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \cventry{title}{dates}{organisation / place}{description}           %%
%% Title on the left, dates flush right (dates come *after* the title  %%
%% in reading order, which is natural for TTS). Organisation on the    %%
%% next line, then free description / bullet list.                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\cventry}[4]{%
    \begin{tabularx}{\linewidth}{@{}X@{}r@{}}
        {\color{body}\bfseries #1} & {\color{second}\small #2}
    \end{tabularx}\par
    \ifblank{#3}{}{{\color{muted}\itshape #3}\par}%
    \vspace{2pt}
    \ifblank{#4}{}{{\color{body}#4}\par}%
    \medskip
}
\RequirePackage{etoolbox} % provides \ifblank

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \honor{year}{description}  - one-line grants / awards / honors      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\honor}[2]{%
    \begin{tabularx}{\linewidth}{@{}p{1.9cm}@{\hspace{0.6em}}X@{}}
        {\color{second}\small #1} & {\color{body}#2}
    \end{tabularx}\par
    \vspace{3pt}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \skillrow{category}{comma, separated, skills}                       %%
%% Text only, no bars -> reads cleanly in TTS.                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\skillrow}[2]{%
    \begin{tabularx}{\linewidth}{@{}p{4.2cm}@{\hspace{0.6em}}X@{}}
        {\color{accent}\bfseries #1} & {\color{body}#2}
    \end{tabularx}\par
    \vspace{3pt}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \lang{language}{proficiency}  - spelled-out proficiency word        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\lang}[2]{%
    \begin{tabularx}{\linewidth}{@{}p{4.2cm}@{\hspace{0.6em}}X@{}}
        {\color{accent}\bfseries #1} & {\color{body}#2}
    \end{tabularx}\par
    \vspace{3pt}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \reference{name}{role, affiliation}{email}                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\reference}[3]{%
    {\color{body}\bfseries #1}\par
    {\color{muted}#2}\par
    {\ttsicon{\faEnvelope}{Email}\hspace{0.4em}\href{mailto:#3}{#3}}\par
    \medskip
}

%%%%%%%%%%%%%%%%%%%%%%%%%
%% List / bullet style %%
%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\itemmarker}{\color{second}\small\textbullet}
\setlist{leftmargin=1.2em, labelsep=0.6em, topsep=2pt, itemsep=2pt, parsep=0pt}
\setlist[itemize]{label=\itemmarker}

%% Numbered publication list where your own name can be emphasised
\newlist{publications}{enumerate}{1}
\setlist[publications]{leftmargin=2em, label=[\arabic*], itemsep=4pt, topsep=2pt}
\newcommand{\me}[1]{\textbf{#1}} % highlight the CV owner in author lists

\AtBeginDocument{%
    \pagestyle{empty}
    \color{body}
    \raggedright
}

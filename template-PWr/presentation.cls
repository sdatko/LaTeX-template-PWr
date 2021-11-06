%
% PWr LaTeX Template for Presentations
%
\NeedsTeXFormat{LaTeX2e}
\def\ClassName{template-PWr/presentation}
\ProvidesClass{\ClassName}[2021/11/06 PWr LaTeX Template for Presentations]


%
% Beamer options
%
\DeclareOption{4:3}{
    \PassOptionsToClass{aspectratio=43}{beamer}
}
\DeclareOption{16:9}{
    \PassOptionsToClass{aspectratio=169}{beamer}
}


%
% Our custom options
%
\DeclareOption{en}{
    \def\PWrThemeLang{en}
}
\DeclareOption{pl}{
    \def\PWrThemeLang{pl}
}

\DeclareOption{v1}{
    \def\PWrThemeVersion{v1}
}
\DeclareOption{v2}{
    \def\PWrThemeVersion{v2}
}


%
% Fallback for bad options specified to document class
%
\DeclareOption*{
    \ClassError{\ClassName}{Unknown option '\CurrentOption'}
}


%
% Set default options
%
\ExecuteOptions{4:3}
\ExecuteOptions{pl}
\ExecuteOptions{v2}


%
% End of options processing
%
\ProcessOptions\relax


%
% Base class
%
\LoadClass[usenames,dvipsnames]{beamer}


%
% Additional packages
%
\RequirePackage{cmap}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{polski}

\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{setspace}


%
% Hint for the PDF reader to fit the slides with a window size on first launch
%
\hypersetup{pdfstartview={Fit}}


%
% Definition of a \contact macro for the title slide
%
\makeatletter
\newcommand{\contact}[1]{\@namedef{contactdef}{#1}}
\newcommand{\insertcontact}{\contactdef}
\makeatother


%
% Select the base theme
%
\usetheme{default}


%
% Font selection
%
\RequirePackage{lmodern}


%
% Colors setting
%
\setbeamercolor{structure}{fg=black}
\setbeamercolor{normal text}{fg=black,bg=white}


%
% Spacing adjustment
%
\setbeamersize{text margin left=0.11\paperwidth}
\setbeamersize{text margin right=0.045\paperwidth}


%
% Default slide theme
%
\setbeamertemplate{background canvas}{
    \vbox to \paperheight {
        \vfil
        \hbox to \paperwidth {%
            \hfil
            \includegraphics[width=\paperwidth]{template-PWr/content-\PWrThemeVersion-\PWrThemeLang.png}
            \hfil
        }
        \vfil
    }
}


%
% Disable the navigation symbols
%
\setbeamertemplate{navigation symbols}{}


%
% Footer adjustment – slides numbering
%
% NOTE(sdatko): The negative vertical space here allows the content to use
%               full space on the slide with the v2 layout. This is because
%               the numbering is located in a column outside the content area.
%
\setbeamertemplate{footline}{
    \vspace{-\baselineskip}
    \vspace{-1.0em}
    \hbox to 0.07\paperwidth {%
        \hfill
        \raisebox{1.0em}
        {
            \tiny
            \color{white}
            \insertframenumber/\inserttotalframenumber
        }
        \hfill
    }
}


%
% Style definition for the slide header
%
% NOTE(sdatko): We are not reserving any space when there is no subtitle.
%
\makeatletter
\setbeamertemplate{frametitle}{
    \vspace{0.25em}
    \insertframetitle

    \ifx\insertframesubtitle\@empty
    \else
        \usebeamerfont*{framesubtitle}
        \usebeamercolor[fg]{framesubtitle}
        \insertframesubtitle
    \fi
}
\makeatother


%
% Content definition for the title slide
%
\makeatletter
\setbeamertemplate{title page}{
    \begin{columns}[c]
        \begin{column}{0.14\paperwidth}
            \centering

            \vspace{\paperheight}
            \vspace{-0.1\paperwidth}
            \includegraphics[width=0.12\paperwidth]{template-PWr/hr-excellence-\PWrThemeVersion.pdf}
        \end{column}
        \begin{column}{0.86\paperwidth}
            \begin{beamercolorbox}[sep=1.0em,center]{title}
                \usebeamerfont{title}%
                \inserttitle
            \end{beamercolorbox}
            \ifx\insertsubtitle\@empty
            \else
                \begin{beamercolorbox}[sep=1.0em,center]{subtitle}
                    \usebeamerfont{subtitle}%
                    \insertsubtitle
                \end{beamercolorbox}
            \fi
            \begin{beamercolorbox}[sep=1.0em,center]{author}
                \usebeamerfont{author}%
                \insertauthor
            \end{beamercolorbox}
            \begin{beamercolorbox}[sep=1.0em,center]{contact}
                \footnotesize
                \insertcontact
            \end{beamercolorbox}
            \begin{beamercolorbox}[sep=1.0em,center]{institute}
                \usebeamerfont{institute}%
                \insertinstitute
            \end{beamercolorbox}
            \begin{beamercolorbox}[sep=1.0em,center]{date}
                \usebeamerfont{date}%
                \insertdate
            \end{beamercolorbox}
        \end{column}
    \end{columns}
}
\makeatother


%
% Style definition for the title slide
%
% NOTE(sdatko): We are setting a different background here, as well as hide
%               the slides numbering, navigation elements and so on.
%
\makeatletter
\def\ps@navigation@titlepage{
    \setbeamertemplate{background canvas}{
        \vbox to \paperheight{
            \vfil
            \hbox to \paperwidth{%
                \hfil
                \includegraphics[width=\paperwidth]{template-PWr/title-\PWrThemeVersion-\PWrThemeLang.png}
                \hfil
            }
            \vfil
        }
    }
    \setbeamertemplate{footline}{}
    \setbeamertemplate{logo}{}
    \setbeamertemplate{navigation symbols}{}
}

\addtobeamertemplate{title page}{\thispagestyle{navigation@titlepage}}{}
\makeatother


%
% Style definition for the notes slide
%
\setbeamertemplate{note page}{
    \vspace{0.25em}
    \nointerlineskip
    \begin{minipage}{\textwidth}
        \insertnote
    \end{minipage}
}


%
% This must be the last command
%
\endinput

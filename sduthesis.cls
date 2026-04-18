    % !Mode:: "TeX:UTF-8"
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{sduthesis}[2015/05/12 v1.0.5 Shandong University Thesis Template for Postgraduate]
%------解决表格换行问题-------
\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}} 
%------解决表格换行问题-------

% ----- KVoptions Packages -----
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\SetupKeyvalOptions{family=SDU, prefix=SDU@opt@, setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{SDU}{#1}}

% ----- Declare Options -----
% ----- CHSstyle
\DeclareBoolOption[true]{chsstyle}
\DeclareComplementaryOption{nochsstyle}{chsstyle}
% ----- draft/print
\DeclareBoolOption[false]{print}
\DeclareComplementaryOption{noprint}{print}
% ----- double/single
\DeclareBoolOption[true]{double}
\DeclareComplementaryOption{single}{double}
% ----- Default Options
\DeclareDefaultOption{\PassOptionsToPackage{\CurrentOption}{ctex}}
% A4纸张大小，书记格式
\LoadClass[a4paper, 12pt]{book}
\ProcessKeyvalOptions*\relax

\ifSDU@opt@double\relax\else
    \PassOptionsToClass{openany}{book}
    \let\cleardoublepage\clearpage
\fi
%------print------

%------中文支持------
\RequirePackage[ noindent, scheme=plain, UTF8, heading]{ctex}
%----字体名
\RequirePackage{ifpdf,ifxetex}
\ifpdf
	\newcommand{\fzbHei}{\heiti}
        %\newcommand{\kthanqian}{}

\else
	\newcommand{\fzbHei}{\heiti}
\fi
\ifxetex
  \setmainfont{Times New Roman}
\fi
%------中文支持------

%------行距------
\linespread{1.5}
\setlength{\parskip}{0pt}
\setlength{\parindent}{2em}
\newlength{\sduchapterbeforeskip}
\newlength{\sdutitleafterskip}
\newlength{\sdusectionbeforeskip}
% 章/节/正文间距。正文页需要与页眉保持更明显的距离，而章节首页标题则单独
% 通过负的章前距向上补偿，使两种页面的观感都保持合适。
\setlength{\sduchapterbeforeskip}{-0.75\baselineskip}
\setlength{\sdutitleafterskip}{0.25\baselineskip}
\setlength{\sdusectionbeforeskip}{0.25\baselineskip}
%------行距------

%------页面设置------
\ifSDU@opt@double
	\newcommand{\GeoOptions}{left=3cm, right=3cm, top=2cm, bottom=2.5cm}
\else
	\newcommand{\GeoOptions}{left=3cm, right=3cm, top=2cm, bottom=2.5cm}
\fi
\RequirePackage[\GeoOptions]{geometry}
%------页面设置------

%------页眉页脚------
\RequirePackage{fancyhdr}
\fancypagestyle{sdubody}{%
  \fancyhf{}
  \fancyhead[C]{\zihao{-5}\songti\the\ThesisHeader}
  \fancyfoot[C]{\zihao{-5}\rmfamily\thepage}
  \renewcommand{\headrulewidth}{0.5pt}
  \renewcommand{\footrulewidth}{0pt}
}

% 正文页与页眉之间保留更明显的间距；章节首页通过章前距单独补偿。
\setlength{\headheight}{14pt}
\setlength{\headsep}{18pt}

\fancypagestyle{sdufrontmatter}{%
  \fancyhf{}
  \fancyfoot[C]{\zihao{-5}\rmfamily\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{sduempty}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\pagestyle{sdubody}
\makeatletter
\let\ps@plain\ps@sdubody
\makeatother
%------页眉页脚------

%------数学支持------
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{amsbsy}
\RequirePackage{bm}
\RequirePackage{mathrsfs}
\ifxetex
  \RequirePackage{unicode-math}
  \setmathfont{XITS Math}
  \setmathfont[range=up/{Latin,latin,num}]{Times New Roman}
  \setmathfont[range=it/{Latin,latin}]{Times New Roman Italic}
  \setmathfont[range=bfup/{Latin,latin,num}]{Times New Roman Bold}
  \setmathfont[range=bfit/{Latin,latin}]{Times New Roman Bold Italic}
  \setmathfont[range={"0028-"0029,"002B,"002C,"002D,"002E,"002F,"003A,"003B,"003D,"005B-"005D,"007C}]{Times New Roman}
\else
  \RequirePackage{newtxmath}
\fi
\newcommand*{\me}{\ensuremath{\mathrm{e}}}				%自然对数的底
\newcommand*{\mi}{\ensuremath{\mathrm{i}}}				%虚数单位
\newcommand*{\dif}{\ensuremath{\,\mathrm{d}}}			%微分算子
\DeclareMathAlphabet{\mathsfsl}{OT1}{cmss}{m}{sl}
\newcommand*{\VEC}[1]{\ensuremath{\boldsymbol{#1}}}		%向量
\newcommand*{\MATRIX}[1]{\ensuremath{\mathsfsl{#1}}}	%矩阵名称
\newcommand*{\TENSOR}[1]{\ensuremath{\mathsfsl{#1}}}	%张量名称
\newcommand*{\HUA}[1]{\ensuremath{\mathscr{{#1}}}} 		%输出花体字母
\newcommand*{\SHUANG}[1]{\ensuremath{\mathbb{{#1}}}}	%输出双线字母
\numberwithin{equation}{chapter}						%公式编号随section变化
\renewcommand{\theequation}{\thechapter-\arabic{equation}}


%------数学支持------

% 收紧公式与上下文之间的垂直间距：默认 10pt+ 再叠加 \linespread{1.5} 会显得过松
\AtBeginDocument{%
  \setlength{\abovedisplayskip}{3pt plus 1pt minus 1pt}%
  \setlength{\belowdisplayskip}{3pt plus 1pt minus 1pt}%
  \setlength{\abovedisplayshortskip}{1pt plus 1pt minus 0pt}%
  \setlength{\belowdisplayshortskip}{1pt plus 1pt minus 0pt}%
}

%------图表支持------

\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{tikz}
\RequirePackage[section]{placeins}
\setlength{\textfloatsep}{12pt plus 2pt minus 2pt}
\setlength{\intextsep}{12pt plus 2pt minus 2pt}
\setlength{\floatsep}{10pt plus 2pt minus 2pt}
\usetikzlibrary{arrows.meta,calc,fit,positioning}
\tikzset{
  thesisbox/.style={
    draw,
    thick,
    rounded corners=4pt,
    fill=white,
    align=center,
    inner sep=6pt
  },
  thesisblock/.style={
    thesisbox,
    text width=3.2cm,
    minimum height=2.35cm
  },
  thesiswide/.style={
    thesisbox,
    text width=6.3cm,
    minimum height=1.75cm
  },
  thesissmall/.style={
    thesisbox,
    text width=2.55cm,
    minimum height=1.15cm
  },
  thesisnote/.style={
    font=\footnotesize,
    fill=white,
    inner sep=1.5pt,
    align=center
  },
  thesisflow/.style={-Latex, thick},
  thesisaxis/.style={->, semithick},
  thesisgroup/.style={
    draw,
    dashed,
    thick,
    rounded corners=7pt,
    inner sep=8pt
  }
}
%----图档搜索路径----
\graphicspath{{figures/}{figure/}{pictures/}{picture/}{pic/}{pics/}{image/}{images/}}
%----图档搜索路径----
\RequirePackage{booktabs}
%%----表格行距----
%\renewcommand\arraystretch{1.3}
%%----表格行距----
%----编号----
\RequirePackage{amsmath}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}
%----编号----
\usepackage{caption}
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand{\thetable}{\thechapter-\arabic{table}}
\DeclareCaptionFont{sducaptionfont}{\zihao{5}\songti}

\makeatletter
\captionsetup[table]{
  labelsep=space,
  labelfont=normalfont,
  textfont=normalfont,
  font=sducaptionfont,
  justification=centering,
  singlelinecheck=false
}

% 自定义 \tabcaption 命令
\newcommand{\tabcaption}{%
  \def\@captype{table}%
  \captionsetup{labelsep=space},%
  \caption}

\captionsetup[figure]{
  labelsep=space,
  labelfont=bf,
  textfont=bf,
  font=sducaptionfont,
  justification=centering,
  singlelinecheck=false
}
\newcommand{\figcaption}{\def\@captype{figure}\captionsetup{labelsep=space}\caption}

\makeatother
%----不浮动----
%------图表支持------

%------交叉引用------
\RequirePackage{hyperref}
\hypersetup{
  unicode=true,
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  filecolor=black,
  pdfborder={0 0 0}
}
\makeatletter
\ifSDU@opt@print
	\hypersetup{allcolors=black}
\else\relax\fi
\makeatother
%------交叉引用------

%--------目录-------------
\makeatletter
\def\@bfdottedtocline#1#2#3#4#5{%
\ifnum #1>\c@tocdepth \else
  \vskip \z@ \@plus.2\p@
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
   \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode \bfseries
   \@tempdima #3\relax
   \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
   {\heiti\bfseries\zihao{-4}#4}\normalfont\nobreak
   \leaders\hbox{$\m@th
      \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
      mu$}\hfill
   \nobreak
   \hb@xt@\@pnumwidth{\hfil\songti\zihao{-4} \normalcolor #5}%
   \par}%
\fi}
\renewcommand*\l@chapter{\@bfdottedtocline{0}{0em}{1.0em}}
\renewcommand*\l@section{\@dottedtocline{1}{1.5em}{1.0em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{3.0em}{1.0em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{5.2em}{1.0em}}
\makeatother

%--------目录-------------

%------摘要环境------
\newcommand\enabstractname{ABSTRACT}
\newcommand\enkeywordsname{Key Words}
\newcommand\enkeywords[1]{%
  \par\vspace{\sdutitleafterskip}%
  \noindent{\bfseries\zihao{-4}\rmfamily\enkeywordsname: }{\zihao{-4}\rmfamily #1}%
}
\newenvironment{enabstract}{%
    \newpage
    \phantomsection
    \pagestyle{sduempty}
    \thispagestyle{sduempty}
    \vspace*{\sduchapterbeforeskip}
        \centerline{\zihao{-2}\bfseries\rmfamily\enabstractname}
    \vspace*{\sdutitleafterskip}
\setlength{\parindent}{2em}
\zihao{-4}\rmfamily
}{
    \clearpage 
}

\newcommand\cnabstractname{摘\hspace{2em}要}
\newcommand\cnkeywordsname{关键字}
\newcommand\cnkeywords[1]{%
  \par\vspace{\sdutitleafterskip}%
  \noindent{\bfseries\zihao{-4}\heiti\cnkeywordsname：}{\zihao{-4}\songti #1}%
}
\newenvironment{cnabstract}{%
    \newpage
    \phantomsection
    \pagestyle{sduempty}
    \thispagestyle{sduempty}
    \vspace*{\sduchapterbeforeskip}
		\centerline{\zihao{-2}\heiti\bfseries\cnabstractname} %20150305 ADD%
    \vspace*{\sdutitleafterskip}
		\setlength{\parindent}{2em}
		\zihao{-4}\songti
}{
    \clearpage
}
%------摘要环境------

%------中文风格------
\makeatletter
\ifSDU@opt@chsstyle
%----标题与日期----
\CTEXoptions[figurename={图},tablename={表}]
\CTEXoptions[today=small]
%----标题与日期----
%----章节样式----

%--contents
\ctexset{
  contentsname = {\centering\zihao{-2}\heiti\bfseries 目\hspace{2em}录},
}
%--contents

%--reference
% \ctexset{
%   bibname = {\centering\zihao{-2}\heiti\bfseries 参考文献},
% }
\usepackage[backend=biber, style=gb7714-2015, sorting=none, sortcites=true, gbpub=false, doi=false, url=true]{biblatex}
\addbibresource[location=local]{contents/reference.bib}
\AtEveryBibitem{\clearfield{eprintclass}}
\newrobustcmd{\mkbibbracketsuperscript}[1]{\mkbibsuperscript{\mkbibbrackets{#1}}}
\DeclareCiteCommand{\supercite}[\mkbibbracketsuperscript]
  {\usebibmacro{cite:init}%
   \let\multicitedelim=\supercitedelim
   \let\multicitesubentrydelim=\supercitesubentrydelim
   \let\multiciterangedelim=\superciterangedelim
   \let\multicitesubentryrangedelim=\supercitesubentryrangedelim
   \iffieldundef{prenote}
     {}
     {\BibliographyWarning{Ignoring prenote argument}}%
   \iffieldundef{postnote}
     {}
     {\BibliographyWarning{Ignoring postnote argument}}}
  {\usebibmacro{citeindex}%
   \printtext[bibhyperref]{\usebibmacro{cite:comp}}}
  {}
  {\usebibmacro{cite:dump}}
\defbibheading{myheading}[参考文献]{%
  \clearpage
  \phantomsection
  \vspace*{\sduchapterbeforeskip}
  \centerline{\centering\bfseries\heiti\zihao{-2}#1}
  \vspace*{\sdutitleafterskip}
  \addcontentsline{toc}{chapter}{#1}
  {\zihao{5}\selectfont}
}
\AtBeginBibliography{\zihao{5}\songti\linespread{1}\selectfont}
%--reference

%--chapter
%\begin{comment}
%    \CTEXsetup[name={,}]{chapter}
%    \CTEXsetup[number={\arabic{chapter}}]{chapter}
%    \renewcommand{\thechapter}{\arabic{chapter}} % 显示为1、2、3…
%    \renewcommand{\thesection}{\thechapter.\arabic{section}} % 显示为1.1
%    \renewcommand{\thesubsection}{\thesection.\arabic{subsection}} % 显示为1.1.1
%\end{comment}

    \CTEXsetup[name={,}]{chapter}
    \CTEXsetup[number={\arabic{chapter}}]{chapter}
    \CTEXsetup[format={\centering}]{chapter}%这一行将章节标题设置为 居中 格式，即使标题内容在正文中，也会居中显示。
    \CTEXsetup[nameformat={\heiti\bfseries\zihao{3}}]{chapter}%这一行设置章节标题编号（如“第1章”）的样式：
    \CTEXsetup[titleformat={\heiti\bfseries\zihao{3}}]{chapter}%这一行设置章节标题名称部分的格式（即“绪论”等内容）：\bfseries：使章节标题内容加粗。\zihao{3}：设置字号为三号字。
    \CTEXsetup[aftername={\hspace{0.5em}}]{chapter}%这一行在章节编号和章节标题之间插入一个空格（\quad 是 LaTeX 中的一种水平空格命令，大小是普通空格的两倍）。这意味着章节编号和标题之间会有适当的间隔。
    \CTEXsetup[beforeskip={\sduchapterbeforeskip}]{chapter}%这一行设置章节标题前的垂直间距为 0.8 行。
    \CTEXsetup[afterskip={\sdutitleafterskip}]{chapter}%这一行设置章节标题后的垂直间距为 0.5 行。

%\begin{comment}
%    \CTEXsetup[name={第,章}]{chapter}
%    \CTEXsetup[number={\chinese{chapter}}]{chapter}
%    \CTEXsetup[format={\centering}]{chapter}
%    \CTEXsetup[nameformat={\bfseries\zihao{3}}]{chapter}
%    \CTEXsetup[titleformat={\bfseries\zihao{3}}]{chapter}
%    \CTEXsetup[aftername={\quad{}}]{chapter}
%    \CTEXsetup[beforeskip={0.8\baselineskip}]{chapter}
%    \CTEXsetup[afterskip={0.5\baselineskip}]{chapter}
%\end{comment}

%--section
\CTEXsetup[aftername={\hspace{0.5em}}]{section}
% \CTEXsetup[name={$\S$\,,}]{section} % 去掉章节前的双S花符号
\CTEXsetup[format={\heiti\bfseries\flushleft\zihao{4}}]{section}
\CTEXsetup[beforeskip={\sdusectionbeforeskip}]{section}%节标题前的垂直间距为0.5行
\CTEXsetup[afterskip={\sdutitleafterskip}]{section} % 节标题后的垂直间距为0.5行

% 设置节标题的前后间距
\CTEXsetup[beforeskip={\sdusectionbeforeskip}]{subsection} % 节标题前的垂直间距为0.5行
\CTEXsetup[afterskip={\sdutitleafterskip}]{subsection} % 节标题后的垂直间距为0.5行
\CTEXsetup[beforeskip={\sdusectionbeforeskip}]{subsubsection} % 节标题前的垂直间距为0.5行
\CTEXsetup[afterskip={\sdutitleafterskip}]{subsubsection} % 节标题后的垂直间距为0.5行

%--subsection
\CTEXsetup[aftername={\hspace{0.5em}}]{subsection}
\CTEXsetup[format={\heiti\bfseries\flushleft\zihao{-4}}]{subsection}
%--subsubsection
\CTEXsetup[format={\heiti\bfseries\flushleft\zihao{-4}}]{subsubsection}
%--appendix
\newcommand{\startappendices}{  
  \appendix  
  \renewcommand{\thechapter}{\Alph{chapter}}  
  \setcounter{chapter}{0}  
  \CTEXsetup[  
    name={附录~,},  
    number=\thechapter,  
    beforeskip=\sduchapterbeforeskip,  
    afterskip=\sdutitleafterskip,
    indent=1em,  
    format={\centering\zihao{-2}\heiti\bfseries}  
  ]{chapter}  
} 

%----------致谢---------------------
\newcommand{\acknowledgment}
{
    \clearpage
    \phantomsection	
    \vspace*{\sduchapterbeforeskip}
		\centerline{\zihao{-2}\heiti\bfseries{致\hspace{2em}谢}} %20150305 ADD%
    \vspace*{\sdutitleafterskip}
		\addcontentsline{toc}{chapter}{致\protect\hspace{2em}谢} %使目录中以章级别显示“致谢”
	\addcontentsline{toe}{chapter}{Acknowledgement}
    \setlength{\parindent}{2em}
	\zihao{-4}\songti
}{
\clearpage
}
%----------致谢---------------------

%----章节样式----
%----首行缩进----
\RequirePackage{indentfirst}
%----首行缩进----
\else\relax\fi
\makeatletter
%------中文风格------

%------封面------
\input{sduthesis-front-cover.def}
%------封面------
 
%------声明------
\input{sduthesis-statement.def}
%------声明------

%------Make------
\newcommand{\maketitlepagestatement}{%  
  \maketitlepage  
  \thispagestyle{empty}  
  \clearpage % 强制分页并清空浮动体  
  \makestatement  
  \clearpage % 再次强制分页并清空浮动体  
  \setcounter{page}{1} % 重置页码计数器  
}  


\newcommand{\maketableofcontents}{%
    \pagenumbering{Roman}
    \pagestyle{sdufrontmatter}
    \makeatletter\let\ps@plain\ps@sdufrontmatter\makeatother
    \tableofcontents
    \ifSDU@opt@double
        \cleardoublepage
    \else
        \clearpage
    \fi
    \pagestyle{sdubody}
    \makeatletter\let\ps@plain\ps@sdubody\makeatother
}
%------Make------
\endinput

%------载入宏包------
%--中文支持
ctex
%--页面设置
geometry
%--页眉页脚
fancyhdr
%--数学支持
amsmath
amsfonts
amsthm
amssymb
amsbsy
bm
mathrsfs
%--图表
graphicx
booktabs
amsmath
%------载入宏包------

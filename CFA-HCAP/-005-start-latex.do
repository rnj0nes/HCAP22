* a4-005-start-latex.do
* Rich Jones
* 22 Jan 2019
* -------------------
cap erase a4.tex
texdoc init a4
starttex , tex(a4.tex) arial usepackage(multirow)
tex {\bf Rich Jones} \\
tex `today' \\
tex \begin{center}
tex {\bf Data and Analysis Report}\\
tex {\bf Factor structure of the Harmonized Cognitive Assessment Protocol}\\ 
tex {\bf neuropsychological battery in the Health and Retirement Study}\\[0.5cm]
tex \end{center}
tex

#d ;
tex
{\bf Summary}\\[0.5cm]
This document summarizes the data and factor analyses of Health and Retirement Study Harmonized Cognitive Assessment Protocol (HCAP). In this report I describe the data used, with a focus on the HCAP neuropsychological and mental status performance indicators (Sections 1-3) revisions (and dropping of some indicators) to those data to deal with low correlations with other cognitive data, very low response categories, and other distribution problems (Sections 4-5).\\[0.25cm]

I then go on to describe the approach to psychometric modeling (factor analysis), including the description of various kinds of models estimated, criteria for assessing model fit, and additional data handling (section 6).\\[0.25cm] ;
#d cr

tex Beginning with section 6.4, I describe results of single factor models for \emph{a priori} specified models involving the HCAP data. Domains hypothesized include: Orientation (ORI); Memory, immediate episodic (MIE); Memory, delayed episodic (MDE); Memory, recognition (MRE); Set shifting (SSH)\footnote{The Set Shifting domain was referred to as executive functioning in earlier HRS and HCAP reports. We use Set Shifting in the unidimensional models, as we end up combining what we call set shifting (FKA executive functioning) and attention, speed domains in a combined Executive Functioning domain.}; Attention, speed (ASP); Language, fluency (LFL); and Visuospatial (VIS).\\[0.25cm]

tex For all but ORI, VIS and SSH, the \emph{a priori} models were confirmed as reasonably good models. The VIS and ORI models were both proposed as two indicator models. In both of these, a large variance indicator was included with a small variance indicator (e.g., 10 item sum from MMSE vs TICS name president; CERAD construtional praxis immediate vs MMSE copy polygons). In both cases the inclusion of the item with less variance was found to be redundant, and I am recommending retaining a single indicator to represent the domain.\\[0.25cm]

tex For the SSH (Set Shifting) domain, I dropped the items capturing \emph{errors} on various tests. I first proposed dropping these after looking at distributional properties and bivariable correlations (section 3). Their exclusion was confirmed in the confirmatory factor analysis models (adding them contributes little to the measurement of the SSH domain, and in fact makes it slightly less reliable).\\[0.25cm]

tex In section 7, I move to a correlated factors model. Results of these models prompt combining SSH and ASP into a single executive function (EFX) domain, combining delayed episodic memory (MDE) and recognition memory (MRE) into a single domain and dropping immediate episodic memory (MIE).\\[0.25cm]

tex In section 8, I report on a second-order factor model based on the final correlated factors model.

tex in section 9, I report on the generation of factor scores using maximum likelihood estimation and the single factor models implied from the correlated factors model.

tex \newpage
tex \tableofcontents
tex \newpage




set trace off
* a4-306-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*
tex \newpage
tex \subsection{Model `model`++m'roman': Correlated factors  (with methods factors)}
local model`m'lab "Correlated factors (with methods factors)"
tex Specific factors are included
tex for the CERAD word list, Brave man text, and Logical Memory text. Here's a picture:\\[0.25cm]
tex \begin{center}
tex \includegraphics[width=.66\textheight]{HCAP-CFA-Correlated-Factors-Method.png}
tex \end{center}

tex Note: I considered a MMSE word list residual, but the variance wanted to
tex be negative. A a residual covariances was included, but this was not significant
tex and not retained in the model displayed (residual correlation = -.01).\\[0.25cm]

local rescor "`rescor' ceradwl by vdmie1z@1;"
local rescor "`rescor' ceradwl by vdmde1z@1;"
local rescor "`rescor' ceradwl by vdmre1z*1;"
local rescor "`rescor' brave by vdmie4z@1;"
local rescor "`rescor' brave by vdmde5z@1;"
local rescor "`rescor' lm by vdmie3z@1;"
local rescor "`rescor' lm by vdmde2z@1;"
local rescor "`rescor' lm by vdmre2z*1;"
local rescor "`rescor' ceradwl with brave@0 lm@0  ;"
local rescor "`rescor' brave with lm@0  ;"
local rescor "`rescor' ceradwl with mie@0 mde@0 mre@0 exf@0 asp@0 lfl@0 `visvarlist'@0 `orivarlist'@0 ; "
local rescor "`rescor' brave with mie@0 mde@0 mre@0 exf@0 asp@0 lfl@0 `visvarlist'@0 `orivarlist'@0 ; "
local rescor "`rescor' lm with mie@0 mde@0 mre@0 exf@0 asp@0 lfl@0 `visvarlist'@0 `orivarlist'@0 ; "
*** not significant vdmie2 with vdmde3 = -.011 local rescor "`rescor' vdmie2 with vdmde3;"

tex \begin{footnotesize}
runmplus `varlist' , ///
	cat(`catlist') output(stdyx) modindices(-0) residuals ///
	savelog(model`m') log(off) ///
	model( ///
	`cfmodel' ///
	`visvarlist' with `latentsare' ; ///
	`orivarlist' with `latentsare' ; ///
	`visvarlist' with `orivarlist' ; ///
	`rescor' ///
	)
fitsis `m'

global start = `m'-1
global end =`m'
include summarizemodels.do
tex \end{footnotesize}

tex This last model, model `m', is a decent model to look at fits to see if there are further modifications to be made.

local comments1 "Note that this implies that 0.95\(\times\)0.95 = 90\% of the variance in MIE and MDE is shared between the two constructs. Similar for ASP and EXF, and LFL and MIE."
local comments2 "comments about factor loadings here"
local model`m'methodsfactors "Includes logical memory, brave man, and CERAD word list methods factors."
tex \begin{footnotesize}
include summarizemvmodel.do
tex \end{footnotesize}


tex \newpage
tex \subsubsection{Issues listing}
tex Here are the issues:
#d ;
tex 
\bi    
\item Overall the model fit is not good
          \bi
          \item The RMSEA is greater than 0.05
          \item The CFI is less than 0.95
          \item {\bf Proposed action:} We will have a look at the residuals and modification indices
          \ei
\item Lack of memory subdomain specificity
          \bi
          \item {\bf Issue:} The memory specific factors are unconvincingly measuring distinct constructs.
          \item {\bf Proposed action:} 
                    \bi
                    \item Drop immediate episodic memory because it is indistinct from multiple other domains, including delayed episodic memory and also language. The immediate episodic memory factor has other problems
                              \bi
                              \item The MMSE \emph{3 word recognition (0-3) (vdmie2)} is a lousy indicator of MIE. We could drop the MMSE 3 word registration, which might imply dropping the 3 word recall items. We've been through this already in the single domain models. It is a dead end that ends up causing more problems than it fixes. That does not mean the approach couldn't be revisited in the correlated factors approach. But current decision is to leave it as is. More on MMSE below.
                              \ei
                    \item Combine delayed episodic memory and recognition memory into a single domain
                    \ei
          \ei
\item Lack of distinction between \emph{Attention, speed} and \emph{Executive Function}
          \bi
          \item {\bf Issue:} The two factors share nearly 90\% of their variance
          \item {\bf Proposed action:} Consider combining set shifting and attention, speed into a single factor
          \ei
\item MMSE items are poor all around (MIE, MDE, ASP, LFL domains)
          \bi
          \item {\bf Issue:} For every domain that includes MMSE items, the MMSE items are the poorest indicators (lowest standardized measurement slope.) Why do we retain these items?
          \item {\bf Proposed solution:} Although we have already had some bad experiences dropping MMSE items from specific domains, we could reconsider the proposition in the correlated factors situation. The items may have some potential utility in linking and harmonization activities, but how much and a justification for their inclusion on that basis is unknown.
          \ei
\ei ;
#d cr


copy model`m'.out model-`model`m'roman'.out , replace

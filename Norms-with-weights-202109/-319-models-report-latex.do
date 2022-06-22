* a1a1-305-models.do
* Rich Jones
* 27 Feb 2018
* -----------------
*

* a1-210-figure1-main-outcome-unadjusted.do

tex \newpage
tex \section{Summary statistics using normative sample}

foreach x in Tmem Tlfl Texf Tvdori1 Tvdvis1 Tgcp  {
	tex \newpage
	local foo : var lab `x'
	tex \subsection{`foo'}
	tex {\bf PROPORTION BELOW Seventh percentile cuts}\\[0.5cm]
	estimates restore `x'
	gen cut=.
	replace cut=`x'<(_b[_cons] + rage*_b[rage] + ragei75*_b[ragei75] + ragei85*_b[ragei85] + black*_b[1.black] + hisp*_b[1.hisp] + female*_b[1.female])
	
	tex \begin{center}
	tex \begin{tabular}{llrrr}
	tex Race/ethincity & Sex & N & Age (mean) & Proportion below cut\\
	tex \hline
	
	tex White \\
	tex & Men 
	su cut if female==0 & black==0 & hisp==0
	tex & `r(N)'
	su age if female==0 & black==0 & hisp==0 & missing(cut)~=1
	local foo  : di %5.0f `r(mean)'
	tex & `foo' 
	su cut if female==0 & black==0 & hisp==0
	local foo  : di %5.3f `r(mean)'
	tex & `foo' \\
	tex & Women 
	su cut if female==1 & black==0 & hisp==0
	tex & `r(N)'
	su age if female==1 & black==0 & hisp==0 & missing(cut)~=1
	local foo  : di %5.0f `r(mean)'
	tex & `foo'
	su cut if female==1 & black==0 & hisp==0
	local foo  : di %5.3f `r(mean)'
	tex & `foo' \\[0.25cm]
	
	tex Black or African-American \\
	tex & Men 
	su cut if female==0 & black==1 & hisp==0
	tex & `r(N)'
	su age if female==0 & black==1 & hisp==0 & missing(cut)~=1
	local foo  : di %5.0f `r(mean)'
	tex & `foo'
	su cut if female==0 & black==1 & hisp==0
	local foo  : di %5.3f `r(mean)'
	tex & `foo' \\
	tex & Women 
	su cut if female==1 & black==1 & hisp==0
	tex & `r(N)'
	su age if female==1 & black==1 & hisp==0 & missing(cut)~=1
	local foo  : di %5.0f `r(mean)'
	tex & `foo' 
	su cut if female==1 & black==1 & hisp==0
	local foo  : di %5.3f `r(mean)'
	tex & `foo' \\[0.25cm]
	
	
	tex Hispanic or Latino \\
	tex & Men 
	su cut if female==0 & black==0 & hisp==1
	tex & `r(N)'
	su age if female==0 & black==0 & hisp==1 & missing(cut)~=1
	local foo  : di %5.0f `r(mean)'
	tex & `foo'
	su cut if female==0 & black==0 & hisp==1
	local foo  : di %5.3f `r(mean)'
	tex & `foo' \\
	tex & Women 
	su cut if female==1 & black==0 & hisp==1
	tex & `r(N)'
	su age if female==1 & black==0 & hisp==1 & missing(cut)~=1
	local foo  : di %5.0f `r(mean)'
	tex & `foo'
	su cut if female==1 & black==0 & hisp==1
	local foo  : di %5.3f `r(mean)'
	tex & `foo' \\[0.25cm]
	
	tex {\bf Total} \\
	su cut 
	tex && `r(N)'
	su age if missing(cut)~=1
	local foo  : di %5.0f `r(mean)'
	tex & `foo'
	su cut 
	local foo  : di %5.3f `r(mean)'
	tex & `foo' \\[0.25cm]
	
	tex \hline
	tex \end{tabular}
	tex \end{center}
	
	tex More details: by age
	texdoc stlog
	* Proportion falling below cut
	table _demgroup agegroup , c(mean cut) f(%5.3f) row col
	* Sample size
	table _demgroup agegroup , row col
	texdoc stlog close
	
	gen `x'_below_cut = cut
	cap drop cut
}
	
	
* number below cuts
cap macro drop _count_factors
cap macro drop _below_cuts_are
local count_factors "Tmem Tlfl Texf Tvdori1 Tvdvis1"
foreach x in `count_factors' {
  local below_cuts_are = "`below_cuts_are' `x'_below_cut"
}
scoreit `below_cuts_are' , gen(deficit_count)

tex \newpage
tex \subsection{Number of tests below cut}
tex The \verb+deficit_count+ variable is the number of five factor scores
tex (memory, executive function, language and fluency, orientation, visuospatial)
tex that fall below the identified 7th percentile given age (with knots at
tex age 75 and 85), sex, race and ethnicity group.

texdoc stlog
tabulate deficit_count normexcld , col
texdoc stlog close

tex This is still in the normative sample.




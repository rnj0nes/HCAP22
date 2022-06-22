* a1a1-305-models.do
* Rich Jones
* 27 Feb 2018
* -----------------
*

* a1-210-figure1-main-outcome-unadjusted.do

tex \newpage
tex \section{Analyses using UNSELECTED HCAP sample}
use w120.dta , clear


foreach x in Tmem Tlfl Texf Tvdori1 Tvdvis1 Tgcp  {
	if regexm("`x'","random")~=1 {
		tex \newpage
		local foo : var lab `x'
		tex \subsection{`foo'}
		tex {\bf PROPORTION BELOW Seventh percentile cuts - UNSELECTED HCAP SAMPLE}\\[0.5cm]
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
tex The \verb+deficit_count+ variable is the number of six factor scores
tex (immediate episodic memory, delayed episodic memory, recognition
tex memory, executive function, attention/speed, language and fluency)
tex that fall below the identified 7th percentile given age (with knots at
tex age 75 and 85), sex, race and ethnicity group.

texdoc stlog
tabulate deficit_count normexcld , col
texdoc stlog close

tex This is the UNSELECTED HCAP sample.

tex \newpage
tex \subsection{General cognitive composite UNSELECTED HCAP SAMPLE}

_pctile Tgcp if normexcld==0 , p(7 31)
local cut1  : di %5.3f `r(r2)'
local cut2  : di %5.3f `r(r1)'

gr tw  ///
	(kdensity Tgcp if normexcld==0 , clp(solid) color(blue%50*.5) lw(thick)) ///
	(kdensity Tgcp if normexcld==1 , clp(solid) color(red%50*.5) lw(thick)) ///
	, legend(off) xline(`cut1') xline(`cut2') xlab(-4 -3 -2 `cut1' `cut2' 1 2 3) ///
	xtick(-4.5(.5)3) ///
	text(.55 `cut2' "Severe cognitive impairment " , place(w)) ///
	text(.55 `cut1' "MCI" , place(w)) text(.55 3 "No cognitive impairment " , place(w)) ///
	text(.15 -2 "Excluded", place(w) color(red*.5))  ///
	text(.15 1.7 "Included", place(e) color(blue*.5)) ///
	ytitle(Density) ///
	xtitle(General cognition (EAP score estimate))

gr export density.png , width(1000) replace

tex \begin{center}
tex \includegraphics[width=\textwidth]{density.png}
tex \end{center}

tex We could use the general factor score estimate to identify persons with
tex global cognitive impairment. The domain specific scores could be used
tex to identify specific subtypes.\\[0.5cm]

tex Let persons with a global composite score less than -0.5SD from the
tex mean in the normative sample
tex be considered
tex MCI and persons with scores less than -1.5SD
tex from the mean in the normative sample be considered
tex severe cogintive impairment (and probably dementia).
tex Results of such a scheme and 
tex comparison to \verb+lwdx+ on next page.
tex \newpage

cap drop Tgcp_category
gen Tgcp_category=1 if missing(Tgcp)~=.



replace Tgcp_category=2 if Tgcp<`cut1'
replace Tgcp_category=3 if Tgcp<`cut2'
vlabel Tgcp_category Normal MCI SCI 
tabulate Tgcp_category normexcld , col

texdoc stlog
tabulate Tgcp_category 
tabulate lwdx 
tabulate Tgcp_category lwdx , row col cell
kap Tgcp_category lwdx
texdoc stlog close

tex \newpage
gr tw  ///
	(kdensity Tgcp if lwd==1 , clp(solid) color(blue%50*.5) lw(thick)) ///
	(kdensity Tgcp if lwdx==2 , clp(solid) color(green%50*.5) lw(thick)) ///
   (kdensity Tgcp if lwdx==3 , clp(solid) color(red%50*.5) lw(thick)) ///
	, legend(off) ///
	xline(`cut1') xline(`cut2') ///
	xlab(-4 -3 -2  `cut1' `cut2' 1 2 3) ///
	xtick(-4.5(.5)3) ///
	text(.55 `cut2' "Severe cognitive impairment " , place(w)) ///
	text(.55 `cut1' "MCI" , place(w)) text(.55 3 "No cognitive impairment " , place(w)) ///
	text(.15 -3.5 "lwdx=3", place(w) color(red*.5))  ///
	text(.15 -2 "lwdx=2", place(w) color(green*.5))  ///
	text(.15 1.7 "lwdx=1", place(e) color(blue*.5)) ///
	ytitle(Density) ///
	xtitle(General cognition (EAP score estimate))

gr export density2.png , width(1000) replace
graph close

tex \begin{center}
tex \includegraphics[width=\textwidth]{density2.png}
tex \end{center}









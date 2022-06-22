* 299-Table1.do


use w120.dta , clear
tex \newpage
tex \section{Descriptives}
tex \subsection{Sociodemograhpics}




table1 age agegroup female black hisp , by(normexcl) tex(tab`++t'.tex)
tex \input{tab`t'.tex}
tex

tex \newpage
tex \subsection{Test scores}
tex Note all cognition scores are T-scaled scored factor score
tex estimates. The general cognition score derives from a 
tex second order factor model, and the orientation and visuospatial
tex scores are single value test scores, all others (mem, exf, lfl) are EAP factor
tex score estimates from single factor models standardized using
tex plausible value factor score estimate standard deviation. All are standardized
tex using the normative sample mean and standard deviation.\\

table1 Tmem Tlfl Texf Tvdori1 Tvdvis1 Tgcp , by(normexcld) tex(tab`++t'.tex)
tex \input{tab`t'.tex}
tex

local slab_Tmem "Memory"
local slab_Tlfl "Language, fluency"
local slab_Texf "Executive function"
local slab_Tvdori1 "Orientation"
local slab_Tvdvis1 "Visuospatial"
local slab_Tgcp "General cognition"

* Test scores by age group
tex \newpage
tex \subsection{Test scores by age group (Mean) in Normative Sample}
tex \begin{center}
tex \begin{scriptsize}
tex \begin{tabular}{l r r r r r r r r r}
tex      & \multicolumn{8}{c}{Age group} \\
tex \cline{2-9} 
tex Test & \textless 65 & 65- & 70- & 75- & 80- & 85- & 90- & 95+ & r(age) \\
tex \hline
foreach x in Tmem Tlfl Texf Tvdori1 Tvdvis1 Tgcp {
	forvalues j=0/7 {
		su `x' [fw=hcap16wgt] if agegroup==`j' & normexcld==0
		local m`j' : di %3.1f `r(mean)'	
	}
	rnj_sparkline , values(`m0' `m1' `m2' `m3' `m4' `m5' `m6' `m7')
	tex `slab_`x'' & `m0' & `m1' & `m2' & `m3' & `m4' & `m5' & `m6' & `m7'  & `r(spark)' 
	corr `x' rage if normexcld==0
	local foo : di %3.2f `r(rho)'
	tex `foo' \\[0.125cm]
	forvalues j=0/7 {
		cap macro drop _m`j'
	}
}

tex \hline
tex \end{tabular}
tex \end{scriptsize}
tex \end{center}

tex Note: Table entries are estimated means  within age bracket for each cogintive test. 
tex The sparklines indicate the general trajectory of means across age group. r(age) implies
tex the correlation of the tests score with age.


* Test scores by age group
tex \newpage
tex \subsection{Test scores by age group (standard deviation) in Normative Sample}
tex \begin{center}
tex \begin{scriptsize}
tex \begin{tabular}{l r r r r r r r r r}
tex      & \multicolumn{8}{c}{Age group} \\
tex \cline{2-9} 
tex Test & \textless 65 & 65- & 70- & 75- & 80- & 85- & 90- & 95+  \\
tex \hline
foreach x in Tmem Tlfl Texf Tvdori1 Tvdvis1 Tgcp {
	forvalues j=0/7 {
		su `x'  [fw=hcap16wgt] if agegroup==`j' & normexcld==0
		local m`j' : di %3.1f `r(sd)'	
	}
	rnj_sparkbar , values(`m0' `m1' `m2' `m3' `m4' `m5' `m6' `m7')
	tex `slab_`x'' & `m0' & `m1' & `m2' & `m3' & `m4' & `m5' & `m6' & `m7'  & `r(spark)' 
	tex \\[0.125cm]
	forvalues j=0/7 {
		cap macro drop _m`j'
	}
}

tex \hline
tex \end{tabular}
tex \end{scriptsize}
tex \end{center}
tex Note: Table entries are estimated standard deviations within age bracket for each cogintive test. 
tex The height of the sparkspikes indicate the relative magintude of standard deviations
tex across age groups, with the group with the greatest standard deviation having a spike
tex occupying the full line height and the group with the lowest standard deviation
tex having a barely perceptible spike height.




local lab50 "Median [P50]"
local lab25 "25th Percentile [P25]"
local lab10 "10th Percentile [P10]"
local lab7 "7th Percentile [P7] - Approximately 1.5SD from mean"
foreach qtile in 50 25 10 7 {
	tex \newpage
	tex \subsection{Test scores by age group (`lab`qtile'') in normative sample}
	tex \begin{center}
	tex \begin{scriptsize}
	tex \begin{tabular}{l r r r r r r r r r}
	tex      & \multicolumn{8}{c}{Age group} \\
	tex \cline{2-9} 
	tex Test & \textless 65 & 65- & 70- & 75- & 80- & 85- & 90- & 95+ & \(r_s\)(age) \\
	tex \hline
	foreach x in Tmem Tlfl Texf Tvdori1 Tvdvis1 Tgcp {
		forvalues j=0/7 {
			 _pctile  `x'  [fw=hcap16wgt]  if agegroup==`j' & normexcld==0  , p(`qtile') 
			local m`j' : di %3.1f `r(r1)'	
		}
		rnj_sparkline , values(`m0' `m1' `m2' `m3' `m4' `m5' `m6' `m7')
		tex `slab_`x'' & `m0' & `m1' & `m2' & `m3' & `m4' & `m5' & `m6' & `m7'  & `r(spark)' 
		spearman `x' rage if normexcld==0
		local foo : di %3.2f `r(rho)'
		tex `foo' \\[0.125cm]
		forvalues j=0/7 {
			cap macro drop _m`j'
		}
	}

	tex \hline
	tex \end{tabular}
	tex \end{scriptsize}
	tex \end{center}
	
	tex Note: Table entries are estimated precentiles within age bracket for each cognitive test. 
	tex The sparklines indicate the general trajectory of estimated percentile value across age group. 
	tex \(r_s\)(age) implies the Spearman rank correlation of test score and age.
	
}

tex \newpage

gen ageg=.
levelsof agegroup
foreach x in `r(levels)' {
	su age  [fw=hcap16wgt] if agegroup==`x'
	replace ageg=round(`r(mean)',1) if agegroup==`x'
}

preserve
table _demgroup ageg  [fw=hcap16wgt] if ageg~=96 & normexcld==0, c(p7 h1rmsetotal) replace
gr tw ///
  (sc table1 ageg if _demgroup==1 , c(l) lp(solid) lc(blue) ms(i)) ///
  (sc table1 ageg if _demgroup==2 , c(l) lp(solid) lc(red*.5) ms(i)) ///
  (sc table1 ageg if _demgroup==3 , c(l) lp(solid) lc(blue) ms(os) mc(blue)) ///
  (sc table1 ageg if _demgroup==4 , c(l) lp(solid) lc(red*.5) ms(os) mc(red*.5)) ///
  (sc table1 ageg if _demgroup==5 , c(l) lp(solid) lc(blue) ms(S) mc(blue)) ///
  (sc table1 ageg if _demgroup==6 , c(l) lp(solid) lc(red*.5) ms(S) mc(red*.5)) , ///
  legend(label(1 "WM") label(2 "WF") label(3 "BM") label(4 "BF") label(5 "HM") label(6 "HF"))
gr export bygroup.png , width(1000) replace
graph close
restore

tex {\bf MMSE 7th percentile values within age and sex ethnicity groups in normative sample}
tex And excluding the oldest age group that only had 1 person in it in the normative sample

tex \begin{center}
tex \includegraphics[width=\textwidth]{bygroup.png}
tex \end{center}





 


save w299.dta , replace


   
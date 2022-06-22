*** a1a1-305-models.do
* Rich Jones
* 27 Feb 2018
* -----------------
*

* a1-210-figure1-main-outcome-unadjusted.do


foreach x in Tmem Tlfl Texf Tvdori1 Tvdvis1 Tgcp  {
	tex \newpage
	local foo : var lab `x'
	tex \subsection{`foo'}
	tex {\bf Seventh percentile cuts}\\[0.5cm]
	tex \begin{center}
	tex \begin{scriptsize}
	tex \begin{tabular}{r | p{2cm}p{2cm} |p{2cm}p{2cm} |p{2cm}p{2cm}}
	tex & \multicolumn{2}{|l}{White}
	tex & \multicolumn{2}{|l}{Black or African-American}
	tex & \multicolumn{2}{|l}{Hispanic} \\
	tex \multicolumn{1}{l|}{Age}	
	tex & Men & Women
	tex & Men & Women
	tex & Men & Women \\
	tex \hline
	forvalues i=65/104 {
		di in yellow "estimates restore `x'"
		estimates restore `x'
		local age=`i'
		local ragei75=`i'-75
		local ragei85=`i'-85
		local df "%5.2f"
		local  c1 : di `df' _b[_cons] + `age'*_b[rage] + `ragei75'*_b[ragei75] + `ragei85'*_b[ragei85] + 0*_b[1.black] + 0*_b[1.hisp] + 0*_b[1.female]
		local  c2 : di `df' _b[_cons] + `age'*_b[rage] + `ragei75'*_b[ragei75] + `ragei85'*_b[ragei85] + 0*_b[1.black] + 0*_b[1.hisp] + 1*_b[1.female]
		local  c3 : di `df' _b[_cons] + `age'*_b[rage] + `ragei75'*_b[ragei75] + `ragei85'*_b[ragei85] + 1*_b[1.black] + 0*_b[1.hisp] + 0*_b[1.female]
		local  c4 : di `df' _b[_cons] + `age'*_b[rage] + `ragei75'*_b[ragei75] + `ragei85'*_b[ragei85] + 1*_b[1.black] + 0*_b[1.hisp] + 1*_b[1.female]
		local  c5 : di `df' _b[_cons] + `age'*_b[rage] + `ragei75'*_b[ragei75] + `ragei85'*_b[ragei85] + 0*_b[1.black] + 1*_b[1.hisp] + 0*_b[1.female]
		local  c6 : di `df' _b[_cons] + `age'*_b[rage] + `ragei75'*_b[ragei75] + `ragei85'*_b[ragei85] + 0*_b[1.black] + 1*_b[1.hisp] + 1*_b[1.female]		
		
		* find the direction
		corr h1rmsetotal `x'
		local r=`r(rho)'
		if `r' >0 {
			local SIGN  "<"
		}
		if `r' < 0 {
			local SIGN  ">="
		}
		
		gen cut=.
		replace cut=`x'<(_b[_cons] + rage*_b[rage] + ragei75*_b[ragei75] + ragei85*_b[ragei85] + black*_b[1.black] + hisp*_b[1.hisp] + female*_b[1.female])
		su cut if rage==`i' & black==0 & hisp==0 & female==0 
		if `r(N)'>13 {
			local p1 : di %3.1f 100*`r(mean)'
		}
		else {
			local p1 "--"
		}
		su cut if rage==`i' & black==0 & hisp==0 & female==1 
		if `r(N)'>13 {
			local p2 : di %3.1f 100*`r(mean)'
		}
		else {
			local p2 "--"
		}
		su cut if rage==`i' & black==1 & hisp==0 & female==0 
		if `r(N)'>13 {
			local p3 : di %3.1f 100*`r(mean)'
		}
		else {
			local p3 "--"
		}
		su cut if rage==`i' & black==1 & hisp==0 & female==1 
		if `r(N)'>13 {
			local p4 : di %3.1f 100*`r(mean)'
		}
		else {
			local p4 "--"
		}
		su cut if rage==`i' & black==0 & hisp==1 & female==0 
		if `r(N)'>13 {
			local p5 : di %3.1f 100*`r(mean)'
		}
		else {
			local p5 "--"
		}
		su cut if rage==`i' & black==0 & hisp==1 & female==1 
		if `r(N)'>13 {
			local p6 : di %3.1f 100*`r(mean)'
		}
		else {
			local p6 "--"
		}
		* tex `i' & `c1' (`p1') & `c2' (`p2') & `c3' (`p3') & `c4' (`p4') & `c5' (`p5') & `c6' (`p6') \\
		tex `i' & `c1'  & `c2' & `c3' & `c4'  & `c5'  & `c6'  \\
		forvalues j=1/6 {
			local c`j'`i' = `c`j''
		}
		cap drop cut	
		macro drop _age
		macro drop _ragei75
		macro drop _ragei85
		macro drop _df
		forvalues j=1/6 {
			macro drop _c`j'
			macro drop _p`j'
		}
	}
	tex \hline
	tex \end{tabular}
	tex \end{scriptsize}
	tex \end{center}

	
	tex Note: Table entries are the estimated 7th percentile cut.
	*** S(and the percent in the age, sex, and race/ethnicity strata falling below the cut, if there are least 13 observations in the strata).
	tex \newpage
	tex `foo'
	tex quantile regression estimates
	texdoc stlog
	bsqreg
	su `x' rage ragei75 ragei85 black hisp female
	texdoc stlog close
	
}
	



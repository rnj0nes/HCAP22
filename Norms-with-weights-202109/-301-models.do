* -301-models.do
* 20190626
* Rich Jones

* a1a1-305-models.do
* Rich Jones
* 27 Feb 2018
* -----------------
*

* a1-210-figure1-main-outcome-unadjusted.do


* REPS
local reps "101"

use w299.dta , clear
keep if normexcld==0
save w301a.dta, replace

tex \newpage
tex \section{Norming}
 
tex We're using quantile regression to find the 7th percentile. The 7th percentile
tex is about 

rcall : r1<-qnorm(.07)
local foo  : di %4.2f `r(r1)'

tex `foo' standard deviations (SD) below the sample mean. Note that to get to 1.5 SD
tex more exactly we'd have to seek the 

rcall: r1<-pnorm(-1.5)
local foo : di %5.2f 100*`r(r1)'

tex `foo'-\%th percentile.\\[0.5cm]






tex Note: Bootstrap quantile regression is used (`reps' replications in this report). 
tex No interactions among covariates are
tex included. Linear splines for age with knots at age 75 and 85 are included

foreach x in Tmem Tlfl Texf Tvdori1 Tvdvis1 Tgcp  {
   foreach pis in .07 {
      cap estimates restore `x'
		if _rc~=0 {
			use w301a.dta , clear 
			local cogsare "`cogsare' `x'"    
			local foo : var lab `x'   
			* find the direction
			corr h1rmsetotal `x'
			local r=`r(rho)'
			if `r' >0 {
				local pis=`pis'
			}
			if `r' < 0 {
				local pis =1-`pis'
			}
			bsqreg `x' rage ragei75 ragei85 i.black i.hisp i.female if normexcld==0 , q(`pis') reps(`reps')
			estimates store `x'
		}
	}
}





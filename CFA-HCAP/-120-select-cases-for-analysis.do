* a4-120-select-cases-for-analysis.do
* Rich Jones
* 22 Jan 2019
* -------------------

tex \section{Selection of participants}
tex We limited the analysis to participants with at least 1 non-missing value on the
tex constructed HCAP measures. 

cap drop n
gen n=1

cap drop keep
gen keep=.
foreach var of varlist head-tail {
	if "`var'"~="head" & "`var'"~="tail" {
		replace keep=1 if missing(`var')~=1
	}
}
su n if keep==1
local nkeep=`r(N)'

local ndropped=`c(N)'-`nkeep'
local pdropped  : di %8.0f  100*(`ndropped'/`c(N)')

tex Before applying this restriction, there were `c(N)' records in the data file. After
tex applying this restriction, there are `nkeep' records in the data file.
tex We are dropping `ndropped' (`pdropped'\% of `c(N)') participants from the psychometric data analysis.\\[0.25cm]

cap drop hasmmse
gen hasmmse=1 if missing(h1rmsescore)~=1

cap drop nohasmmse
gen nohasmmse=1 if missing(h1rmsescore)

su hasmmse if keep==0
local nhasmmsenotkept=`r(N)'

su nohasmmse if keep==1
local nkeptbutnommse=`r(N)'

tex It is worth noting that `nhasmmsenotkept' participants were dropped based on this 
tex restriction but had a non-missing MMSE score. 

if `nhasmmsenotkept'>0 {
	su h1rmsescore if keep==0
	local foo  : di %8.0f `r(mean)'
	local goo  : di %8.0f `r(sd)'
	tex These `r(N)' persons had a mean MMSE score of `foo' (standard deviation = `goo').
}

tex Also, `nkeptbutnommse' participants 
tex retained for the psychometric analysis had a missing value on the MMSE total score.



keep if keep==1





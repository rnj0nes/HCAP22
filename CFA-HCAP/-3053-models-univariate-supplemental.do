set trace off
* a4-308-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*


use w305.dta , clear


tex \newpage

local model10roman "IIIA"

local m=10
global mo "`m'"
local domainis "exf"
tex \newpage
tex \subsection{Model `model`m'roman': Executive function (set shifting and attention, speed)}
local model`m'lab "Executive function"
macro drop _varlist
macro drop _catlist
local varlist "vdexf1z vdexf2z vdexf7z"
local varlist "`varlist' vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z"
local catlist "vdasp3"
runmplus `varlist' , ///
	cat(`catlist') output(stdyx) modindices(-0) residuals ///
	savelog(model`m') log(off) ///
	model( ///
   exf by `varlist' ; ///
	)
mat E=r(estimate)
texdoc stlog
fitsis `m'
runmplus_show_output_segment model`m'.out "Number of observations" 1
runmplus_show_output_segment model`m'.out "Number of dependent variables" 1
runmplus_show_output_segment model`m'.out "Chi-Square Test of Model Fit" 5
texdoc stlog close
* omega
local foo : rownames E
foreach x in `foo' {
	if regexm("`x'","stdyx_`domainis'_by_")==1 {
		local y = subinstr("`x'","stdyx_`domainis'_by_","",.)
		local ylistis "`ylistis' `y'"
		local u "`y'"
		if (substr(reverse("`y'"),1,1)=="z")|(substr(reverse("`y'"),1,1)=="c") {
			local u=reverse(substr(reverse("`y'"),2,.))
		}
		eme stdyx_`domainis'_by_`y' , mat(E) 
		local goo = abs(`r(r1)')
		local lambdasare "`lambdasare' `goo'"
		*exit
	}
}
di "`lambdasare'"
omega `lambdasare'
local omegais  : di %3.2f `r(omega)' 
tex {Omega} = `omegais' \\

tex Comment:
tex This model fits poorly.


copy model`m'.out model-`model`m'roman'.out , replace




set trace off
* a4-308-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*


use w305.dta , clear


tex \newpage
tex \subsection{Additional Unidimensional Models}
tex After estimating the correlated factors model (described
tex in the following section), we decided to combine episodic
tex memory delayed and recognition memory factors into a general
tex memory factor, and we also decided to combine the set
tex shifting and attention, speed factors into a single
tex executive functioning factor. Rationale and details of
tex these decisions are described in the next section.
tex In this section of the report, I describe the fit of
tex these new unidimensional models.


local model9roman "IID"
local model10roman "IIIA"

local m=9
global mo "`m'"
local domainis "mem"
tex \newpage
tex \subsection{Model `model`m'roman': Memory (delayed and recognition)}
local model`m'lab "Memory (delayed and recognition)"
cap macro drop _varlist
cap macro drop _catlist
local varlist "`varlist' vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z"
local varlist "`varlist' vdmre1z vdmre2z"

local catlist "vdmde3"
local model`m'lab "Memory (delayed and recognition)"
runmplus `varlist' , ///
	cat(`catlist') output(stdyx) modindices(-0) residuals ///
	savelog(model`m') log(off) ///
	model( ///
   mem by vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z  ; ///
   mem by vdmre1z vdmre2z ; ///
   ceradwl by vdmde1z@1 ; ///
   ceradwl by vdmre1z@1 ; ///
   lm by vdmde2z@1 ; ///
   lm by vdmre2z@1 ; ///
   ceradwl with lm@0  ; ///
   ceradwl with mem@0 ; ///
   lm with mem@0 ;	 ///
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
tex This model fits adequately. The SRMR and CFI indicate good fit, the RMSEA is not
tex as low as would be desired. The loadings in the general domain are greater than
tex the loadings in the specific domains for the bifactor model part, which supports
tex the inclusion of these indicators in the general model.\\[0.25cm]


copy model`m'.out model-`model`m'roman'.out , replace




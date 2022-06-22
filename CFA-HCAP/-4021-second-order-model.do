set trace off
* a4-306-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*

use w305.dta , clear

* ============================================= Model and Table Numbers
include set-m-and-t.do
local model`m'lab "Second order model"
local model`m'roman "XI"

* ============================================= DESCRIBE THE MODEL

tex \newpage
tex \section{Specific alternative model `m': `model`m'roman' - `model`m'lab'}

tex With orientation. No immediate recognition, no narrow domains.\\[0.5cm]

tex Here's a picture of the model:\\[0.25cm]

tex \begin{center}
tex \includegraphics[width=\textwidth]{HCAP-Final-Second-Order-Model.png}
tex \end{center}



* ============================================= Varlist
local varlist  ""
* ============================================= local varlist "`varlist' vdori1z"
local varlist "`varlist' vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z"
* ============================================= local varlist "`varlist' vdmie1z vdmie2 vdmie3z vdmie4z"
local varlist "`varlist' vdmre1z vdmre2z"
local varlist "`varlist' vdexf1z vdexf2z vdexf7z "
local varlist "`varlist' vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z"
local varlist "`varlist' vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6 "
local varlist "`varlist' vdvis1z"

* ============================================= Locals & Labels
local aspdomain "Attention, speed"
local aspvarlist "vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z"

local exfdomain "Executive functioning" // "Set shifting"
local exfvarlist "vdexf1z vdexf2z vdexf7z `aspvarlist'"


local lfldomain "Language, fluency"
local lflvarlist "vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6 "

* one general memory
local memdomain "Memory"
local memvarlist "vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z vdmie1z vdmie2 vdmie3z vdmie4z vdmre1z vdmre2z"

* narrow memory
local mdedomain "Memory, delayed episodic"
local mdevarlist "vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z "

local miedomain "Memory, immediate episodic"
local mievarlist "vdmie1z vdmie2 vdmie3z vdmie4z "

local mredomain "Memory, recognition"
local mrevarlist "vdmre1z vdmre2z"

local oridomain "Orientation"
local orivarlist "vdori1z"

local visdomain "Visuospatial"
local visvarlist "vdvis1z"

* latent variables 
local g_lab "General cognitive performance"
local lm_lab "Logical memory methods factor"
local brave_lab "Brave man story methods factor"
local ceradwl_lab "CERAD word list methods factor"



local gmem_lab "Memory"
local gmemdomain "Memory"
local gexf_lab "Executive functioning"
local gexfdomain "Executive functioning"




* ============================================= Automatically generated locals
cap confirm file w301a.dta
if _rc~=0 {
	save w301a.dta , replace
}
use w301a.dta , clear

* limited automatic code generation
local methodsfactors "ceradwl  lm"
local narrowfactors ""
local broadfactors "gmem gexf lfl"
local asbroadfactors " vdvis1z"
local moremodel ""
foreach x in `methodsfactors' {
	foreach y in `methodsfactors' `narrowfactors' `broadfactors' `asbroadfactors' g {
		if "`x'"~="`y'" {
			local moremodel "`moremodel' `x' with `y'@0;"
		}
	}
}
local latentsare "g `broadfactors' `narrowfactors' `methodsfactors'"
local domainsare "`broadfactors' `narrowfactors'"
include  locals-generated-automatically.do
foreach var of varlist `varlist' {
	di "``var'_lab' (`var')"
}

* COMPARE TO HIERARCHICAL FACTOR MODEL
use w305.dta , clear
runmplus ///
	vdmde1z     vdmde2z     vdmde4z     vdmde5z     vdmre1z     vdmre2z ///
   vdexf1z     vdexf2z     vdexf7z     vdasp1z     vdasp2z     vdasp4z ///
   vdasp5z     vdlfl1z     vdvis1z     vdori1z  ///
   vdmde3      vdasp3      vdlfl2      vdlfl3      vdlfl4      vdlfl5 ///
   vdlfl6 ,	///
	cat( ///
   vdmde3      vdasp3      vdlfl2      vdlfl3      vdlfl4      vdlfl5 ///
   vdlfl6 ///
	) ///
   output(stdyx) ///
	savelog(modelxidifftest) ///
	log(off) ///
	savedata(difftest = deriv.dat;) ///
	model( ///
   gmem by vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z  ; ///
   gmem by vdmre1z vdmre2z  ; ///
   gexf by vdexf1z@1 vdexf2z vdexf7z  ; ///
   gexf by vdasp1z* vdasp2z* vdasp3* vdasp4z vdasp5z  ; ///
   lfl by vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6  ; ///
	!g by ; ///
	!g@0 ; ///
   ceradwl by vdmde1z@1  ; ///
   ceradwl by vdmre1z@1  ; ///
   lm by vdmde2z@1  ; ///
   lm by vdmre2z@1  ; ///
	!g with ceradwl@0 lm@0 gmem@0 gexf@0 lfl@0 vdvis1z@0 vdori1z@0 ; ///
   ceradwl with lm@0 gmem@0 gexf@0 lfl@0 vdvis1z@0 vdori1z@0 ; ///
	lm with gmem@0 gexf@0 lfl@0 vdvis1z@0 vdori1z@0 ; ///
	gmem with gexf lfl vdvis1z vdori1z ; ///
	gexf with lfl vdvis1z vdori1z ; ///
	lfl with vdvis1z vdori1z ; ///
	vdvis1z with vdori1z ; ///
   )
	
runmplus `varlist' vdori1z , `catis' ///
   output(stdyx) modindices(-0) residuals ///
	savelog(model`m') log(off) ///
	analysis(difftest = deriv.dat;) ///
	model( ///
   gmem by vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z  ; ///
	gmem by vdmre1z vdmre2z ; ///
   gexf by vdexf1z@1 vdexf2z vdexf7z  ; ///
   gexf by vdasp1z* vdasp2z* vdasp3* vdasp4z vdasp5z ; ///
   lfl by vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6  ; ///
	g by vdori1z* ; ///
   g by vdvis1z*  ; ///
   g by gmem@1 gexf* lfl*  ; ///
   ceradwl by vdmde1z@1 ; ///
   ceradwl by vdmre1z@1 ; ///
   lm by vdmde2z@1 ; ///
   lm by vdmre2z@1 ; ///
   `moremodel' )
mat E=r(estimate)
fitsis `m'

local comparelist "`m'"
include summarizemodels2.do

* NOTE ABOUT FIT HERE

tex \newpage
***local comments1 "COMMENTS ABOUT LATENT COVARIANCES HERE"
***local comments2 "comments about factor loadings here"
***local model`m'methodsfactors "COMMENTS ABOUT METHODS EFFECTS HERE"
include summarizehmodel.do

* FINAL NOTES ABOUT MODEL

copy model`m'.out model-`model`m'roman'.out , replace



/*
clear
cap erase model12mi.dta
read_modindices , ///
	out(model`m'.out) ///
	mifile(model`m'mi.dta)
use model`m'mi.dta , clear
keep if regexm(lower(modification),"with")==1
keep if regexm(lower(modification),"vd")==1
keep modification mi epc zxyepc
gen v1=word(modification,1)
gen v2=word(modification,3)
gen l1=word(modification,1)
gen l2=word(modification,3)
drop if regexm(lower(l1),"vd")~=1
drop if regexm(lower(l2),"vd")~=1
forvalues i=1/`c(N)' {
	local foo = l1[`i']
	local goo = l2[`i']
	local foo=lower("`foo'")
	local goo=lower("`goo'")
	foreach x in foo goo {
		if reverse(substr(reverse("``x''"),1,1))=="z" {
			local `x'=reverse(substr(reverse("``x''"),2,.))
		}	
		local foois "l1"
		local goois "l2"
		if "``x''_lab"~="" {
			replace ``x'is'="```x''_lab'" in `i'
		}
	}
}
*replace l1=substr(l1,1,30)
*replace l2=substr(l2,1,30)
gen absis=abs(zxyepc)
gsort -mi
list l1 l2 mi epc zxyepc v1 v2 in 1/20
local mod = modification
local modisa = trim(lower(v1))
local modisb = trim(lower(v2))
local modisla = trim(l1)
local modislb = trim(l2)
local modis "`modisa'_with_`modisb'"

*/

/*
runmplus `varlist' , `catis' ///
   output(stdyx) modindices(-0) residuals ///
	savelog(model`m') log(off) ///
	model(`model' `mod')


	mat Er=r(estimate)

fitsis `m'

tex \subsubsection{Checking residuals}
tex The with largest modification index among the residual covariances was 
tex between between `modisa' and `modisb' [\emph{`modisla'} and \emph{`modislb'}].
tex Here are the fits for the previous model and a model with that
tex parameter freely estimated:

include summarizemodels.do
eme stdyx_`modis' , mat(Er)
tex The overall fits don't change much. But, the 
tex residual correlation estimated between `modisa' and `modisb' has a
tex standardized value of `r(r1)'.\\[0.5cm]
*/
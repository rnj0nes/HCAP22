* 4022-second-order-model-drop-orientation
set trace off
* a4-306-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*

use w305.dta , clear

local model`++m'lab "Second order model-drop orientation"
local model`m'roman "XIA"

* ============================================= DESCRIBE THE MODEL

tex \newpage
tex \section{Specific alternative model `m': `model`m'roman' - `model`m'lab'}

tex Without orientation. No immediate recognition, no narrow domains.\\[0.5cm]


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

*local oridomain "Orientation"
*local orivarlist "vdori1z"

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
   vdasp5z     vdlfl1z     vdvis1z     ///
   vdmde3      vdasp3      vdlfl2      vdlfl3      vdlfl4      vdlfl5 ///
   vdlfl6 ,	///
	cat( ///
   vdmde3      vdasp3      vdlfl2      vdlfl3      vdlfl4      vdlfl5 ///
   vdlfl6 ///
	) ///
   output(stdyx) ///
	savelog(model`m') ///
	log(off) ///
	savedata(difftest = deriv.dat;) ///
	model( ///
   gmem by vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z  ; ///
	gmem by vdmre1z vdmre2z ; ///
   gexf by vdexf1z@1 vdexf2z vdexf7z  ; ///
   gexf by vdasp1z* vdasp2z* vdasp3* vdasp4z vdasp5z ; ///
   lfl by vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6  ; ///
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

copy model`m'.out model-`model`m'roman'.out , replace

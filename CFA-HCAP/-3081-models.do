set trace off
* a4-308-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*

use w305.dta , clear



if "`m'"=="" {
   local m=11
}

local om=`m'
local model`++m'roman "IX" 
local m=`om'


tex \newpage

tex \subsection{Model `model`++m'roman': Correlated factors with single memory and no immediate episodic}

local varlist ""
local varlist "`varlist' vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z"
local varlist "`varlist' vdmre1z vdmre2z"
local varlist "`varlist' vdexf1z vdexf2z vdexf7z"
local varlist "`varlist' vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z"
local varlist "`varlist' vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6"
local varlist "`varlist' vdvis1z"
local varlist "`varlist' vdori1z"

local catlist ""
local catlist "`catlist' vdmde3"
local catlist "`catlist' vdasp3"
local catlist "`catlist' vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6"

local model`m'lab "Correlated factors model no MIE (MDE,MRE)"
runmplus `varlist' , ///
	cat(`catlist') output(stdyx) modindices(-0) residuals ///
	savelog(model`m') log(off) ///
	savedata(difftest = deriv.dat;) ///
	model( ///
   mde by vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z vdmre1z vdmre2z ; ///
   exf by vdexf1z vdexf2z vdexf7z  ; ///
   asp by vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z ; ///
   lfl by vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6  ; ///
   vdvis1z with  mde exf asp lfl  ; ///
   vdori1z with  mde exf asp lfl  ; ///
   vdvis1z with vdori1z  ; ///
   ceradwl by vdmde1z@1 ; ///
   ceradwl by vdmre1z@1 ; ///
   lm by vdmde2z@1 ; ///
   lm by vdmre2z@1 ; ///
   ceradwl with lm@0  ; ///
   ceradwl lm with mde@0 exf@0 asp@0 lfl@0 vdvis1z@0 vdori1z@0  ; ///
	)
fitsis `m'

global start `m'
global end `m'
include summarizemodels.do


copy model`m'.out model-`model`m'roman'.out , replace


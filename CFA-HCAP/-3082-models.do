set trace off
* a4-308-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*

use w305.dta , clear



if "`m'"=="" {
   local m=12
}

local om=`m'
local model`++m'roman "X" 
local m=`om'


tex \newpage

tex \subsection{Model `model`++m'roman': Correlated factors with single memory and no immediate episodic and single executive domain}

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
	analysis(DIFFTEST is deriv.dat;) ///
	model( ///
   mde by vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z vdmre1z vdmre2z ; ///
   exf by vdexf1z vdexf2z vdexf7z  ; ///
   exf by vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z ; ///
   lfl by vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6  ; ///
   vdvis1z with  mde exf  lfl  ; ///
   vdori1z with  mde exf  lfl  ; ///
   vdvis1z with vdori1z  ; ///
   ceradwl by vdmde1z@1 ; ///
   ceradwl by vdmre1z@1 ; ///
   lm by vdmde2z@1 ; ///
   lm by vdmre2z@1 ; ///
   ceradwl with lm@0  ; ///
   ceradwl lm with mde@0 exf@0 lfl@0 vdvis1z@0 vdori1z@0  ; ///
	)
fitsis `m'

global start `m'
global end `m'
include summarizemodels.do


copy model`m'.out model-`model`m'roman'.out , replace

tex {\bf Difference between model IX and X}\\
runmplus , po(model-x.out)
tex The DIFFTEST \(\chi^2\) is `r(difftest_chisquare)' on `r(difftest_chisquare_df)' degrees of freedom, with
pvalueformat 1-chi2(`r(difftest_chisquare_df)',`r(difftest_chisquare)')
tex `r(ptexama)'. So the model does not fit appreciably worse on the
tex basis of fit statistics, but by difference testing of the 
tex model chi-square is statistically significant.\\[0.25cm]

tex \newpage
tex \begin{footnotesize}
include summarizehmodel.do
tex \end{footnotesize}

tex Note that the common factors in this model are more aptly named {\bf Memory}, {\bf Executive functioning} and {\bf Language, fluency}. Immediate episodic memory items are not included. Delayed episodic memory and recognition memory items are contained in a single factor (Memory). Set shifting and attention, speed items are in a single factor (executive functioning). Orientation and visuospatial are in the model as single factor indicators.\\






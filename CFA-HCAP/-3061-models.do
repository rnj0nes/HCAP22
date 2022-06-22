set trace off
* a4-306-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*

use w305.dta , clear




tex \newpage
tex \section{Psychometric modeling - multidimensional models}
tex This model includes all indicators and their specific factors
tex (orientation and visuspatial with single indicators) and
tex no methods factors. Specific factors are allowed to correlate freely.

*** Programming note
*** m is the model counter. At this point the value of m is 10 (20200426)

if "`m'"=="" {
   local m=10
}

local om=`m'
local model`++m'roman "VII" // correlated factors
local model`++m'roman "VIII" // correlated factors with methods factors
local m=`om'+1

local latentsare  "mie mde mre exf asp lfl"
local varlist ""
local catlist ""
local cfmodel ""

foreach x in `domainsare' {
	local varlist "`varlist' ``x'varlist'"
	local foo = subinstr("``x'catlist'","cat(","",.)
	local foo = subinstr("`foo'",")","",.)
	local catlist "`foo'"
	local cfmodel "`cfmodel' ``x'model'"
}

tex \subsection{Model `model`m'roman': Correlated factors model}
local model`m'lab "Correlated factors model"
runmplus `varlist' , ///
	cat(`catlist') output(stdyx) modindices(-0) residuals ///
	savelog(model`m') log(off) ///
	model( ///
	`cfmodel' ///
	`visvarlist' with `latentsare' ; ///
	`orivarlist' with `latentsare' ; ///
	`visvarlist' with `orivarlist' ; ///
	)
fitsis `m'

global start `m'
global end `m'
include summarizemodels.do


tex Comment: Problems with the correlated factors model are standardized covariances
tex among the memory factors greater than 1. This could be due to
tex the fact that the tests are not measuring something distinct, or 
tex are due to the fact that some of the indicators in these
tex domains share stimulus material. I think it's that
tex shared material and will attempt to address with
tex methods factors.

copy model`m'.out model-`model`m'roman'.out , replace


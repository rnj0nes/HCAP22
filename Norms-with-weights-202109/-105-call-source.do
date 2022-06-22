************************************************************************ a4-105-call-source.do
* Rich Jones
* 22 Jan 2019
* -------------------
* call data from source files
* (and process minimally in this file)


tex \section{Source data}

tex Making use of three data files:\\[0.5cm]

tex Using the factor score estimates from the \verb+CFA-HCAP+ workflow,
tex including both Bayesian plausible values and expected a posteriori (EAP) 
tex factor score estimates.\\[0.5cm]


clear
use $analysis/../CFA-HCAP/w401.dta
keep hhid pn rnjid
save ids.dta , replace
use $analysis/../CFA-HCAP/w401-scores.dta
merge 1:1 rnjid using ids.dta
table _merge
cap drop _merge
save w105a.dta , replace


************************************************************************
******
****** NORMING SAMPLE
******
************************************************************************
*local normingsample "hcapnormexcldsummary_20191004.dta"
*local normingsample "hcapnormexcldsummary_20210203"
*local normingsample "modified_hcapnormexcldsummary_20210203"
local normingsample "hcapnormexcldsummary_20210426"
local mmcut "19"

use  $analysis/../a1/w110.dta , clear
lowercase
keep hhid pn h1rmsetotal
save w105a_mmse.dta , replace

local original_norming = subinstr("`normingsample'","modified_","",.)
use $source/`original_norming' , clear
lowercase
merge 1:1 hhid pn using w105a_mmse.dta , nogen
qui su normexcld
local sum1=`r(sum)'
replace normexcld=1 if h1rmsetotal<`mmcut'|missing(h1rmsetotal)
qui su normexcld
local sum2=`r(sum)'
local new_exclusions = `sum2'-`sum1'

tex {\bf Important Note:} The norming sample has been modified as provided by Ryan McCammon. 
tex It has been modified to exclude persons with a MMSE score of less than `mmcut',
tex or missing. An additional `new_exclusions' are excluded. \\[0.5cm]

save w105b.dta , replace
************************************************************************
******
****** END OF NORMING SAMPLE
******
************************************************************************


tex Using an HRS sample data file compiled in the A1 report (February 2019)\\[0.5cm]

use  $analysis/../a1/w110.dta , clear
lowercase
save w105c.dta , replace

use w105c.dta
cap drop _merge
merge 1:1 hhid pn using w105b.dta 
cap drop _merge
merge 1:1 hhid pn using w105a.dta
cap drop _merge

gen w105=1
save w105.dta , replace

tex Using a data file with HCAP participant's level of education provided by Ryan.\\[0.5cm]

use $source/hcap_schooling.dta , clear
merge 1:1 hhid pn using w105.dta , nogen
keep if w105==1
save w105.dta , replace

tex Using weights \verb+hcap2016_weight_20201222.dta+

merge m:1 hhid pn using /Users/rnj/Dropbox/Work/HCAP/POSTED/DATA/SOURCE/hcap2016_weight_20201222.dta
save w105.dta , replace


tex Using a data file with self-reported memory worsening (PD102) from the HRS 2016 Core
cap drop _merge
merge 1:1 hhid pn using pd102.dta 
table _merge
keep if _merge==3
cap drop _merge
save w105.dta , replace




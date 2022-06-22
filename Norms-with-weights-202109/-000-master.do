* HCAP project
* a4-000-master.do
* Rich Jones
* 22 Jan 2019
* -------------------
wfenv HCAP22 , subf(Norms-with-weights-202109) 
local raceadj = "TRUE"
include $analysis/-001-preambling.do // date seed etc
include $analysis/-005-start-latex.do
include $analysis/-105-call-source.do
include $analysis/-110-create-variables.do
include $analysis/-111-standardize-cognition-scores.do
include $analysis/-205-is-related-to-age.do
include $analysis/-207-is-related-to-education.do
include $analysis/-212-some-figures-and-text.do
include $analysis/-800-generate-new-scores.do
include $analysis/-810-appendix-1-distribution.do
include $analysis/-820-appendix-2-density.do
include $analysis/-830-Appendix-3-Which-scores.do 
include $analysis/-840-Appendix-4-Adjustment-Model-Technical-output.do
include $analysis/-990-close-latex.do
save w991.dta , replace
use w991.dta , clear

cap confirm file "w991-003-postimputation.dta"
if _rc~=0 {
   include $analysis/gen-postimputation.do
}

include $analysis/-991-hcap-dementia-report.do









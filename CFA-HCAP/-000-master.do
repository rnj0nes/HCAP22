* HCAP project
* a4-000-master.do
* Rich Jones
* 22 Jan 2019
* -------------------
wfenv HCAP , subf(CFA-HCAP)
include $analysis/-001-preambling.do // date seed etc
include $analysis/-005-start-latex.do
include $analysis/-105-call-source.do
include $analysis/-110-create-variables.do
include $analysis/-120-select-cases-for-analysis.do
include $analysis/-205-table1.do
include $analysis/-206-refine-variables.do
include $analysis/-205-table1.do // yes doing table1 do file twice
include $analysis/-3050-models-introduction.do
include $analysis/-3051-models-univariate.do
include $analysis/-3052-models-univariate-supplemental.do
include $analysis/-3053-models-univariate-supplemental.do
include $analysis/-3061-models.do
include $analysis/-3062-models.do
include $analysis/-3081-models.do
include $analysis/-3082-models.do
include $analysis/-4021-second-order-model.do
include $analysis/-4022-second-order-model-drop-orientation.do
include $analysis/-5010-scores.do
include $analysis/-990-close-latex.do





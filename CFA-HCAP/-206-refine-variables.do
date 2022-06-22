* a4-206-refine-variables.do
* Rich Jones
* 22 Jan 2019
*

tex \section{Refine variables}
tex \subsection{Drop Errors}
tex \bi \item Errors items have low correlations with each other and do not likely measure a single trait
tex     \item Some errors items have logically-induced correlations with correct items, violating local indendence assumptions
tex      \item Therefore, they are dropped from consideration in psychometric models
tex \ei
foreach var of varlist head-tail {
	if regexm(lower("``var'_lab'"),"error")~=1 {
		local vlistis "`vlistis' `var'"
	}
}
order `vlistis'



tex \subsection{Recode categorical items with sparse cells}

* vdmie2 MMSE 3 word recognition
local recodelist "`recodelist' vdmie2"
clonevar vdmie2o=vdmie2
recode vdmie2 (0=0)(1=0)(2=0)(3=1)
vlabel vdmie2 "0-2" "3"
local vdmie2_note  "`vdmie2_note' To address maldistribution issues, observed values of 0, 1 and 2 are collapsed, so the analytic variable vdmie2 is 1 if all are correct, otherwise 0 or missing. (Note that the histogram above does not reflect this recoding.)"
table vdmie2 

* vdmde3 MMSE 3 word delayed recognition
local recodelist "`recodelist' vdmde3"
clonevar vvdmde3o=vdmde3
recode vdmde3 (0=0)(1=0)(2=1)(3=1)
vlabel vdmde3 "0-1" "2" "3"
local vdmde3_note "`vdmde3_note' To address maldistribtion, observed values of 0 and 1 are scored 0, observed values of 2 are scored 1, and observed values of 3 are scored 2. (Note that the histogram above does not reflect this recoding.)"

* vdlfl2 Naming 2 items on HRS TICS Language fluency 
local recodelist "`recodelist' vdlfl2"
clonevar vdlfl2o=vdlfl2
recode vdlfl2 (0=0)(1=0)(2=1)
vlabel vdlfl2 "0-1" "2" "3"
local vdlfl2_note "`vdlfl2_note' To address maldistribtion, observed values of 0 and 1 are scored 0, observed values of 2 are scored 1. (Note that the histogram above does not reflect this recoding.)"

* vdlfl3 Naming 2 items on MMSE
local recodelist "`recodelist' vdlfl3"
clonevar vdlfl3o=vdlfl3
recode vdlfl3 (0=0)(1=0)(2=1)
vlabel vdlfl3 "0-1" "2" "3"
local vdlfl3_note "`vdlfl3_note' To address maldistribtion, observed values of 0 and 1 are scored 0, observed values of 2 are scored 1. (Note that the histogram above does not reflect this recoding.)"


* vdlfl6 1066
local recodelist "`recodelist' vdlfl6"
clonevar vdlfl6o=vdlfl6
recode vdlfl6 (0=0)(1=0)(2=0)(3=1)(4=2)
vlabel vdlfl6 "0-2" "3" "4"
local vdlfl3_note "`vdlfl6_note' To address maldistribtion, observed values of 0-2 are scored 0, observed values of 2 are scored 1, and observed values of 4 are scored 2. (Note that the histogram above does not reflect this recoding.)"


save w206.dta , replace





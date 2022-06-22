* -110-create-variables.do
* 20190626
* Rich Jones


* Age at HCAP in 5-year age bins

la var normexcld "Excluded from normative sample"
la def normexcld 0 "Not excluded" 1 "Excluded"
la val normexcld normexcld

cap drop agegroup
cap drop agetrim
cap drop rage*

cap la drop vl

gen agetrim=min(hcapage,99) 
bracket agetrim , units(5) start(65)
rename agetrim_bracket agegroup
la def vl  7 "[95+" , modify
la def vl  0 "<65" , modify
replace agegroup=0 if hcapage<65
tabulate agegroup
la var agegroup "Age group at HCAP"
tabulate agegroup


gen rage=hcapage
local foo : var lab hcapage
la var rage "[hcpage] `foo'"
contents rage


foreach x in 75 85 {
	gen rage`x'=`x' if missing(rage)~=1
	gen ragec`x'=rage-rage`x' if missing(rage)~=1
	gen raged`x'=rage>`x' if missing(rage)~=1
	gen ragei`x'=ragec`x'*raged`x'
	local table "`table' mean ragei`x')"
}


forvalues j=1/6 {
	gen random`j'=invnorm(uniform())
	la var random`j' "Normal random variable number `j'"
}

vlabel female Men Women
vlabel black All_other_racial_groups Black_or_African_American
vlabel hisp All_other_ethnicity_groups Hispanic_or_Latinx


* Age*Sex*Race
gen _agegroup = 1 if rage<=74
replace _agegroup = 2 if inrange(rage,75,84)
replace _agegroup = 3 if rage>=84 & missing(rage)~=1
vlabel _agegroup under_75 75_to_84 85_and_over
table _agegroup

cap drop _demgroup
gen _demgroup=1     if female==0 & black==0 & hisp==0
replace _demgroup=2 if female==1 & black==0 & hisp==0
replace _demgroup=3 if female==0 & black==1 & hisp==0
replace _demgroup=4 if female==1 & black==1 & hisp==0
replace _demgroup=5 if female==0 & black==0 & hisp==1
replace _demgroup=6 if female==1 & black==0 & hisp==1
vlabel _demgroup WM WF BM BF HM HF
table _demgroup



* Education levels
gen edcat=.
replace edcat = 1 if inrange(schlyrs,0,8)
replace edcat = 2 if inrange(schlyrs,9,11)
replace edcat = 3 if inrange(schlyrs,12,12)
replace edcat = 4 if inrange(schlyrs,13,15)
replace edcat = 5 if inrange(schlyrs,16,16)
replace edcat = 6 if schlyrs>16 & missing(schlyrs)~=1
label var edcat "Education level"
vlabel edcat schlyrs_0-8 schlyrs_9-11 schlyrs_12 schlyrs_13-15 schlyrs_16 schlyrs_17up
sort normexcld
by normexcld: table edcat, c(min schlyrs max schlyrs n schlyrs)


save w110.dta , replace



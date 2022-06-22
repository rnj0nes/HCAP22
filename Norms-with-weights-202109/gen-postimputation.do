use w111.dta, clear

* Merge data and impute
cap drop _merge
merge m:1 hhid pn using $source/hcap2016_weight_20201222.dta

save w991-001.dta , replace 

tempfile f991a
cap drop _merge
save `f991a'
clear

* get 2016 wave weight from tracker 
* prefix "p" is the 2016 wave indicator
use "/Users/rnj/Dropbox/Work/Data/HRS/Public/Tracker File/trk2018tr_r.dta", clear
keep hhid pn pw* hcap* adams1 stratum secu schlyrs race hispanic gender firstiw
foreach x in schlyrs race hispanic gender {
	rename `x' trk_`x'
}
la var hcap16resp "2016 HCAP RESPONSE"
vlabel hcap16resp No_participation Informant_only Respondent_testing_only Both_informant_and_respondent
vlabel hcap16elig Eligible_and_recruitment_into_HCAP_in_2016 Assigned_age_ineligible_prior_to_HRS_2016 Did_not_complete_an_HRS_interview_in_2016 Age_ineligible_at_time_of_HRS_interview_in_2016
vlabel hcap_select Selected Not_selected
vlabel adams1 Initial_assessment_done refused deceased_before_initial_assessment not_selected
keep if missing(hcap_select)~=1
tempfile f991b
save `f991b'
use `f991a'
merge m:1 hhid pn using `f991b'
mergelabel
table _merge

gen racecat3=.
replace racecat3=1 if black==1
replace racecat3=2 if hisp==1
replace racecat3=0 if missing(racecat3)
vlabel racecat3 white Black Hispanic

gen _id=_n
su vdori1 if normexcld==0
gen IMPAIRED_vdori1 = vdori1<`r(mean)'-1.5*`r(sd)' if missing(vdori1)~=1

clonevar Imemm1 = IMPAIRED_memm1 
clonevar Iexfm1 = IMPAIRED_exfm1 
clonevar Ilflm1 = IMPAIRED_lflm1 
clonevar Ivdvis1 = IMPAIRED_vdvis1 
clonevar Ivdori1 = IMPAIRED_vdori1 

cap drop _merge
merge m:1 hhid pn using $source/hcap16_dem_indicators_20201015.dta , nogen

save w991-002-preimputation.dta , replace 

* now imputation
	cap drop rnjid
	egen rnjid=group(hhid pn)
	
	save w991-line59.dta , replace
	
	
	* capture is needed because the imputation-only 
	* runmplus model returns an error code. 
	* capture makes sure the program keeps running
	capture runmplus Imemm1 Iexfm1 Ilflm1 Ivdvis1 Ivdori1 Tmemm1 Texfm1 Tlflm1 Tvdvis1 vdori1 h1ijormsc h1ibl1tot dementiaDx black hisp hcapage edcat female , id(rnjid) ///
	   variable( ///
		   usevariables = Imemm1 Iexfm1 Ilflm1 Ivdvis1 Ivdori1 h1ijormsc h1ibl1tot Tmemm1 Texfm1 Tlflm1 Tvdvis1 vdori1 dementiaDx ; ///
			auxiliary = dementiaDx black hisp hcapage edcat female ; )	///
	   dataimputation( ///
		   IMPUTE  = Imemm1 (c) Iexfm1 (c) Ilflm1 (c) Ivdvis1 (c) Ivdori1 (c) h1ijormsc h1ibl1tot  Tmemm1 Texfm1 Tlflm1 Tvdvis1 vdori1 ; ///
			NDATASETS = 1 ; ///
			SAVE = hcapimp.dat ; ) ///
		analysis(type=basic ; bseed = 3481; ) ///
		savelogfile(foogoo) ///
		tech8

   clear
	runmplus_load_savedata , out(foogoo.out)

	rename imemm1 Imemm1 
	rename iexfm1 Iexfm1 
	rename ilflm1 Ilflm1 
	rename ivdvis1 Ivdvis1 
	rename ivdori1 Ivdori1 
	rename h1ijorms h1ijormsc 
	rename h1ibl1to h1ibl1tot
	rename tmemm1 Tmemm1
	rename texfm1 Texfm1
	rename tlflm1 Tlflm1
	rename tvdvis1 Tvdvis1
	* rename vdori1 vdori1
	keep rnjid Imemm1 Iexfm1 Ilflm1 Ivdvis1 Ivdori1 h1ijormsc h1ibl1tot Tmemm1 Texfm1 Tlflm1 Tvdvis1 vdori1 
	tempfile goofoo

   save w991-line90.dta , replace

	use w991-line59.dta , clear
	
	rename Imemm1 oImemm1
	rename Iexfm1 oIedfm1
	rename Ilflm1 oIlflm1
	rename Ivdvis1 oIvis
	rename Ivdori1 oIvdori1
	rename h1ijormsc oh1ijormsc
	rename h1ibl1tot oh1ibl1tot
	rename Tmemm1  oTmemm1 
	rename Texfm1  oTexfm1 
	rename Tlflm1  oTlflm1 
	rename Tvdvis1 oTvdvis1 
	rename vdori1 ovdori1 
	
	merge 1:1 rnjid using w991-line90.dta	, nogen
	
	* range on imputed values matches original
	foreach x in h1ijormsc h1ibl1tot Tmemm1 Texfm1 Tlflm1 Tvdvis1 vdori1 {
	   su o`x'
		replace `x' = `r(min)' if `x' < `r(min)' & missing(`x')~=1
	   replace `x' = `r(max)' if `x' > `r(max)' & missing(`x')~=1
	}

save w991-003-postimputation.dta , replace
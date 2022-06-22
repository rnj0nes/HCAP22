* a4-005-start-latex.do
* Rich Jones
* 22 Jan 2019
* -------------------
cap erase a6.tex
texdoc init a6
starttex , tex(a6.tex) arial article usepackage(multirow)
tex {\bf Rich Jones} for HCAP Diagnosis Sub-committee \\
tex `today' \\


if "`raceadj'" == "TRUE" {
	tex \begin{center}
	tex {\bf HCAP Standardization, Normalization, and Thresholding}\\
	tex (With adjustment for race/ethnicity)\\[0.5cm]
	tex \end{center}
}
if "`raceadj'" == "FALSE" {
	tex \begin{center}
	tex {\bf HCAP Standardization, Normalization, and Thresholding}\\
	tex (Without adjustment for race/ethnicity)\\[0.5cm]
	tex \end{center}
}


cap confirm file w111.dta 
if _rc==0 {
	tex \begin{small}
tex {\bf Objective}. This document continues analyses of US Health and Retirement Study 
tex Harmonized Cognitive Assessment Protocol (HCAP) data.\\
	
	tex {\bf Sample}. The HRS/HCAP sample was stratified into a norming sample and an excluded-from-norming sample (described elsewhere).
	tex The norming sample included 
	use w111.dta , clear
	gen _id=_n
	distinct _id if normexcld==0 & missing(gcp)~=1
	tex `r(ndistinct)' persons, the excluded sample
	distinct _id if normexcld==1 & missing(gcp)~=1
	tex `r(ndistinct)' persons. \\
	
	
	tex {\bf Measures and procedures}. Estimates of cognitive performance, including factor score estimates (plausible values
	tex and expected a posteriori scores) assessing memory, executive, language,
	tex visuospatial, and global cognitive performance (described elsewhere) were standardized and normalized
	tex with respect to the effects seen in the normative sample attributable to 
	
	if "`raceadj'" == "TRUE" {
		tex  age, sex, education level, and race/ethnicity. 
		local adjfactorsare "age, sex, education level, and race/ethnicity"
	}
	if "`raceadj'" == "FALSE" {
		tex  age, sex, and education level, {\bf (NB: not race/ethnicity)}.
		local adjfactorsare "age, sex, and education level"
	}
	
	
	tex The age effect was modeled using restricted cubic splines, whereas all others predictors were
	tex treated as linear predictors. (We evaluated and rejected alternative parameterizations for education,
	tex including a priori defined categorization, restricted cubic splines, and multiple linear spline functions). 
	tex Adjustment for sociodemographics was accomplished with linear regression. Residuals were normalized to a
	tex T score distribution and used as a demographically-adjusted measure of cognitive performance. The
	tex resulting scores have a mean of 50 and standard deviation of 10 in a hypothetical population with distribution
	tex of `adjfactors' similar to our norming sample. As T scores, any participant
	tex scoring below 36 has a level of performance about 1.5 standard deviations below what would be expected
	tex for someone of their `adjfactors'.\\

	tex {\bf Results}. 
	tex We find that 
	su IMPAIRED_gcpm1 if normexcld==0
	local w005a  : di %2.0f 100*`r(mean)'
	tex `w005a' \% of the norming sample is impaired on a global composite of performance on the HCAP tests (GCP[PV]),
	tex and that
	su IMPAIRED_gcpm1 if normexcld==1
	local w005b  : di %2.0f 100*`r(mean)'
	tex `w005b' \% of those excluded from the norming sample are so impaired. Overall in the HRS/HCAP sample,
	su IMPAIRED_gcpm1 
	local w005c  : di %3.0f 100*`r(mean)'
	tex `w005c' \% are impaired on this measure of cognition. This prevalence in the norming sample is determined by where we have decided to place the threshold, and the prevalence in the non-norming sample a reflection of how well our selections out of the norming sample identify persons with cognitive impairment.

	qui su vdori1 if normexcld==0
	gen IMPAIRED_vdvori1 = vdori1<`r(mean)'-1.5*`r(sd)'

	scoreit IMPAIRED_memm1 IMPAIRED_exfm1 IMPAIRED_lflm1 IMPAIRED_vdvis1 IMPAIRED_vdvori1 , gen(numimpaired)
	gen impairedon2up=numimpaired>=2 & missing(numimpaired)~=1


	tex If we take performance on two or more sub-domains (memory, executive functioning, language and fluency, visuospatial, orientation\footnote{Orientation was not standardized and normalized, due to extremely skewed distribution. We use just count of 10 orientation to time and place questions as the measure of orientation. Cut-offs for impairment are defined in the norming sample.}) as a indicator of possible dementia, we have

	su impairedon2up if normexcld==0
	local w005d  : di %2.0f 100*`r(mean)'
	tex `w005d' \% of the norming sample falling into this category, 
	su impairedon2up if normexcld==1
	local w005e  : di %2.0f 100*`r(mean)'
	tex `w005e' \% of those excluded from the norming sample are in this category, and
	su impairedon2up 
	local w005f  : di %2.0f 100*`r(mean)'
	tex `w005f' \% are impaired on this measure of cognition in the HRS/HCAP overall.

	tex The resulting normalized and standardized scores are only correlated with `adjfactors' to the extent that these factors are correlated with membership in the norming sample. Within the norming sample, the normalized and standardized scores are not correlated with these participant characteristics. 
	tex {\bf Conclusions}. We recommend using normalized factor scores, standardized with respect to sociodemographics, and derived from single domain models. For most applications scores derived as plausible values are preferrable to a posteriori scores.


	tex \end{small}
	tex \newpage
}

tex \tableofcontents

tex {\bf Note on language}\\[0.25cm]

tex Derived scores are {\bf Standardized, adjusted, normalized scores}\\[0.25cm]
tex {\bf Normalized} - taking the rank-based percentile normalization transformation (Blom transformation) of HCAP normative sample scores\\[0.25cm]
tex {\bf Adjusted}  - taking the residuals from regressions of normalized scores on demographics\\[0.25cm]
tex {\bf Standardized} - scaling residuals according to the standard error of estimate from the regression model\\[0.25cm]

tex I may be inconsistent but wanted to get it down one place at least.

tex \newpage




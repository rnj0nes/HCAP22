* -111-standaredize-cognition-scores.do
* 20200624
* Rich Jones

* Age at HCAP in 5-year age bins

use w110.dta , clear

tex \newpage
tex \section{Normalizing, adjusting, and standardizing cognition scores}
tex The estimated factor scores, from the factor analysis work, are on
tex an arbitrary scale. We desired to produce scores that adjusted for
tex the effect of demographic variables in the norming sample and
tex were on a more interpretable scale.\\[0.25cm]

tex We accomplish this by placing the scores on a T-score metric. 
tex A T-score metric has a mean of 50 and standard deviation of 10.
tex T-score metrics are often used in health research settings.\\[0.25cm]

tex We use a regression adjustment procedure to account for the
tex effect of demographic variables on test scores.\\[0.25cm]

tex We use a rank-based normalizing transformation to accomplish two
tex goals. First, the transformation limits the possibility of
tex obtaining out-of-range values from the adjustment procedure. Second,
tex the normalizing transformation makes it easy to identify
tex persons falling below a fixed threshold (in our case, 1.5 SD, or a T score of 35)
tex below the mean in the norming sample.\\[0.25cm]

tex These are the steps in generating standardized scores:

tex \begin{enumerate} \item      {\bf Raw score is rank-normalized} - Each factor score estimate is subject to a rank-based normalizing
tex                transformation (Blom transformation) within the sample of persons
tex                selected for generating norms (the norming sample).

tex \bi \item           {\bf Model back-translation of rank-normalized and raw scores in norming sample.}
tex                     I regress the Blom-transformed score back on to the 
tex                     original factor score estimate using a restricted cubic spline
tex                     with four knots. This regression model is used to generate
tex                     Blom transformed factor scores in the norming sample {\bf and}
tex                     the non-norming sample and any future observation(s). This
tex                     step is necessary because the Blom transformation is dependent
tex                     upon the sample in which it is derived. By generating this
tex                     regression model, I can produce Blom-transformed scores in
tex                     any future sample that reflect the distribution of scores
tex                     observed in the norming sample, regardless of the distribution
tex                     of scores in the new sample. Using restricted cubic splines
tex                     allows a flexible curve shape and typically very high
tex                     predictive accuracy (e.g., for memory plausible values
tex                     the model r-squared is 0.9995, both have means of 0 and 
tex                     standard deviations of 0.999, and the plausible value
tex                     range is from -3.42 to +3.42 and the predicted range
tex                     is from -3.48 to 3.30)

tex      \item          The reason for the Blom transformation is: In the next step
tex                     I will be regressing (Blom-transformed) observed score performance on demographic
tex                     variables. The normalizing transformation helps make sure that
tex                     the predicted values from this regression model do not 
tex                     lead to implausible values

tex \ei


tex      \item     {\bf Regression adjustment}. Regress each Blom-transformed factor score (separately) on age, sex, 

if "`raceadj'" == "TRUE" {
	tex "race/ethnicity, "
}

tex and educational attainment.

tex \bi \item           {\bf Age} is modeled as a continuous predictor using restricted cubic splines with knots at 
tex                     70, 78, 86, 94 (on a range of 65-103). These knots were chosen ad hoc using an 
tex                     empirical process, and fall at the 25th, 60th, 88th, and 99th percentiles of \verb+hcapage+.

tex  \bi \item          The somewhat unusual choice of knot locations is driven by the cross-sectional relationship
tex                     between age and cognitive test score. The shape is distinctly hockey-stick-shaped relationship 
tex                     where a nearly linear performance-age relationship is seen through most of the age range (older
tex                     people performing worse) but then the direction shifts and older people perform better. 
tex                     Consider the relationship for general cognition:
tex                     \begin{sparkline}{7}
tex                     \spark   0.000 1.000   0.167 0.901   0.334 0.702   0.501 0.527   
tex                              0.668 0.313   0.835 0.000   1.002 0.473  / 
tex                     \end{sparkline}.
tex                     This effect is likely caused by the retention of only the most
tex                     cognitively-intact persons among the oldest-old following our
tex                     exclusions from the norming sample. The knot choice is meant to get more parameters estimated
tex                     in the region where the age-performance relationship is more dynamic.
tex  \ei

tex                     \item {\bf Sex} is modeled as male and female using a dummy variable

if "`raceadj'" == "TRUE" {
	tex                     \item {\bf Race and ethnicity} is coarsely modeled with two dummy variables,
	tex                     one indicating Black or African-American, the other Hispanic ethnicty.
}

tex                     \item {\bf Education} is included as a continuous predcitor (0-17)
tex                          \bi
tex                          \item I compared different ways for controlling for education
tex                                \bi  
tex                                \item A continuous variable (0-17)
tex                                \item A categorical predictor identifying the following groups defined in terms of years of completed schooling: 0 \textbackslash 1-8 \textbackslash 9-11 \textbackslash 12 \textbackslash 13-15 \textbackslash 16 \textbackslash 17 and higher.
tex                                \item A restricted cubic spline with 4 knots placed at default locations
tex                                \item A set of models including two linear splines with knots placed from 4 to 15 years
tex                                 \ei
tex                           \item I regressed the estimated GCP (EAP), GCP (PV), MEM (EAP), LFL (EAP), \verb+vdori1+, \verb+vdvis1+, and \verb+h1rmseotal+ on each of the above representations of education. For all except \verb+vdori1+ and \verb+h1rmseotal+ the model with the lowest BIC was the continuous linear function of number of years of education. Orientation favored two linear splines with a knot at 13 years of education, and the MMSE preferred the restricted cubic splines.
tex                          \item Based on the predominance of evidence, I decided to keep education as a continuous predictor.
tex                          \ei											  

tex                     \item {\bf Main effects and two-way interactions} are included. The only
tex                     two-way interaction that is not included is \verb+black*hisp+, because
tex                     in sample there are no persons both Black and Hispanic.

tex \ei

tex     \item      {\bf Compute an} \textbf{\emph{expected score}} for every combination of

if "`raceadj'" == "TRUE" {
	tex  age, sex, education level, and race/ethnicity, 
}
if "`raceadj'" == "FALSE" {
	tex  age, sex, and education level,
}

tex using the results of the regression model. 

tex     \item      {\bf Compute an} \textit{\textbf{adjusted score}} for each person as their observed score minus their
tex                expected score given 

if "`raceadj'" == "TRUE" {
	tex  age, sex, education level, and race/ethnicity.
}
if "`raceadj'" == "FALSE" {
	tex  age, sex, and education level.
}



tex     \item       {\bf Compute an} \textit{\textbf{adjusted, standardized}} score as their observed minus expected score, all divided 
tex                 by the \emph{standard error of estimate} from the regression model, which
tex                 is the overall sample standard deviation of the raw score multiplied by \(\sqrt{1-R^2}\) where
tex                 \(R^2\) is the r-squared from the adjustment model in the norming sample.

tex     \item      {\bf Compute a } \textit{\textbf{adjusted, standardized, and scaled}} score as 
tex                their \emph{adjusted, standardized} score multiplied by 10, plus 50, 
tex                and rounded to the nearest 
tex                integer. This places the standardized score on a roughly T-score metric.

tex \bi \item            {\bf Rounding} We round all factor scores - after transformation - 
tex                      to the nearest whole number, which provides two digits precision.
tex                      \footnote{This should be justified given standard error of
tex                      measurement for factor scores.}
tex \ei

tex     \item      {\bf The 7.5th percentile} for a T score is a value of 35.6. Since
tex                we are rounding to the nearest whole number, a T-score scaled 
tex                factor score of 36 or higher will be considered above threshold, 
tex                and a factor score of 35 or below will be considered below
tex                threshold.

tex \end{enumerate}


local memlab "Memory"
local exflab "Executive functioning"
local lfllab "Language, fluency"
local orilab "Orientation"
local vislab "Visuospatial"
local gcplab "General cognitive performance"

local memdesc "Memory is a factor score estimated from delayed recall and recognition tasks of episodic memory (10 word delayed recall, 3 word delayed recall, Logical Memory II, story recall (EBMT), 10 word recognition and Logical Memory recognition)."

local exfdesc "Executive functioning is a factor score estimated from attention and speed tasks, set shifting tasks, and logical reasoning tasks, including Standard Progressive Matrices, HRS number series, trail making (part A \& B), Symbol Digit Modalities Test, Backwards spelling, Backwards counting, and letter cancellation."

local lfldesc "Language, fluency is a factor score estimated from animal naming, object naming (two objects from TICS), two objects from MMSE, objects from the CSI-D, sentence writing, and read and follow command."

local oridesc "Orientation is not a factor score, but is the observed performance on 10 orientation to time and place items from the Mini-Mental State Examination. For ease of interpretation the observed score is placed on a T-score metric and standardized in the HCAP normative sample. No Bayesian plausible values are estimated for this score."

local visdesc "Visuospatial is not a factor score, but is the observed performance on a constructional praxis (immediate) task. For ease of interpretation the observed score is placed on a T-score metric and standardized in the HCAP normative sample. No Bayesian plausible values are estimated for this score."

local gcpdesc "The GCP (General cognitive performance) score is a second order factor score estimate derived from a model with first-order factors for orientation, memory, executive functioning, language/fluency, and visuospatial functioning."

* need to go get vdori1
save w111a.dta , replace
use $analysis/../CFA-HCAP/w305.dta , clear
keep hhid pn vdori1 vdvis1
tempfile foo
save `foo' , replace
use w111a.dta , clear
merge 1:1 hhid pn using `foo' , nogen

* scores 
local memscores "gmemm1 memm1 gmem mem"
local exfscores "gexfm1 exfm1 gexf exf "
local lflscores "glflm1 lflm1 glfl lfl "
local oriscores "vdori1"
local visscores "vdvis1"
local gcpscores "gcpm1 gcp h1rmsetotal"

local gmemm1lab "Memory factor score from second-order factor model, estimated as a plausible value (draw from posterior)"
local memm1lab "Memory factor score from single-factor model, estimated as a plausible value (draw from posterior)"

tex \newpage
tex \subsection{Key to various scores and tests used in normalization and standardization}
tex \begin{center}
tex \begin{tabular}{p{2cm}p{12cm}}
tex {\bf Domain} & {\bf Description}\\
tex \hline
foreach x in mem exf lfl ori vis gcp {
	tex ``x'lab' & ``x'desc' \\
	tex \\
}
tex \hline
tex \end{tabular}
tex \end{center}

tex \begin{center}
tex \begin{tabular}{llll}
tex {\bf Source}   &              & {\bf Source} & {\bf Type of} \\
tex {\bf estimate} & {\bf Domain} & {\bf model} & {\bf estimate} \\
tex \hline
tex gmemm1         & Memory & Second order & PV \\
tex memm1          & & Single factor & PV \\
tex gmem           & & Second order & EAP \\
tex mem            & & Single factor & EAP \\
tex \hline
tex gexfm1         & Executive Fxn & Second order & PV \\
tex exfm1          & & Single factor & PV \\
tex gexf           & & Second order & EAP \\
tex exf            & & Single factor & EAP \\
tex \hline
tex glflm1         & Language, fluency & Second order & PV \\
tex lflm1          & & Single factor & PV \\
tex glfl           & & Second order & EAP \\
tex lfl            & & Single factor & EAP \\
tex \hline
tex vdori1         & Orientation & Sum of correct responses & NA \\
tex \hline
tex vdvis1         & Visuospatial & CERAD constructional praxis & NA \\
tex \hline
tex gcpm1          & Global & Second order & PV \\
tex gcp            &  & Second order & EAP \\
tex h1rmsetotal    &  & MMSE total score & NA \\
tex \hline
tex \multicolumn{4}{l}{Notes: EAP, Expected a posteriori; NA, Not applicable; PV, Bayesian plausible value.}
tex \end{tabular}
tex \end{center}

tex I will append a \verb+T+ to the front of a source estimate (e.g., \verb+Tgmemm1+) to indicate the T-score (mean 50, sd 10)
tex standardized and normalized estimate. These variables have been rank normalized, adjusted for demographics, and standardized 
tex on a T-score metric (in the normative sample).\\[0.25cm]

tex I will append a \verb+IMPAIRED+ to the front of a source estimate (e.g., \verb+IMPAIRED_gmemm1+) to identify
tex dummy variables that indicate if a person has scored less than 36 on the normalized, adjusted, and standardized
tex estimate.



* Adjust for age using cubic splines
* I will place knots at 75, 85 and 95
cap erase gen_spage_from_age.do
rdoc init gen_spage_from_age.do
local y "hcapage"
local spage_knot1 = 70
local spage_knot2 = 78
local spage_knot3 = 86
local spage_knot4 = 94
r gen spage1=`y'
r gen spage2 = (max((`y'-`spage_knot1')^3,0)-(`spage_knot4'-`spage_knot3')^-1 * (max((`y'-`spage_knot3')^3,0)*(`spage_knot4'-`spage_knot1')-max((`y'-`spage_knot4')^3,0)*(`spage_knot3'-`spage_knot1'))) / (`spage_knot4'-`spage_knot1')^2 if missing(`y')~=1
r gen spage3 = (max((`y'-`spage_knot2')^3,0)-(`spage_knot4'-`spage_knot3')^-1 * (max((`y'-`spage_knot3')^3,0)*(`spage_knot4'-`spage_knot2')-max((`y'-`spage_knot4')^3,0)*(`spage_knot3'-`spage_knot2'))) / (`spage_knot4'-`spage_knot1')^2 if missing(`y')~=1
r * have a nice day
rdoc close

include gen_spage_from_age.do

cap macro drop _Tlist
cap macro drop _IMPAIREDlist

* loop over each score
foreach x in mem exf lfl ori vis gcp {
	foreach y in ``x'scores' {
		di in red "* =============================================" _n _n _col(10) "`y'" _n _n "* ============================================="
		* blom transformation
		cap drop `y'_blom
		* the blom command is a custom ado created by Rich Jones
		blom `y' if normexcld==0
		* model Blom-transformed score as a function of observed score
		* Use restricted cubic spline
		* This model will be used to convert observed factor scores
		* to Blom-transformed factor scores within and outside of 
		* the norming sample
		cap drop sp`y'*
		* with 4 splines the default location are at the 5, 35, 65, and 95th percentiles)
		* 4 knots makes 3 variables
		if "`y'"~="vdori1" {
		   mkspline sp`y' = `y' if normexcld==0 , cubic displayknots nk(4)
			local sp`y'_knot1 = r(knots)[1,1]
			local sp`y'_knot2 = r(knots)[1,2]
			local sp`y'_knot3 = r(knots)[1,3]
			local sp`y'_knot4 = r(knots)[1,4]
			cap erase gen_`y'_blom_from_`y'.do
			rdoc init gen_`y'_blom_from_`y'.do
			r gen sp`y'1=`y'
			r gen sp`y'2 = (max((`y'-`sp`y'_knot1')^3,0)-(`sp`y'_knot4'-`sp`y'_knot3')^-1 * (max((`y'-`sp`y'_knot3')^3,0)*(`sp`y'_knot4'-`sp`y'_knot1')-max((`y'-`sp`y'_knot4')^3,0)*(`sp`y'_knot3'-`sp`y'_knot1'))) / (`sp`y'_knot4'-`sp`y'_knot1')^2 if missing(`y')~=1
	 		r gen sp`y'3 = (max((`y'-`sp`y'_knot2')^3,0)-(`sp`y'_knot4'-`sp`y'_knot3')^-1 * (max((`y'-`sp`y'_knot3')^3,0)*(`sp`y'_knot4'-`sp`y'_knot2')-max((`y'-`sp`y'_knot4')^3,0)*(`sp`y'_knot3'-`sp`y'_knot2'))) / (`sp`y'_knot4'-`sp`y'_knot1')^2 if missing(`y')~=1
	      reg `y'_blom sp`y'1 sp`y'2 sp`y'3 [fw=hcap16wgt]
			r gen P`y'_blom = _b[_cons]+sp`y'1*_b[sp`y'1]+sp`y'2*_b[sp`y'2]+sp`y'3*_b[sp`y'3]
			predict p`y'_blom
			r * have a nice day
			rdoc close
			* check my math					 
			su sp`y'* p`y'_blom
			drop sp`y'*
			include gen_`y'_blom_from_`y'.do
			su sp`y'* P`y'_blom if normexcld==0
			su sp`y'* P`y'_blom 
			* store the observed standard deviation (should be very close to 1)
			su P`y'_blom if normexcld==0
			local sd_P`y'_blom = `r(sd)'
			cap confirm file P`y'_blom.dta 
			if _rc~=0 {
				preserve
				keep P`y'_blom spage* female black hisp schlyrs hcapage normexcld hhid pn hcap16wgt
				save P`y'_blom.dta , replace
				restore			
			}
			if "`raceadj'"=="TRUE" {
				* regression
				reg P`y'_blom (c.spage1 c.spage2 c.spage3)##(c.female c.black c.hisp c.schlyrs) c.female#(c.black c.hisp c.schlyrs) c.schlyrs#(c.black c.hisp) [fw=hcap16wgt] if normexcld==0
				reg , coeflegend		
				estimates store `y'	
				local r2`y' = `e(r2)'
				gen E`y'_blom = _b[_cons] //  black=0, hisp=0, female=0
				replace E`y'_blom = E`y'_blom + spage1*_b[spage1]
				replace E`y'_blom = E`y'_blom + spage2*_b[spage2]
				replace E`y'_blom = E`y'_blom + spage3*_b[spage3]
				replace E`y'_blom = E`y'_blom + female*_b[female]
				replace E`y'_blom = E`y'_blom + black*_b[black]
				replace E`y'_blom = E`y'_blom + hisp*_b[hisp]
				replace E`y'_blom = E`y'_blom + (spage1*female)*_b[c.spage1#c.female]
				replace E`y'_blom = E`y'_blom + (spage1*black)*_b[c.spage1#c.black]
				replace E`y'_blom = E`y'_blom + (spage1*hisp)*_b[c.spage1#c.hisp]
				replace E`y'_blom = E`y'_blom + (spage2*female)*_b[c.spage2#c.female]
				replace E`y'_blom = E`y'_blom + (spage2*black)*_b[c.spage2#c.black]
				replace E`y'_blom = E`y'_blom + (spage2*hisp)*_b[c.spage2#c.hisp]
				replace E`y'_blom = E`y'_blom + (spage3*female)*_b[c.spage3#c.female]
				replace E`y'_blom = E`y'_blom + (spage3*black)*_b[c.spage3#c.black]
				replace E`y'_blom = E`y'_blom + (spage3*hisp)*_b[c.spage3#c.hisp]
				replace E`y'_blom = E`y'_blom + (female*black)*_b[c.female#c.black]
				replace E`y'_blom = E`y'_blom + (female*hisp)*_b[c.female#c.hisp]
				replace E`y'_blom = E`y'_blom + schlyrs*_b[c.schlyrs]
				replace E`y'_blom = E`y'_blom + schlyrs*spage1*_b[c.schlyrs#c.spage1]
				replace E`y'_blom = E`y'_blom + schlyrs*spage2*_b[c.schlyrs#c.spage2]
				replace E`y'_blom = E`y'_blom + schlyrs*spage3*_b[c.schlyrs#c.spage3]
				replace E`y'_blom = E`y'_blom + schlyrs*female*_b[c.schlyrs#c.female]
				replace E`y'_blom = E`y'_blom + schlyrs*black*_b[c.schlyrs#c.black]
				replace E`y'_blom = E`y'_blom + schlyrs*hisp*_b[c.schlyrs#c.hisp]
			}
			if "`raceadj'" == "FALSE" {
				* regression			
				reg P`y'_blom (c.spage1 c.spage2 c.spage3)##(c.female c.schlyrs) c.female#c.schlyrs [fw=hcap16wgt] if normexcld==0
				reg , coeflegend	
				estimates store `y'
				local r2`y' = `e(r2)'
				gen E`y'_blom = _b[_cons] //  black=0, hisp=0, female=0
				replace E`y'_blom = E`y'_blom + spage1*_b[spage1]
				replace E`y'_blom = E`y'_blom + spage2*_b[spage2]
				replace E`y'_blom = E`y'_blom + spage3*_b[spage3]
				replace E`y'_blom = E`y'_blom + female*_b[female]
				replace E`y'_blom = E`y'_blom + (spage1*female)*_b[c.spage1#c.female]
				replace E`y'_blom = E`y'_blom + (spage2*female)*_b[c.spage2#c.female]
				replace E`y'_blom = E`y'_blom + (spage3*female)*_b[c.spage3#c.female]
				replace E`y'_blom = E`y'_blom + schlyrs*_b[c.schlyrs]
				replace E`y'_blom = E`y'_blom + schlyrs*spage1*_b[c.schlyrs#c.spage1]
				replace E`y'_blom = E`y'_blom + schlyrs*spage2*_b[c.schlyrs#c.spage2]
				replace E`y'_blom = E`y'_blom + schlyrs*spage3*_b[c.schlyrs#c.spage3]
				replace E`y'_blom = E`y'_blom + schlyrs*female*_b[c.schlyrs#c.female]
			}
			
			
			
			gen T`y'= 50+10*((P`y'_blom-E`y'_blom)/(`sd_P`y'_blom'*sqrt(1-`r2`y''))) // SEE
			
			local Tlist "`Tlist' T`y'"
			gen IMPAIRED_`y' = T`y'<36 if missing(T`y')~=1
			local IMPAIREDlist "`IMPAIREDlist' IMPAIRED_`y'"
			local foo : var lab `y'
			la var T`y' "Standardized, group-normalized `foo'"
			la var IMPAIRED_`y' "Std, group-normed `foo' is less than 36"
		}
	}
}

qui {
	noisily di in green "R-squared values for demographic models" _n "============================================="
	foreach x in mem exf lfl ori vis gcp {
		foreach y in ``x'scores' {
			if "`r2`y''"~="" {
				noisily di in green "R2 `y'" in yellow _col(15) %3.2f `r2`y'' _col(25) %4.3f sqrt(1-`r2`y'')
			}
		}
	}
}


tex \newpage
tex \subsection{Some statistics in the normative sample}
texdoc stlog
su `Tlist' if normexcl==0
texdoc stlog close

tex \newpage
tex \subsection{Some statistics in both samples}
tex \begin{center}
tex \begin{tabular}{l rl rl}
tex                & \multicolumn{2}{c}{normexcl=0}&\multicolumn{2}{c}{normexcl=1}\\
tex {\bf Estimate} & Mean & SD & Mean & SD \\
tex \hline
foreach x in `Tlist' {
	tex \verb+`x'+ 
	foreach j in 0 1 {
		su `x' [fw=hcap16wgt] if normexcl==`j'
		local foo  : di %3.1f `r(mean)'
		local goo  : di %3.1f `r(sd)'
		tex & `foo' & (`goo')
	}
	tex \\
}
tex \hline
tex \end{tabular}
tex \end{center}


tex \newpage
tex \subsubsection{Impairment}

tex Percent impaired (having normalized, adjusted, standardized score less than 36)\\[.5cm]

tex \begin{center}
tex \begin{tabular}{l c c c}
tex                & \multicolumn{1}{c}{normexcl=0}&\multicolumn{1}{c}{normexcl=1}&All HCAP\\
tex {\bf Estimate} & \% & \% & \% \\
tex \hline
foreach x in `IMPAIREDlist' {
	tex \verb+`x'+ 
	foreach j in 0 1 {
		su `x' [fw=hcap16wgt] if normexcl==`j'
		local foo  : di %3.1f `r(mean)'*100
		tex & `foo' 
	}
	su `x' [fw=hcap16wgt]
	local foo : di %3.1f `r(mean)'*100
	tex & `foo' \\
}
tex \hline
tex \end{tabular}
tex \end{center}


save w111.dta , replace



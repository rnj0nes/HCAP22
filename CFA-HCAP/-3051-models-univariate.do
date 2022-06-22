
local vlistis ""
foreach var of varlist head-tail {
	if "`var'"~="head" & "`var'"~="tail" {
		distinct `var'
		if `r(ndistinct)'<=10 {
			local vlistis "`vlistis' `var'"
			local catlist "`catlist' `var'"
			local modelis "`modelis' g by `var';"
		}
		if `r(ndistinct)'>10 {
			z1 `var'
			rename `var'_z1 `var'z
			local vlistis "`vlistis' `var'z"
			local modelis "`modelis' g by `var'z;"
		}
	}
}

* Model Counter
local m=0
* model m
* UNIDIMENSIONAL MODEL WITH NO METHOS FACTOR -----------------------------------------------

local aspvarlist "vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z"
local aspcatlist "cat(vdasp3)"
local aspmodel "asp by `aspvarlist';"

local exfvarlist "vdexf1z vdexf2z vdexf7z "
local exfmodel "exf by `exfvarlist';"

local lflvarlist "vdlfl1z vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6 "
local lflcatlist "cat(vdlfl2 vdlfl3 vdlfl4 vdlfl5 vdlfl6)"
local lflmodel "lfl by `lflvarlist';"

local mdevarlist "vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z "
local mdecatlist "cat(vdmde3)"
local mdemodel "mde by `mdevarlist';"

local mievarlist "vdmie1z vdmie2 vdmie3z vdmie4z "
local miecatlist "cat(vdmie2)"
local miemodel "mie by `mievarlist';"

local mrevarlist "vdmre1z vdmre2z"
local mremodel "mre by vdmre1z@1 vdmre2z@1;"

local orivarlist "vdori1z vdori2 "
local oricatlist "cat(vdori2)"
local orimodel "ori by vdori1z@1 vdori2@1;"

local visvarlist "vdvis1z vdvis2"
local viscatlist "cat(vdvis2)"
local vismodel "vis by vdvis1z@1 vdvis2@1;"

local domainsare "ori mie mde mre exf asp lfl vis"
local oridomain "Orientation"
local miedomain "Memory, immediate episodic"
local mdedomain "Memory, delayed episodic"
local mredomain "Memory, recognition"
local exfdomain "Set shifting"
local aspdomain "Attention, speed"
local lfldomain "Language, fluency"
local visdomain "Visuospatial"


local oricomment "This model fits perfectly, but the standardized measurement slope greater than 1, negative residual variance, and reliability greater than 1 indicate that the two items in this scale are redundant. We are not getting unique information from the TICS name the president item and the other MMSE derived orientation to time and place questions. The TICS item should be dropped because it contains less information. {\bf Therefore this cannot be considered a final model.}\\[1cm] {\bf DECISION}\\ Since there are only two indicators for the \emph{orientation} domain, we have no choice but to consider a single indicator for our best measure of this domain. So, {\bf the proposed measure of the orientation domain is the 10-item sum of orientation to time and place questions in the MMSE.}"

local miecomment "This model fits well overall, but the RMSEA is too high for comfort. The SRMR is good, which implies that the high RMSE might indicate the model is over parameterized. Since this is a single factor model, there are not a lot of places for having included too many parameters. It could be that misfit arises due to local dependence of the MMSE 3 word registration task and the CERAD word list task. {\bf Because of the high RMSEA this cannot be considered a final model.}\\[0.5cm] This model will require some further exploration to determine if fit can be improved."

local mdecomment "This is a good model."
local mrecomment "This is a good model (if we can call a model with only two indicators a good model). The items are reasonably highly correlated (implied about .4) and are not logically dependent upon each other."

local exfcomment "This is a good model. A three indicator model with all continuous factor indicators is just-identified (zero degrees of freedom) and will fit perfectly. The reliability coefficient indicates the factor is sufficiently reliable for group differences research.\\[0.5cm] {\bf However, a more detailed analysis of the impact of excluding the errors indicators} will be pursued in the next section. As noted in the section describing data handling, I dropped the items encoding \emph{errors} on various tests from consideration of inclusion in the factor models. The rationale was low correlations of these items with other items and logical dependencies among some error counts and component scores. But it would be nice to have some additional evidence that those items are not worth including."

local aspcomment "This model fits well overall, but the RMSEA is too high for comfort. The SRMR is good, which implies that the high RMSE might indicate the model is over parameterized. Since this is a single factor model, there are not a lot of places for having included too many parameters. {\bf Because of the high RMSEA this cannot be considered a final model.}\\[0.5cm] This model will require some futher exploration to determine if fit can be improved."

local lflcomment "This is a good model."

local viscomment "This model fits perfectly, but the standardized measurement slope greater than 1, negative residual variance, and reliability greater than 1 indicate that the two items in this scale are redundant. We are not getting unique information from the copy polygons and CERAD constructional praxis. The MMSE item should be dropped because it contains less information. {\bf Therefore this cannot be considered a final model.}\\[1cm] {\bf DECISION}\\ Since there are only two indicators for the \emph{visuospatial} domain, we have no choice but to consider a single indicator for our best measure of this domain. So, {\bf the proposed measure of the visuospatial domain is the CERAD constructional praxis score, and we omit the draw polygons task from the MMSE.}"

local model1roman "I"
local model2roman "IIA"
local model3roman "IIB"
local model4roman "IIC"
local model5roman "III"
local model6roman "IV"
local model7roman "V"
local model8roman "VI"


foreach thud in `domainsare' {
	tex \newpage
	tex \subsection{Model `model`++m'roman': Specific factor model, ``thud'domain'}
	local model`m'lab "``thud'domain' single factor"
	runmplus ``thud'varlist' , ``thud'catlist' model(``thud'model') savelog(model`m') output(stdyx) log(off) modindices(-0) residuals
	fitsis `m'
	global mo "`m'"
	include summarizeamodel.do
	tex Comment:\\
	tex ``thud'comment'
}

* DECISIONS
local orivarlist "vdori1z"
local oricatlist ""
local orimodel ""

local visvarlist "vdvis1z"
local viscatlist ""
local vismodel ""



tex \newpage
tex \subsection{Summary model fit of all initial single factor mdoels}
global start 1
global end `m'
include summarizemodels.do

* SAVE WORKING COPY OF DATA SET------------------------------------------------
save w305.dta , replace

tex \newpage
tex \subsection{Exploring misfit in Model `model2roman'}
** clear
** read_modindices, out(model2.out)
cap confirm file scatter1.png
if _rc~=0 {
	gr tw sc vdmie4 vdmie3 , jitter(3) aspect(1)
	gr export scatter1.png , width(1000) replace
}

#d ;
tex I examined the modification indices from Model `model2roman'. Modification indices are computed for parameters in the model that are constrained to some value (either a fixed value of fixed to be equal to some other parameter). The largest modification index for model `model2roman' was for the correlation of \emph{`vdmie4_lab'} and \emph{`vdmie3_lab'}. This source of residual covariance could be that the observed data are not consistent with a unidimensional model, and this could be due to item content (i.e., story immediate recall and word list immediate recall tap an additional ability or a separate ability from that required to respond to the word list recall items) or something induced by the data. \\[0.25cm]

The way the data could produce a strong residual correlation is through the pronounced floor effect on logical memory immediate seems like a likely candidate for an induced residual correlation due to non-normal distribution:\\[0.25cm]

\begin{tabular}{cc}
\includegraphics[width=0.45\textwidth]{vdmie3.png}
& \includegraphics[width=0.45\textwidth]{vdmie4.png} \\
`vdmie3_lab' & `vdmie4_lab' \\
\end{tabular}
\begin{center}
\includegraphics[width=\textwidth]{scatter1.png}
\end{center}
;
#d cr

tex This floor effect can induce a non-linear relationship between \verb+vdmie3+ and \verb+vdmie4+. We can handle this floor effect a couple of different ways:

tex \begin{enumerate}
tex \item Treat observations at the floor of \verb+vdmie3+ as missing values
tex \item Transform \verb+vdmie3+, we could try either:
tex \bi \item a rank-based transformation (e.g., Blom transformation), or
tex     \item a discretized version (treating 0 as it's own category, and performance
tex           levels beyond 0 as separate ordered categories).
tex \ei
tex \end{enumerate}


tex Treating observations at the floor as missing is rejected because this
tex results in loss of information. My preference is for discretizing, as while this
tex also results in loss of information the magnitude is minimal relative to
tex treating observations at the floor as missing. A percentile rank based 
tex transformation (e.g., Blom transformation) might also work well, 
tex but these are sample dependent and may not
tex translate across settings and therefore not preferred.\\[0.5cm]

tex \subsubsection{Blom transformation to vdmie3}
clonevar original_vdmie3 = vdmie3
clonevar original_vdmie3z = vdmie3z
blom vdmie3z , replace
runmplus `mievarlist' , `miecatlist' model(`miemodel') ///
	 output(stdyx) log(off) modindices(-0) residuals
tex Using a blom transformation on \verb+vdmie3+ decreases the
tex RMSEA to `r(RMSEA)'.

tex \subsubsection{Discretization of vdmie3}
dtize3 original_vdmie3
cap drop vdmie3z
rename original_vdmie3_cat vdmie3z
local miecatlistr = subinstr("`miecatlist'",")"," vdmie3z)",.)

runmplus `mievarlist' , `miecatlistr' model(`miemodel') ///
	 output(stdyx) modindices(-0) residuals
tex Using a discretized version of \verb+vdmie3+ results in a 
tex RMSEA to `r(RMSEA)'.\\[0.25cm]

tex The above results suggest that it is {\bf not the distribution of the data}
tex that is perturbing the fit of model `model2roman'. 
tex Neither of these two approaches are dealing with the poor RMSEA of
tex this model. This last model still has a large, unestimated, residual 
tex covariance between `vdmie4_lab' and `vdmie3_lab'. The source of misfit is
tex more likely a violation of the linearity assumption that is implicit
tex in the factor analysis model. This is also a manifestation of the
tex violation of the assumption of local independence.\\[1cm]

tex{\bf Important note:} In the analyses to follow I return to a continuous normal
tex variable for logical memory performance (\verb+vdmie4z+).


clonevar vdmie3cat=vdmie3z
drop vdmie3z
rename original_vdmie3z vdmie3z

tex \subsubsection{Add residual covariance of vdmie3z and vdmie4z}

runmplus ///
	vdmie1z vdmie2 vdmie3z vdmie4z , ///
	cat(vdmie2) ///
	model( ///
		mie by vdmie1z vdmie2 vdmie3z vdmie4z; ///
		s1 by vdmie3z* (1); ///
		s1 by vdmie4z* (1); ///
		s1@1; ///
		s1 with mie@0; ///		
		!vdmie3z with vdmie4z;) ///
	output(stdyx) modindices(-0) residuals 
	
tex This produces a model with a RMSEA of `r(RMSEA)'.\\[0.5cm]

tex The implication is this selection of items that are intended to 
tex measure immediate episodic memory are not unidimensional. The
tex immediate registration of story information (capured with
tex \verb+vdmie3z+ and \verb+vdmie4z+) are more highly correlated
tex with each other than what is captured by their correlation
tex with the common factor defined by all four variables. The
tex other two items being word list registration items.\\[0.5cm]

tex Problem is, I can acheive similarly good fit by
tex introducing a residual covariance between `vdmie1_lab' (\verb+vdmmie1z+) and
tex `vdmie2_lab' (\verb+vdmie2z+). 


runmplus ///
	vdmie1z vdmie2 vdmie3z vdmie4z , ///
	cat(vdmie2) ///
	model( ///
		mie by vdmie1z vdmie2 vdmie3z vdmie4z; ///
		s1 by vdmie1z* (1); ///
		s1 by vdmie2* (1); ///
		s1@1; ///
		s1 with mie@0; ///
		) ///		
	log(off) output(stdyx) modindices(-0) residuals 
	
tex Such a model produces a RMSEA of `r(RMSEA)'.

tex \subsubsection{Decision on Model `model2lab': `miedomain' revision}
tex {\bf The only information we can use to adjust the `miedomain' 
tex soultion are the factor loadings.} We have ruled out maldistribution
tex of the indicators as a source of misfit. There is some evidence that
tex the unidimensionality assumption of these two word list registration tasks
tex and two story registration tasks is violated. We know that removing one of 
tex the four items will result in a three indicator model that will fit near perfectly
tex and provide only 1 degree of freedom. The only reasonable item to pick is
tex the MMSE three word registration task (\verb+vdmie2+) as this indicator has 
tex the lowest factor loading and result in the least loss of information.\\[0.5cm]

local mievarlist "vdmie1z  vdmie3z vdmie4z "
local miecatlist ""
local miemodel "mie by `mievarlist';"



tex This means {\bf I will also drop the MMSE three word delayed recall task} from 
tex the `mdedomain' model (\verb+vdmde3+).

local mdevarlist "vdmde1z vdmde2z  vdmde4z vdmde5z "
local mdecatlist ""
local mdemodel "mde by `mdevarlist';"

local miecomment2 "This model fits well. But as is discussed on the next page, {\bf This model is ultimately rejected.} The reason why is the cascading decision to remove the MMSE three word delayed recall task as well blows up the MDE model (next page). I decided the least bad of the options was to retain the original MIE model."

local mdecomment2 "This model fits poorly (RMSEA), whereas the previous version of the MDE unidimensional model fit well. Now we have to drill down on poor fit in the MDE domain. Here is what we can do: \bi \item Drop any 1 item and the model will fit perfectly. Logical choice is CERAD constructional praxis, but not satisfactory because that would imply we'd want to drop CERAD constructional praxis from the battery, but it is our preferred measure of visuospatial function. \item Add a residual covariance (e.g., logical memory and brave man are obvious choices). \bi \item If we allow this then we could allow it for the MIE domain and not have to drop the MMSE immediate and delayed three word recall items. \item And if we allow residual covariances, then we would have allowed the residual covariance in the MIE model and would never have recognized the need for a residual covariance in this MDE model.\ei \ei It's not ideal to accept models with poor fit.\\[0.5cm] It is not ideal to propose models that only acheive good fit with the inclusion of residual covariances that were not hypothesized a priori (as in methods effects).\\[0.5cm] {\bf DECISION}\\I decided that the least bad of the options presented is to accept the original MIE model even though the RMSEA for that model is higher than what would be considered ideal."


local Mwas=`m'
local m=1 // because next model is model 2 (revised)
foreach thud in  mie mde {
	tex \newpage
	tex \subsection{Model `model`++m'lab': REVISED Specific factor model, ``thud'domain'}
	local model`m'lab "``thud'domain' single factor"
	runmplus ``thud'varlist' , ``thud'catlist' model(``thud'model') savelog(model`m') output(stdyx) log(off) modindices(-0) residuals
	fitsis `m'
	global mo "`m'"
	include summarizeamodel.do
	tex Comment:\\
	tex ``thud'comment2'
}
local m=`Mwas'

local mdevarlist "vdmde1z vdmde2z vdmde3 vdmde4z vdmde5z "
local mdecatlist "cat(vdmde3)"
local mdemodel "mde by `mdevarlist';"

local mievarlist "vdmie1z vdmie2 vdmie3z vdmie4z "
local miecatlist "cat(vdmie2)"
local miemodel "mie by `mievarlist';"


* restore locals and output for MIE and MDE
local Mwas=`m'
local m=1 // because next model is model 2 (revised)
foreach thud in  mie mde {
	local m = `++m'
	*local model`m'lab "``thud'domain' single factor"
	runmplus ``thud'varlist' , ``thud'catlist' model(``thud'model') savelog(model`m') output(stdyx) log(off) modindices(-0) residuals
	fitsis `m'
	global mo "`m'"
}
local m=`Mwas'

* End of MIE and MDE exploration

use w305.dta , clear
tex \newpage
tex \subsection{Exploring misfit in Model IV (Attention, Speed)}
clear
read_modindices, out(model6.out)

#d ;
tex I examined the modification indices from Model `model6roman'. The largest modification index for model IV was for the correlation of \emph{`vdasp3_lab'} and \emph{`vdasp4_lab'}. These two items contain a clear source of methods-related covariance (keyword backwards). It could be that there is a specific set shifting function relating to backwardsness that drives this correlation (remember, this is supposed to be an attention and speed factor). Or it might be some participants misunderstand the directions, or turn around instead of doing the task backwards.\\[0.25cm]; 
#d cr

use w305.dta , clear
runmplus ///
	vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z , ///
	cat(vdasp3) ///
	model( ///
		asp by vdasp1z vdasp2z vdasp3 vdasp4z vdasp5z ; ///
		vdasp3 with vdasp4z ; ///
		) ///		
	 output(stdyx) modindices(-0) residuals 
mat E = r(estimate)


tex Adding a residual covariance for these two items resolves the 
tex high RMSEA issue, nominally (RMSEA = `r(RMSEA)') but not impressively. 

eme stdyx_vdasp3_with_vdasp4z

tex This residual correlation is of small magnitude (`r(r1)').\\[1cm]

tex {\bf DECISION}\\
tex I decided to keep the original model for `aspdomain' as proposed
tex even though the model fit statitics are not ideal. I would say that there
tex is a pretty good indication that this domain is not exclusively measuring
tex one area of cognitive functioning, and perhaps that is not
tex surprising given the domain name mentions two abilities: Attention \emph{and} speed.


* ------------------------------------- CHECK ON OMITTING ERRORS INDICATORS ---
use w305.dta , clear
tex \newpage
tex \subsection{Check that errors don't belong in Set Shifting domain}

tex In this section we'll run a version of the `exfdomain' model
tex that includes the errors indicators. These items were all
tex highly skewed so we'll include discretized versions (i.e., binned into 
tex up to 9 levels
tex and treated as a categorical variable) of 
tex the errors variables.\\[0.5cm]

forvalues j=3/6 {
	qui dtize3 vdexf`j'
	rename vdexf`j'_cat vdexf`j'c
	local hoo : var lab vdexf`j'
	la var vdexf`j'c "`goo', discretized"
}

runmplus ///
	vdexf1z vdexf2z vdexf7z vdexf3c vdexf4c vdexf5c vdexf6c , ///
	cat(vdexf3c vdexf4c vdexf5c vdexf6c) ///
	model( ///
		exf by vdexf1z*.7 vdexf2z*.7 vdexf7z*.7 ; ///
		exf by vdexf3c*-.7 vdexf4c*-.7 vdexf5c*-.7 vdexf6c*-.7 ; ///
		exf@1; ///
		) ///		
	 output(stdyx) modindices(-0) residuals savelog(model6a)
fitsis 6a
	 
global mo "6a"
include summarizeamodel

tex This model actually fits well. But, the \emph{errors} items
tex have very low loadings, and the factor reliability (omega,
tex computed with absolute values of factor loadings) is 
tex actually higher without these items (compare to model `model5roman' above).\\[1cm]

tex {\bf DECISION}
tex The decision to eliminate the \emph{errors} indicators from the modeling
tex seems to have been reasonable.

tex \newpage
tex \section{Review of single factor models}

tex \bi
tex \item With the exception of `oridomain' (ORI),  `exfdomain' (SSH), and `visdomain' (VIS), we
tex       have retained the original hypothesized model structure. Model fit is
tex       adequate for all of the remaining domains although not quite ideal for some
tex       (`miedomain' [MIE] and `aspdomain' [ASP]).

tex \item {\bf `oridomain'} (ORI) we have dropped the TICS name president item and
tex       retained a single indicator, a sum on the 10 item orientation to time and
tex       place questions from the MMSE.

tex \item {\bf `exfdomain'} (SSH) we have affirmed a decision made prior to factor analysis
tex       models to omit the \emph{errors} indicators.

tex \item {\bf `visdomain'} (VIS) we have dropped the MMSE copy polygons item
tex       and retained a single indicator, the CERAD constructional praxis 
tex       test (immediate).

tex \ei

tex The following section, which looks at a multiple correlated factors model
tex including all domains, will reflect these decisions on inclusion of indicators.


* output
foreach i in 1 2 3 4 5 6 7 8 {
   copy model`i'.out model-`model`i'roman'.out , replace
}




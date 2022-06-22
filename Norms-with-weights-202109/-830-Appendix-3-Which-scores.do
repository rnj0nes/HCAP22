tex \newpage
tex \section{Appendix 3 - Recommended scores}

tex I recommend to users the single domain scores. Either the expected \emph{a posteriori} or plausible values are suitable for use.\\

tex \begin{center}
tex \begin{tabular}{p{3cm}p{3cm}p{3cm}}
tex {\bf Domain} & {\bf EAP} & {\bf PV} \\
tex \hline
tex Memory & \verb+mem+ & \verb+memm1+ \\
tex        & \verb+Tmem+ & \verb+Tmemm1+ \\
tex        & \verb+IMPAIRED_mem+ & \verb+IMPAIRED_memm1+ \\
tex \hline
tex Executive & \verb+exf+ & \verb+exfm1+ \\
tex function & \verb+Texf+ & \verb+Texfm1+ \\
tex          & \verb+IMPAIRED_exf+ & \verb+IMPAIRED_exfm1+ \\
tex \hline
tex Language and & \verb+lfl+ & \verb+lflm1+ \\
tex fluency & \verb+Tlfl+ & \verb+Tlflm1+ \\
tex         & \verb+IMPAIRED_lfl+ & \verb+IMPAIRED_lflm1+ \\
tex \hline
tex Orientation & \verb+vdori1+ & NA \\
tex \hline
tex Visuospatial & \verb+vdvis1+ & NA \\
tex              & \verb+Tvdvis1+ & NA \\
tex              & \verb+IMPAIRED_vdvis1+ & NA \\
tex \hline
tex General & \verb+gcp+ & \verb+gvpm1+ \\
tex cognitive & \verb+Tgcp+ & \verb+Tgcpm1+ \\
tex performance & \verb+IMPAIRED_gcp+ & \verb+IMPAIRED_gcpm1+ \\
tex \hline
tex \end{tabular}
tex \end{center}

tex \bigskip

tex \subsection{When to use EAP vs PV}
tex When we estimate a factor score, there is some level of imprecision in that estimate. The imprecision is
tex determined by the number of items used in the factor score, the strength of the correlation between
tex the items and the underlying factor, and the distribution of difficulty levels of the items. Factors with
tex more items, items with strong relationships with the underlying factor, and many and widely dispersed
tex difficulty levels will have less imprecision than factors with only a few items with weak relationships with
tex the underlying factor and coarse and skewed responses. If a factor is measured by all continuous indicators, imprecision is
tex constant across the level of the latent trait. But if a factor is measured with at least one categorical indciator, imprecision will
tex vary across the level of the latent trait, generally being higher at the extremes.\\[0.5cm]

tex When we generate factor score estimates as plausible values, each person's score is 
tex a draw from the posterior distribution of their factor score estimate, whch is determined by
tex the level of imprecision of the factor score. These are analogous to imputations in multiple imputation. 
tex In fact, it might be desireable to use multiple plausible values generated for each participant as if they were
tex multiply imputed values in a data analysis.\\[0.5cm]

tex If we were to take a large number of draws from the posterior for each participant, and then compute the
tex mean of each persons' plausible values - that mean would approach the expected \emph{a posteriori} estimate
tex we obtain for each person.\\[0.5cm]

tex {\bf I recommend using plausible values} (or multiple plausible values) in any cirmumstance where 
tex population-level parameter estimation and inference is desired. Use of EAP estimates in such
tex circumstances is anti-conservative and may result in biased low standard errors in inflated type-I error levels.
tex In some situations, such as descriptive
tex analysis\footnote{Especially describing the limits of resolution of the factor score. EAP estimates will
tex retain floors, ceilings, and discontinuities in measurement due to coarse or sparsely distributed
tex difficulty parameters, whereas Bayesian plausible values will invariably return smoothed and normally
tex distributed factor score estimates. It is important to examine both to be sure that the factor has items that
tex measure underlying ability meaningfully in the region relevant to the research question.}, 
tex or in a high-stakes decision making procedure (e.g., selecting participants for a module or
tex sub-study) the EAP estimates would be preferable. \\[0.5cm]

tex \subsection{Why single domain scores of individual domains are preferred to scores derived from multidimensional models}

tex Specific domain factor scores, when derived from a model that only includes more that one latent trait (e.g., a general
tex trait and specific domains), reflect performance in general and on the specific trait. Specific domain factor scores
tex when generated from an item set that only includes items assessing the specific domain are blind to performance on the other domains. 
tex It is hard to imagine a situation where the estimates deriving from multidomain models would be preferable to
tex single domain models.\\[0.25cm]

tex The main purpose of multidomain model-derived factor scores was to explore ways of harmonizing cross-national data where 
tex some of the items may differ. This is ongoing work.\\[0.25cm]

tex {\bf Demonstration}\\
tex Based on the above comments, when we examine the different kinds of scores, we should see:

tex \bi
tex \item plausible values return \emph{smaller} effect sizes and larger P-values than EAP scores
tex \item Multidomain derived scores return \emph{larger} effect sizes than single domain scores.
tex \ei

tex Let's use the contrast between those excluded from the norming sample to test these predictions.

use w111.dta , clear
keep hhid pn normexcld ///
   Tmem Tmemm1 Tgmem Tgmemm1 ///
	Texf Texfm1 Tgexf Tgexfm1 ///
	Tlfl Tlflm1 Tglfl Tglflm1 
rename Tmem    y100
rename Tmemm1  y101
rename Tgmem   y110
rename Tgmemm1 y111
rename Texf    y200
rename Texfm1  y201
rename Tgexf   y210
rename Tgexfm1 y211
rename Tlfl    y300
rename Tlflm1  y301
rename Tglfl   y310
rename Tglflm1 y311
reshape long y10 y11 y20 y21 y30 y31 , i(hhid pn normexcld) j(pv)
reshape long y1 y2 y3 , i(hhid pn normexcld pv) j(g)
reshape long y , i(hhid pn pv g normexcld) j(domain)
la def domain 1 "mem" 2 "exf" 3 "lfl"
la val domain domain
egen hhidpn=group(hhid pn)
table domain
contents


forvalues r=1/3 {
	di "reg y normexcld if domain==`r' & g==0 & pv==0"
	reg y normexcld if domain==`r' & g==0 & pv==0
	local cell`r'1 : di %5.1f _b[normexcld]/_se[normexcld] 
	di "reg y normexcld if domain==`r' & g==0 & pv==1"
	reg y normexcld if domain==`r' & g==0 & pv==1
	local cell`r'2 : di %5.1f _b[normexcld]/_se[normexcld] 

	di "reg y normexcld if domain==`r' & g==1 & pv==0"
	reg y normexcld if domain==`r' & g==1 & pv==0
	local cell`r'3 : di %5.1f _b[normexcld]/_se[normexcld] 
	di "reg y normexcld if domain==`r' & g==1 & pv==1"
	reg y normexcld if domain==`r' & g==1 & pv==1
	local cell`r'4 : di %5.1f _b[normexcld]/_se[normexcld] 
}


 
tex The table below contains \emph{z} statistics (estimate divided by standard error)
tex for the contrast of \verb+normexcld=1+ vs \verb+normexcld=0+ on
tex various flavours of factor scores.\\[0.5cm]
tex \begin{center}
tex \begin{tabular}{l|ll|ll}
tex &\multicolumn{2}{|c}{Single domain}&\multicolumn{2}{|c}{Multiple domain} \\
tex &EAP&PV&EAP&PV\\
tex \hline
tex MEM & `cell11' & `cell12' & `cell13' & `cell14' \\
tex EXF & `cell21' & `cell22' & `cell23' & `cell24' \\
tex LFL & `cell31' & `cell32' & `cell33' & `cell34' \\
tex \hline
tex \end{tabular}
tex \end{center}

tex The table demonstrates the predictions are borne out, and reinforces that {\bf plausible value single domain scores}
tex are the preferred scaling, being the theroretically most appropriate and empirically most conservative set of scores.










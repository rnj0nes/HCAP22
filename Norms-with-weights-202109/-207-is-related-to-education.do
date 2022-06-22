tex \newpage
tex \subsubsection{But are scores related to education?}
tex The normalized, adjusted, and standardized scores should not be related to education
tex in the normative sample, but may be in the non-normative sample and HCAP overall.
tex As with age discussed in the previous section, the correlation of 
tex education and test score, in the overall HCAP sample,
tex some correlation of education and test score derives indirectly 
tex from the association of education and inclusion in the norming sample.\\[0.25cm]

tex Consider that the Spearman correlation of education (\verb+schlyrs+) and inclusion in the 
tex norming sample is 

spearman schlyrs normexcld
local r1 : di %3.2f  `r(rho)'

tex `r1', and the Spearman correlation of being included in the norming sample
tex and the GCP (plausible value) score (before adjustment, \verb+gcpm1+) is 

spearman gcpm1 normexcld 
local r2 : di %3.2f  `r(rho)'

tex `r2', then we expect a correlation of the education (and other demographic factor)
local foo : di %3.2f   `r1'*`r2'
tex adjusted GCP score and education to be no more than \(`r1' \times `r2' = \) `foo'.
tex We actually observe 

spearman Tgcpm1 schlyrs
local goo : di %3.2f  `r(rho)'

tex `goo'.\\[0.25cm]

tex The table below contains means across education groups and Spearman rank correlations
tex of the T score and educational attainment. In parenthesis, I 
tex show the Spearman correlation of the unadjusted score with education.\\[0.25cm]


tex \begin{center}
tex \begin{longtable}{l rl rl rl }
tex                & \multicolumn{2}{c}{normexcl=0}&\multicolumn{2}{c}{normexcl=1} & \multicolumn{2}{c}{All HCAP}\\
tex {\bf Estimate} & Mean & SD & Mean & SD & Mean & SD \\
tex \hline
foreach x in `Tlist' {
	tex \verb+`x'+ \\
	forvalues edcat=1/6 {
		local educlab : label edcat `edcat'
		tex \ \ `educlab'
		foreach j in 1 0 99 {
			su `x' if normexcl~=`j' & edcat==`edcat' [fw=hcap16wgt] 

			local foo  : di %2.0f `r(mean)'
			local goo  : di %2.0f `r(sd)'
			tex & `foo' & (`goo')
			cap macro drop _foo
			cap macro drop _goo
		}
		tex \\
	}
	local goo = substr("`x'",2,99)
	spearman schlyrs `x' if normexcl==0 
	local r0 : di %3.2f  `r(rho)'
	spearman schlyrs `goo' if normexcl==0 
	local r0o : di %3.2f  `r(rho)'
	tex & \multicolumn{2}{c}{\(r_s = `r0' (`r0o')\)}
	spearman schlyrs `x' if normexcl==1 
	local r1 : di %3.2f  `r(rho)'
	spearman schlyrs `goo' if normexcl==1 
	local r1o : di %3.2f  `r(rho)'
	tex & \multicolumn{2}{c}{\(r_s = `r1' (`r1o')\)}
	spearman schlyrs `x' 
	local r99 : di %3.2f  `r(rho)'
	spearman schlyrs  `goo' 
	local r99o : di %3.2f  `r(rho)'
	tex & \multicolumn{2}{c}{\(r_s = `r99' (`r99o')\)}
	cap macro drop _r0
	cap macro drop _r1
	cap macro drop _r99
	tex \\
	tex \\
}
tex \hline
tex \end{longtable}
tex \end{center}

tex Note: Means (SD) reflect weights


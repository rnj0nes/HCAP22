tex \newpage
tex \subsubsection{But are scores related to age?}
tex The normalized, adjusted, and standardized scores is -- by construction -- not be related to age
tex in the normative sample. This is a consequence of the adjustment procedure.
tex However, the normalized, adjusted and standardized scores may be related
tex to age in the sample excluded from norming, and the HCAP overall. This is because
tex the some correlation of age and test score is caused by the 
tex association of age and inclusion in the norming sample. The association between
tex age and test score is indirect, not direct, as a consequence of our design.

tex \begin{center}
tex \includegraphics[width=0.4\textwidth]{path.png}
tex \end{center}

tex Consider that the Spearman correlation of age (limiting to age 65-90) and inclusion in the 
tex norming sample is 

spearman hcapage normexcld if hcapage<91
local r1 : di %3.2f  `r(rho)'

tex `r1', and the Spearman correlation of being included in the norming sample
tex and the GCP (plausible value) score (before adjustment, \verb+gcpm1+) is 

spearman gcpm1 normexcld if hcapage<91
local r2 : di %3.2f  `r(rho)'

tex `r2', then we expect a correlation of the age (and other demographic factor-)
local foo : di %3.2f   `r1'*`r2'
tex adjusted GCP score and age to be no more than \(`r1' \times `r2' = \) `foo'.
tex We actually observe 

spearman Tgcpm1 hcapage if hcapage<91
local goo : di %3.2f  `r(rho)'

tex `goo'.\\[0.25cm]

tex The implication to all this is, if the correlation of the normalized, adjusted, and standardized
tex test scores with age in the overall HCAP sample is lower than what would be desired, the
tex way to increase this is to increase the magnitude of the correlation of age and being
tex included in the norming sample, or increase the magnitude of the correlation of being included
tex in the norming sample and cognitive test performance.\\[0.25cm] 

tex The table below contains means across age group and Spearman rank correlations
tex of the T score and age, but limiting to ages 65 to 90. In parenthesis, I 
tex show the Spearman correlation of the unadjusted score with age
tex (also limiting to ages 65-90).\\[0.25cm]


tex \begin{center}
tex \begin{longtable}{l rl rl rl }
tex                & \multicolumn{2}{c}{normexcl=0}&\multicolumn{2}{c}{normexcl=1} & \multicolumn{2}{c}{All HCAP}\\
tex {\bf Estimate} & Mean & SD & Mean & SD & Mean & SD \\
tex \hline
foreach x in `Tlist' {
	tex \verb+`x'+ \\
	forvalues age=1/7 {
		local agelab : label vl `age'
		tex \ \ `agelab'
		foreach j in 1 0 99 {
			su `x' [fw=hcap16wgt] if normexcl~=`j' & agegroup==`age'
			local foo  : di %2.0f `r(mean)'
			local goo  : di %2.0f `r(sd)'
			tex & `foo' & (`goo')
			cap macro drop _foo
			cap macro drop _goo
		}
		tex \\
	}
	local goo = substr("`x'",2,99)
	spearman hcapage `x' if normexcl==0 & hcapage<91
	local r0 : di %3.2f  `r(rho)'
	spearman hcapage `goo' if normexcl==0 & hcapage<91
	local r0o : di %3.2f  `r(rho)'
	tex & \multicolumn{2}{c}{\(r_s = `r0' (`r0o')\)}
	spearman hcapage `x' if normexcl==1 & hcapage<91
	local r1 : di %3.2f  `r(rho)'
	spearman hcapage `goo' if normexcl==1 & hcapage<91
	local r1o : di %3.2f  `r(rho)'
	tex & \multicolumn{2}{c}{\(r_s = `r1' (`r1o')\)}
	spearman hcapage `x' if hcapage<91
	local r99 : di %3.2f  `r(rho)'
	spearman hcapage `goo' if hcapage<91
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

tex Note: table means reflect weights




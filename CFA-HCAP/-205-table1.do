* a4-205-table1.do
* Rich Jones
* 22 Jan 2019
* -------------------
*

local noteis ""
cap confirm variable vdmie2o
if _rc==0 {
	di in red "got here"
	local noteis " - Updated following analytic variable recoding"
}

tex \newpage
tex \section{Information about analytic variables `noteis'}

*  \subsection{label}
*  +-----------------+------------+----------+--------------+
*  | varname         | Domain                               |
*  +-----------------+------------+----------+--------------+
*  | Distinct values | #          | Histogram               |
*  +-----------------+------------+                         +
*  | Missing N(%)    | #          |                         |
*  +-----------------+------------+                         +
*  | Corr(MMSE)      | #          |                         |
*  +-----------------+------------+----------+--------------+

* if 8 or more distinct values
*  +-----------------+------------+----------+--------------+
*  | Mean (SD)       | # (#)      | Range    | [#-#]        |
*  +-----------------+------------+----------+--------------+
*  | Skewness        | #          | Kurtosis |              |
*  +-----------------+------------+----------+--------------+

* if <8 distinct values
*  +----------+--------------+-----------------+------------+
*  |          |              |Level            | N (%)      |
*  +----------+--------------+-----------------+------------+
*  |          |              | 0               | #          |
*  +----------+--------------+-----------------+------------+
* ...
*  |          |              | 6               | #          |
*  +----------+--------------+-----------------+------------+

*  +----------+--------------+-----------------+------------+
*  | Range of correlation coefficients with other items     |
*  +----------+--------------+-----------------+------------+
*  | max      | #            | varname - varlabel           |
*  +----------+--------------+-----------------+------------+
*  | min      | #            | varname - varlabel           |
*  +----------+--------------+-----------------+------------+
*  | Median   | #            | IQR             | [#,#]      |
*  +----------+--------------+-----------------+------------+
*   var notes                       
*   newpage

cap program drop corrange
program define corrange , rclass
   preserve
	qui pwcorr head-tail
	mat R=r(C)
	drop _all
	matsave R ,  replace
	use R , clear
	keep `1' _rowname
	drop if missing(`1')
	drop if _rowname=="`1'"
	gsort -`1'
	local maxis : di %3.2gc `1'
	local maxisname = _rowname
	local maxisname = trim(itrim("`maxisname'"))
	gsort `1'
	local minis : di %3.2gc `1'
	local minisname = _rowname
	local minisname = trim(itrim("`minisname'"))
	qui su `1' , detail
	local medis : di %3.2gc `r(p50)'
	local lqis : di %3.2gc	`r(p25)'
   local uqis : di %3.2gc	`r(p75)'
	return local maxis "`maxis'"
	return local maxisname "`maxisname'"
	return local minis "`minis'"
	return local minisname "`minisname'"
	return local medis "`medis'"
	return local lqis "`lqis'"
	return local uqis "`uqis'"
	restore
end

cap program drop rangeis
program define rangeis
   qui su `1' , detail
	local foo  : di %8.2f `r(mean)'
	local goo  : di %8.2f `r(sd)'
	local hoo  : di %8.2f `r(min)'
	local ioo  : di %8.2f `r(max)'
	local joo  : di %8.2f `r(skewness)'
	local koo  : di %8.2f `r(kurtosis)'
	tex Mean (SD) & `foo' (`goo') & Range & [`hoo' - `ioo'] \\
	tex \hline
	tex skewness & `joo' & kurtosis & `koo' \\
end

cap program drop qmissing
program define qmissing , rclass
   qui distinct `1'
	local nmiss = `c(N)'-`r(N)'
	local pmiss  : di %2.0f 100*(`nmiss'/`c(N)')
	return local nmiss "`nmiss'"
	return local pmiss "`pmiss'"
end

cap program drop atmax
program define atmax , rclass
   qui su `1'
	local valid=`r(N)'
	qui su `1' if `1'==`r(max)'
	local nmax = `r(N)'
	local pmax  : di %2.0f 100*(`nmax'/`valid')
	return local nmax "`nmax'"
	return local pmax "`pmax'"
end
  
cap program drop atmin
program define atmin , rclass
   qui su `1'
	local valid=`r(N)'
	qui su `1' if `1'==`r(min)'
	local nmin = `r(N)'
	local pmin  : di %2.0f 100*(`nmin'/`valid')
	return local nmin "`nmin'"
	return local pmin "`pmin'"
end

cap program drop cormm
program define cormm , rclass
   qui corr h1rmsescore `1'
	return local cormm  : di %3.2gc `r(rho)'
end



foreach var of varlist head-tail {
	if "`var'"~="head" & "`var'"~="tail" {
		cap confirm file `var'.png
		if _rc~=0 {
			local discreteis ""
			distinct `var'
			if `r(ndistinct)'<40 {
				local discreteis "discrete"
			}
			gr tw hist `var', xscale(off) yscale(off) `discreteis' ysize(1) xsize(3)
			gr export `var'.png , replace width(250)
		}
		tex \subsection{``var'_lab'}
		tex {\bf `var'} (``var'_domain') \\
		tex \begin{tabular}{|p{3cm}|p{3cm}|p{6.42cm}|}
		distinct `var'
		tex \hline
		tex Distinct values & `r(ndistinct)' &
	   tex  \multirow{4}{*}{\includegraphics[width=6.42cm]{`var'.png}} \\
		qmissing `var'
		tex \cline{1-2}
		tex Missing N (\%) & `r(nmiss)' (`r(pmiss)'\%) & \\
		tex \cline{1-2}
		atmax `var'
		tex At max N (\%) & `r(nmax)' (`r(pmax)'\%) & \\
		tex \cline{1-2}
		atmin `var'
		tex At min N (\%) & `r(nmin)' (`r(pmin)'\%) & \\
		tex \cline{1-2}
		cormm `var'
		tex Corr(MMSE) & `r(cormm)' & \\
		tex \hline
		tex \end{tabular}\\
		distinct `var'
		if `r(ndistinct)'>8 {
			tex \begin{tabular}{|p{3cm}|p{3cm}|p{3cm}|p{3cm}|}
			rangeis `var'
			tex \hline
			tex \end{tabular}\\
		}
		tex \begin{tabular}{|p{3cm}|p{3cm}|p{6.42cm}|}
		corrange `var'
		tex \multicolumn{3}{|l|}{Range of correlation coefficients with other items}\\
		tex \hline
		tex max & `r(maxis)' & `r(maxisname)' (``r(maxisname)'_lab') \\
		tex \hline
		tex min & `r(minis)' & `r(minisname)' (``r(minisname)'_lab') \\
		tex \end{tabular}\\
		tex \begin{tabular}{|p{3cm}|p{3cm}|p{3cm}|p{3cm}|}
		tex \hline
		tex median & `r(medis)' & IQI & [`r(lqis)' - `r(uqis)'] \\
		tex \hline
		tex \end{tabular}\\[0.5cm]
		
		*tex \begin{scriptsize}
		tex {\bf Notes:}\\
		tex ``var'_note'\\[0.5cm]
		
		distinct `var'
		local Nis=`r(N)'
		
		if `r(ndistinct)'<11 {
			local test1=0
			local test2=0
			cap preserve
			table `var' , replace
			gen pis=table1/`Nis'
			su pis
			if `r(min)'<.05 {
				local test1=1 
			}
			su table1
			if `r(min)'<5 {
				local test2=1 
			}
			if `test1'==1|`test2'==1 {
				tex {\bf Cautionary statement on distribution.} This categorical variable (\verb+`var'+)
				tex has at least one sparsely populated response level. 
				if `test2'==1 {
					tex {\bf Critically,} there is a response category that has fewer that 5 participants
					tex (on a denominator of `Nis' participants). This is a critical low value that
					tex will need to be addresed before analysis. Ways to address include collapsing
					tex categories or not treating \verb+`var' as a categorical variable.\\[0.5cm]
				}
				if `test2'~=1 & `test1'==1 {
					tex There is a response category that has fewer than 5\% of the responding sample
					tex in the category. This maldistribution is \emph{likely} to cause problems when
					tex using least squares estimators and it might be worth considering addressing
					tex before analysis. Ways to address include collapsing
					tex categories or not treating \verb+`var'+ as a categorical variable.\\[0.5cm]
				}
				rename table1 Count
				rename pis Proportion
				texdoc stlog
				list , clean noobs
				texdoc stlog close
				cap restore
			}
			cap restore
		}
		
		*tex \end{scriptsize}
		tex \newpage		
	} // not head or tail
} // end loop over items
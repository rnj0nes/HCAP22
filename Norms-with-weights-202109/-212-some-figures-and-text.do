use w111.dta , clear
gen cschlyrs=schlyrs-12



local I = .85 // intensity
local a = 85 // transparency
local color_red "237 28 36*`I'%`a'"
local color_brown "78 54 41" // "*`I'%`a'"
local color_gold "255 199 144*`I'%`a'"
local color_skyblue "89 203 232*`I'%`a'"
local color_emerald "0 179 152*`I'%`a'"
local color_navy "0 60 113*`I'%`a'"
local color_taupe "183 176 156*`I'%`a'"



sort h1rmsetotal
*gr tw sc h1rmsetotal_blom h1rmsetotal , m(o) c(l) msize(medlarge) aspect(1) ytitle("Blom score")

preserve
reg Ph1rmsetotal_blom i.h1rmsetotal c.cschlyrs [fw=hcap16wgt]
margins , over(h1rmsetotal normexcld)
mat E=r(b)
mat E=E'
mat list E
clear
matsave E , replace
use E.dta , clear
strparse _rowname, gen(g) parse(.)
replace g1=subinstr(g1,"0bn","0",.)
destring g1 , replace
rename g1 h1rmsetotal
rename r1 Ph1rmsetotal_blom
gen normexcld=regexm(g2,"#1bn")
keep Ph1rmsetotal_blom h1rmsetotal normexcld
gr tw ///
   (sc Ph1rmsetotal_blom h1rmsetotal if normexcl==0 , c(l) lc("`color_red'") lw(thick) msize(medlarge) m(o) mc("`color_red'")) ///
   (sc Ph1rmsetotal_blom h1rmsetotal if normexcl==1 , c(l) lc("`color_emerald'") msize(med) m(o) mc("`color_emerald'")) ///
	(scatteri -4 20 "normexcl = 0", m(o) msize(medlarge) mc("`color_red'")) ///
	(scatteri -4.5 20 "normexcl = 1", m(o) msize(med) mc("`color_emerald'")) ///
	, legend(off) aspect(1) ylab(-6(1)1.5) xlab(0(10)30) xtick(5(5)25) ytitle("Rank-normalized score")
	
gr export fig_112a.png , replace width(1000)
restore

preserve
****** collapse (mean) Th1rmsetotal , by(h1rmsetotal)
gen cage=hcapage-70
mkspline cagesp=cage , cubic nknots(4)
mkspline mmsesp = h1rmsetotal , cubic nknots(4)
reg Th1rmsetotal mmsesp* c.cschlyrs c.black c.hisp c.female cagesp*
margins , over(h1rmsetotal)
mat E=r(b)
mat E=E'
mat list E
clear
matsave E , replace
use E.dta , clear
strparse _rowname, gen(g) parse(#)
replace g1=subinstr(g1,"0bn","0",.)
replace g1=subinstr(g1,".h1rmsetotal","",.)
rename g1 h1rmsetotal
destring h1rmsetotal , replace
rename r1 Th1rmsetotal
keep Th1rmsetotal h1rmsetotal 
gen meandata=1
tempfile f1
save `f1'
restore
append using `f1'


gr tw  ///
	(sc Th1rmsetotal h1rmsetotal if meandata~=1, m(o) msize(small) mc(gs12)) ///
	(sc Th1rmsetotal h1rmsetotal if meandata==1 , m(o) c(l) msize(medlarge) mc(gs8)) ///
	, aspect(1) xlab(0(10)30) xtick(0(5)25) ylab(-20 0 5 20 35 50 65 80 95) ytick(-20(5)100) ///
	  legend(off) ytitle("T score (based on residual)") ///
	  yline(35, lp(dash) lw(medthick) lc(red))
 
gr export fig_112b.png , replace width(1000) 



*new 9-18
preserve
reg Th1rmsetotal i.h1rmsetotal c.cschlyrs i.agegroup i.female i.black i.hisp [fw=hcap16wgt]
margins , over(h1rmsetotal agegroup female black hisp) 
mat E=r(b)
mat E=E'
mat list E
clear
matsave E , replace
use E.dta , clear
strparse _rowname, gen(g) parse(#)
replace g1=subinstr(g1,"0bn","0",.)
replace g1=subinstr(g1,".h1rmsetotal","",.)
rename g1 h1rmsetotal
destring h1rmsetotal , replace
gen agegroup=real(subinstr(subinstr(g2,"1bn","1",.),".agegroup","",.))
gen female=real(subinstr(subinstr(g3,"0bn","0",.),".female","",.))
gen black=real(subinstr(subinstr(g4,"1bn","1",.),".black","",.))
gen hisp=real(subinstr(subinstr(g5,"0bn","0",.),".hisp","",.))
rename r1 Th1rmsetotal
keep Th1rmsetotal h1rmsetotal agegroup female black hisp
gen groupdata=1
tempfile f99
save `f99'
restore
append using `f99'
*end new 9-18




local fig=0
forvalues agegroup = 1/7 {
   forvalues female = 0/1 {
	   forvalues black = 0/1 {
		   forvalues hisp = 0/1 {
			   cap drop foo
				gen foo = ///
					agegroup==`agegroup' & ///
					female==`female' & ///
					black == `black' & ///
					hisp == `hisp' 
				su foo if foo==1
				local Nis=`r(N)'
				if `Nis'>1 {
					local agelab : label vl `agegroup'
					local agelab "Age `agelab'"
					local femalelab "Men"
					if `female'==1 {
					   local femalelab "Women"
					}
					local relab = "White and others"
					if `black'==1 {
						local relab "Black, not Hispanic"
					}
					if `hisp'==1 {
						local relab "Hispanic"
					}
					su Th1rmsetotal [fw=hcap16wgt] if foo==1
					if `r(min)'<=35 {
						su h1rmsetotal if Th1rmsetotal<=35 & foo==1
						local xline=`r(max)'
					}
					else {
						cap reg Th1rmsetotal h1rmsetotal cschoolyrs [fw=hcap16wgt] if foo==1
						if _rc==0 {
							local xline  : di %3.1f  (35-_b[_cons])/_b[h1rmsetotal]
						}
						if inrange(`xline',0,30)~=1 {
							local xline = 30
						}
					}
					
					gr tw  ///
						(sc Th1rmsetotal h1rmsetotal if meandata~=1 & groupdata~=1, m(o) msize(small) mc(gs12)) ///
						(sc Th1rmsetotal h1rmsetotal if meandata==1 & groupdata~=1, m(o) c(l) msize(medlarge) mc(gs8)) ///
						(sc Th1rmsetotal h1rmsetotal if agegroup==`agegroup' & female==`female' & black==`black' & hisp==`hisp' & groupdata==1, ///
							m(o) msize(medlarge) mc("`color_brown'") c(l) lc("`color_brown'") clp(solid)) ///
						, aspect(1) xlab(0(10)30) xtick(5(5)25) ///
					 	  ylab(-20 0 5 20 35 50 65 80 95) ytick(-20(5)100) ///
						  legend(off) ytitle("T score (based on residual)") ///
						  yline(35, lp(solid) lw(medthick) lc("`color_red'")) ///
  						  xline(`xline', lp(solid) lw(medthick) lc("`color_red'")) ///
						  text(95 2 "`agelab'" , place(e)) ///
						  text(87 2 "`femalelab'" , place(e)) ///
						  text(79 2 "`relab'", place(e)) ///
						  text(71 2 "N=`Nis'", place(e)) ///
						  text(1 `xline' "`xline'" , place(w)) ///
						  scale(.75)
					gr save gr`++fig'.gph , replace
					cap macro drop _agelab
					cap macro drop _femalelab
					cap macro drop _relab
				}
			}
		}
	}
}

gr combine ///
   gr1.gph gr7.gph gr13.gph gr19.gph gr25.gph gr31.gph gr37.gph ///
	gr4.gph gr10.gph gr16.gph gr22.gph gr28.gph gr34.gph gr38.gph /// 
	gr3.gph gr9.gph gr15.gph gr21.gph gr27.gph gr33.gph  /// 
	gr6.gph gr12.gph gr18.gph gr24.gph gr30.gph gr36.gph  /// 
	gr2.gph gr8.gph gr14.gph gr20.gph gr26.gph gr32.gph  /// 
	gr5.gph gr11.gph gr17.gph gr23.gph gr29.gph gr35.gph  /// 
	, col(7) holes(21 28 35)

gr export explanatory_figure_10k.png , width(10000)  replace
gr export explanatory_figure_1k.png , width(1000)  replace

tex \newpage
tex \section{Procedure illustrated}
tex I will illustrate the normalization-adjustment-standardization steps with pictures. For the sake of 
tex illustration, I will use the MMSE score as the test score. \\[.25cm]
tex {\bf Rank-normalized scores vs "raw" scores}\\
tex This first picture illustrates the modeled relationship between raw scores (x-axis) and rank-normalized scores (y-axis).
tex The red dots illustrate the modeled relationship applied in the normative sample. The green dots illustrate the
tex modeled relationship applied in the non-norm sample. Note that the relationship between the two scores is defined
tex in the norm sample, using linear regression with restricted cubic splines based on the "raw" score. The first spline
tex (and last) spline in a restricted cubic spline is a linear function, so the out-of-range values with respect to the
tex norming sample (MMSE scores between 0 and 10) are related to the Blom-transformed metric using linear regression.

tex \begin{center}
tex \includegraphics[width=\textwidth]{fig_112a.png}
tex \end{center}

tex \newpage
tex {\bf Adjusted and standardized rank-normalized scores vs "raw" scores}\\
tex The next picture illustrates the scatter of expected T-scores for the MMSE after adjusting for demongraphics
tex (and their two-way interactions) based on model results obtained from the normative sample. The overall
tex mean relationship is shown with connected dots. Each dot on the plot represets a particular expected value for
tex a given combination of MMSE total score and demographic profile.

tex \begin{center}
tex \includegraphics[width=\textwidth]{fig_112b.png}
tex \end{center}

tex \newpage
tex {\bf Adjusted and standardized rank-normalized scores vs "raw" scores by demongraphic group}\\
tex Here is a plot that shows the raw and adjusted scores within major demongraphic groups. Also illustrated
tex and labeled is the cut-point on the "raw" score variable that corresponds to the threshold defined
tex on the adjusted, standardized and normalized test score. NB the effect of education is fixed at 12 years of schooling. This version is too small to get
tex any details, but you can view a high-resolution copy at this link: \url{https://s3.amazonaws.com/hrshcap/explanatory_figure_10k.png}.

tex \begin{center}
tex \includegraphics[width=\textwidth]{explanatory_figure_1k.png}
tex \end{center}





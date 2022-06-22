use w991-003-postimputation.dta , clear

gen numimpaired = 0
foreach x in Imemm1 Iexfm1 Ilflm1 Ivdvis1 Ivdori1 {
   replace numimpaired = numimpaired+1 if `x'==1 
}
gen missingcount=missing(Imemm1) + missing(Iexfm1) + missing(Ilflm1) + missing(Ivdvis1) + missing(Ivdori1)
gen numimpaired_imputed = round(numimpaired*(5/(5-missingcount)),0)
replace numimpaired_imputed = . if missingcount==5
gen impairedon2up = numimpaired_imputed>=2 if missing(numimpaired_imputed)~=1



tex \section{Which tests are folks impaired on}
tex If you're counted as being impaired on 2 or more tests, which tests are the most frequently impaired?

texdoc stlog
su Iexfm1 Imemm1  Ivdori1 Ivdvis1 Ilflm1   if impairedon2up==1

** USING WEIGHTS
sort racecat3
by racecat3 : su Iexfm1 Imemm1  Ivdori1 Ivdvis1 Ilflm1   if impairedon2up==1 [fw=hcap16wgt]

gen Ih1ijormsc19 = h1ijormsc>=3.4 if missing(h1ijormsc)~=1
la var Ih1ijormsc19 "h1ijormsc>=3.4"
gen Ih1ibl1tot19 = h1ibl1tot>=2 if missing(h1ibl1tot)~=1
la var Ih1ibl1tot19 "h1ibl1tot>=2"
gen Iinformant19 = Ih1ijormsc19==1 & Ih1ibl1tot19==1
replace Iinformant19 = 1 if h1ijormsc>=3.4 & missing(h1ibl1tot)
replace Iinformant19 = 1 if h1ibl1tot>=2 & missing(h1ijormsc)
gen Hdemented19 = impairedon2up==1 & Iinformant19==1 if missing(impairedon2up)~=1 & missing(Iinformant19)~=1
su Hdemented19 [fw=hcap16wgt]
table racecat3 , c(mean Hdemented19) , [fw=hcap16wgt]

/*


			local foo  : di %3.2f  `r(mean)'
			su Hdemented`i'
			logit dementiaDx Hdemented`i'
			lroc , nograph
			local cstat  : di %3.2f  `r(area)'
			su dementiaDx if Hdemented`i'==1
			local PPV : di %3.2f `r(mean)'
			su Hdemented`i' if dementiaDx==1
			local SENS : di %3.2f `r(mean)'
			su Hdemented`i' if dementiaDx==1
			local SPEC : di %3.2f 1-`r(mean)'
			tex `i'. Jorm (`jormcut') `combo`combo'is' Blessed (`blessedcut') & `foo' & `SENS' & `PPV' & `SPEC' & `cstat' \\
			macro drop _pHdemented
			macro drop _cstat
			macro drop _PPV
			macro drop _SENS
			macro drop _SPEC
		}
	}
}
local I=`i'
tex \hline
tex \end{longtable}
tex \end{center}
tex \end{footnotesize}


tex \newpage
tex Some information\\[0.5cm]

tex {\bf Distribution of Jorm, Blessed}

gen rh1ijormsc=round(h1ijormsc,.1)
gen rh1ibl1tot=round(h1ibl1tot,.1)
texdoc stlog
table rh1ijormsc
texdoc stlog close
tex \newpage
texdoc stlog 
table rh1ibl1tot
texdoc stlog close

tex \newpage
tex {\bf Two of the HCAP dementia flags (they are different)}
texdoc stlog
table Hdemented1 Hdemented8
texdoc stlog close

tex \newpage
tex \section{Concordance of Jorm and Blessed}

gr tw  scatter h1ijormsc  h1ibl1tot , jitter(1) aspect(1) ms(os) mfc(red*.5%50) mlc(red*.5%50) msize(tiny) yline(3.2) xline(1.1)
gr export fig1.png , width(2000) replace
graph close
tex \begin{center}
tex \includegraphics[width=\textwidth]{fig1.png}
tex \end{center}

tex \newpage
texdoc stlog
forvalues i=1/`I' {
	qui {
		local foo : var lab Ih1ijormsc`i'
		local goo : var lab Ih1ibl1tot`i' 
		noisily di _n _n _n _n "`foo' * `goo'"
		noisily tab Ih1ijormsc`i' Ih1ibl1tot`i' , missing
	}
}
texdoc stlog close

tex \newpage
tex \section{Prevalence of dementia by age, race, education for the different cuts on the informant scales.}

forvalues i=1/`I' {
	foreach j in without with {
		if "`j'"=="without" {
			local fwis ""
			local fwisnote " without weights"
		}
		if "`j'"=="with" {
			local fwis "[fw=hcap16wgtr]"
			local mfwis "[pw=hcap16wgtr]"
			local fwisnote "  WITH weights"
		}
		su Hdemented`i' `fwis'
		local foo  : di %2.0f 100*`r(mean)'
		tex \subsection{`condition`i'' (`foo'\% overall) `fwisnote'}
		qui {
			local foo : var lab Ih1ijormsc`i'
			local goo : var lab Ih1ibl1tot`i' 
			texdoc stlog
			foreach x in agegroup racecat3 edcat {
				noisily table `x' `fwis' , c(n Hdemented`i' mean Hdemented`i') f(%4.3f)
				if "`x'"=="racecat3" {
					logit Hdemented`i' i.racecat3 i.agegroup i.edcat i.female `mfwis'
					noisily di "Black vs white (adjusting for age, sex, and education group): OR = " %5.3f exp(_b[1.racecat3]) " 95% CI: " %5.3f exp(_b[1.racecat3]-1.96*_se[1.racecat3]) " - " %5.3f exp(_b[1.racecat3]+1.96*_se[1.racecat3])
					margins racecat3 agegroup edcat female
					mat E=r(table)
					mat F=E[1..1,1..3]
					mat list F
					matrix colnames F = white Black Hispanic
					matrix rownames F = marginal
					noisily di "Marginal proportion with dementia by racial group (at overall mean age group, education group, sex)"
					noisily mat list F , format(%5.3f)
				}
			}
			texdoc stlog close
		}
	}
}



save w1001.dta , replace

tex \newpage
tex \section{final final}


cap drop impairedcat
gen impairedcat = 0
foreach x in memm1 exfm1  vdvis1  lflm1 vdori1 {
	replace impairedcat=impairedcat+1 if I`x'==1
}
replace impairedcat=2 if impairedcat>=2 & missing(impairedcat)~=1
vlabel impairedcat 0 1 2+

* Informant concern condition
cap drop Ih1ijormsc99
cap drop Ih1ibl1tot99
cap drop Iinformant99
gen Ih1ijormsc99 = h1ijormsc > 3 if missing(h1ijormsc)~=1
la var Ih1ijormsc99 "h1ijormsc > 3"
gen Ih1ibl1tot99 = h1ibl1tot > 0 if missing(h1ibl1tot)~=1
la var Ih1ibl1tot99 "h1ibl1tot > 0 "
gen Iinformant99 = Ih1ijormsc99 == 1 | Ih1ibl1tot99 == 1
replace Iinformant99 = 1 if Ih1ijormsc99 == 1 & missing(Ih1ibl1tot99)
replace Iinformant99 = 1 if Ih1ibl1tot99 == 1 & missing(Ih1ijormsc99)



cap drop three_category
gen three_category=.
replace three_category = 0 if Hdemented19~=1
replace three_category = 1 if impairedon2up==1 & Hdemented19~=1
replace three_category = 1 if (Imemm1 == 1 | Iexfm1 == 1 | Ivdvis == 1 | Ilflm1 == 1 | Ivdori1 == 1)
replace three_category = 2 if Hdemented19==1
tab three_category Iinformant1

tab impairedon2up
tab impairedcat if impairedon2up==0
tab Iinformant99 if impairedon2up==0 & impairedcat>0
tab Iinformant19 if  impairedon2up==1

cap drop dxcat
gen dxcat = .
replace dxcat = 1.1 if (impairedon2up == 0 & impairedcat == 0 )
replace dxcat = 1.2 if (impairedon2up == 0 & impairedcat == 1 & Iinformant99 == 0 )
replace dxcat = 2.1 if (impairedon2up == 0 & impairedcat == 1 & Iinformant99 == 1 )
replace dxcat = 2.2 if (impairedon2up == 1 & Iinformant19 == 0 )
replace dxcat = 3.1 if (impairedon2up == 1 & Iinformant19 == 1 )

tab dxcat , m

cap drop rdxcat
gen rdxcat=round(dxcat)
checkvar rdxcat dxcat
tab rdxcat , m

vlabel rdxcat Normal MCI Demented
tab rdxcat normexcld



tab rh1ijormsc normexcld 

gr tw ///
	(kdensity rh1ijormsc if normexcld==0 ,  recast(area) fc(blue*.5%20) lc(blue*.01%01)) ///
	(kdensity rh1ijormsc if normexcld==1, recast(area) fc(red*.5%20) lc(red*.01%01)) ///
	, legend(label(1 "Not excluded from normative sample") label(2 "Excluded from normative sample") ring(0) pos(2)) ///
	ytitle(Density) xtitle(Jorm) ///
	xline(3 3.4 , lc(gs12)) xlab(1(1)5 3.4) 
gr save h1ijormsc.gph , replace
gr export h1ijormsc.png , width(1000) replace

tab  rh1ibl1tot normexcld

gr tw ///
	(kdensity rh1ibl1tot if normexcld==0 ,  recast(area) fc(blue*.5%20) lc(blue*.01%01)) ///
	(kdensity rh1ibl1tot if normexcld==1, recast(area) fc(red*.5%20) lc(red*.01%01)) ///
	, legend(label(1 "Not excluded from normative sample") label(2 "Excluded from normative sample") ring(0) pos(2)) ///
	ytitle(Density) xtitle(Blessed part I) ///
	xline(0 1 , lc(gs12)) xlab(0(1)8) 
gr save h1ibl1to.gph , replace
gr export h1ibl1to.png , width(1000) replace


save w991-004-end-document.dta , replace 
tex \end{document}
qui texdoc close
qui texify `texis'.tex
qui texify `texis'.tex
saveold w991b.dta , version(12) replace
*keep hhid pn rnjid lwdx lw2dx h1ijormsc h1ibl1tot Imemm1 Iexfm1 Ilflm1 Ivdvis1 Ivdori1 Icount
*saveold forclust.dta , version(12) replace

/*
margins racecat3 , ///
  at(1.agegroup      =    .3137143 ///
     2.agegroup      =    .2517893 ///
     3.agegroup      =    .1738485 ///
     4.agegroup      =    .1241188 ///
     5.agegroup      =    .0761727 ///
     6.agegroup      =    .0444134 ///
     7.agegroup      =    .0159429 ///
     1.edcat         =    .0760559 ///
     2.edcat         =    .0908834 ///
     3.edcat         =    .3166133 ///
     4.edcat         =    .2305152 ///
     5.edcat         =    .1286521 ///
     6.edcat         =    .1572801 ///
     0.female        =     .440562 ///
     1.female        =     .559438 ///
  )
  
  
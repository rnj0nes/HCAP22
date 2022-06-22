tex \newpage
tex \section{Appendix 2 - Density comparisons by norming sample inclusion}


use w111.dta , clear



local count=0
foreach x in gcp mem exf lfl ori vis {
	foreach y in ``x'scores' {
		cap confirm var T`y'
		if _rc==0 {
			cap drop x
			cap drop y
			cap drop cx
			cap drop ny
			cap drop xid
			cap drop obs
			cap drop OBS
			kdensity T`y' if normexcld==1 , gen(x y) nograph
			su T`y' if normexcld==1
			local diamond  : di %2.0f `r(mean)'
			gen cx=x-`r(mean)'
			gen xid=cx<0
			replace xid=2 if cx>=0
			replace xid=99 if missing(x)
			sort xid cx
			by xid: gen obs=_n
			by xid: gen OBS=_N
			gen ny=y if xid==1&(obs==OBS)
			replace ny=y if xid==2 & obs==1
			list ny cx if missing(ny)~=1
			reg ny cx	
			local yloc = _b[_cons]
			local xtitle : var label T`y'
			gr tw ///
				(scatteri 0 `diamond' (1) "`diamond'" , ms(d) mlabsize(vsmall)) ///
				(scatteri `yloc' `diamond' 0 `diamond' , recast(line) lp(solid) lc(gs6%50)) ///
				(kdensity T`y' if normexcld==0 ,  recast(area) fc(blue*.5%20) lc(blue*.01%01)) ///
				(kdensity T`y' if normexcld==1, recast(area) fc(red*.5%20) lc(red*.01%01)) ///
				, xlab(-20 0 25 35 50 75 100) ///
				legend(off) ///
				xline(35 , lc(gs6%50)) ///
				xtick(-25(5)105) ///
				ysize(2.5) xsize(7) ///
				scale(1.3) ///
				ytitle("") ///
				yscale(off) ///
				xtitle("T`y': `xtitle'")
			gr save gdT`y'.gph , replace
			gr export gT`y'.png , width(1000) replace
			tex \includegraphics[width=\textwidth]{gT`y'.png}\\[0.5cm]
			local count=`++count'
			if inlist(`count',3,6,9,12,15,18,21)==1 {
				tex Note: the diamonds mark the mean of the sample excluded from the norming sample.
				tex \newpage
			}
		}
	}
}




/*
cap program drop tablit
program define tablit 
   syntax [if] , head(string)
   tex {\bf `head'}
   texdoc stlog
	table edcat agegroup `if' & missing(gcp)~=1
	texdoc stlog close
end

tablit if black==0 & hisp==0 & female==0 , head(White and others, men)
tablit if black==0 & hisp==0 & female==1 , head(White and others, women)
tablit if black==1 & hisp==0 & female==0 , head(Black or African American, men)
tablit if black==1 & hisp==0 & female==1 , head(Black or African American, women)
tex \newpage
tablit if black==0 & hisp==1 & female==0 , head(Hispanic, men)
tablit if black==0 & hisp==1 & female==1 , head(Hispanic, women)


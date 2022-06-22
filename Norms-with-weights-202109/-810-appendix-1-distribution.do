tex \newpage
tex \section{Appendix 1 - Number of observations by sex, age, race/ethnicity and education}


use w111.dta , clear
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


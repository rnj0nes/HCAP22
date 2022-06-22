tex \newpage
tex \section{APPENDIX 4: Parameter estimates and technical results from  regression models}


* loop over each score
foreach x in mem exf lfl ori vis gcp {
	foreach y in ``x'scores' {
		if "`y'"~="vdori1" {
			tex \newpage
			tex \subsection{`y'}
		   estimates restore `y'	
			texdoc stlog
			reg
			texdoc stlog close
		}
	}
}





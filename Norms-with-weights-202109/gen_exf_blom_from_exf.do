gen spexf1=exf
gen spexf2 = (max((exf--.14765)^3,0)-(.243-.123)^-1 * (max((exf-.123)^3,0)*(.243--.14765)-max((exf-.243)^3,0)*(.123--.14765))) / (.243--.14765)^2 if missing(exf)~=1
gen spexf3 = (max((exf-.0264499999999999)^3,0)-(.243-.123)^-1 * (max((exf-.123)^3,0)*(.243-.0264499999999999)-max((exf-.243)^3,0)*(.123-.0264499999999999))) / (.243--.14765)^2 if missing(exf)~=1
gen Pexf_blom = -.5880222425509376+spexf1*6.947437763514975+spexf2*.3778514056152907+spexf3*9.441932091533975
* have a nice day
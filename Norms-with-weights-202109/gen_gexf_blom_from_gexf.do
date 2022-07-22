gen spgexf1=gexf
gen spgexf2 = (max((gexf--.1376)^3,0)-(.246-.128)^-1 * (max((gexf-.128)^3,0)*(.246--.1376)-max((gexf-.246)^3,0)*(.128--.1376))) / (.246--.1376)^2 if missing(gexf)~=1
gen spgexf3 = (max((gexf-.032)^3,0)-(.246-.128)^-1 * (max((gexf-.128)^3,0)*(.246-.032)-max((gexf-.246)^3,0)*(.128-.032))) / (.246--.1376)^2 if missing(gexf)~=1
gen Pgexf_blom = -.6161308375238885+spgexf1*7.218276106737841+spgexf2*-.1269445910496758+spgexf3*12.07217727418754
* have a nice day

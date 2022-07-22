gen spgmemm11=gmemm1
gen spgmemm12 = (max((gmemm1--.2064)^3,0)-(.3406-.1552)^-1 * (max((gmemm1-.1552)^3,0)*(.3406--.2064)-max((gmemm1-.3406)^3,0)*(.1552--.2064))) / (.3406--.2064)^2 if missing(gmemm1)~=1
gen spgmemm13 = (max((gmemm1-.028)^3,0)-(.3406-.1552)^-1 * (max((gmemm1-.1552)^3,0)*(.3406-.028)-max((gmemm1-.3406)^3,0)*(.1552-.028))) / (.3406--.2064)^2 if missing(gmemm1)~=1
gen Pgmemm1_blom = -.5357797269332417+spgmemm11*5.46771682715092+spgmemm12*.1148664563867539+spgmemm13*4.444451147185619
* have a nice day

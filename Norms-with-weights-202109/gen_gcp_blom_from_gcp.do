gen spgcp1=gcp
gen spgcp2 = (max((gcp--.142)^3,0)-(.266-.1392)^-1 * (max((gcp-.1392)^3,0)*(.266--.142)-max((gcp-.266)^3,0)*(.1392--.142))) / (.266--.142)^2 if missing(gcp)~=1
gen spgcp3 = (max((gcp-.039)^3,0)-(.266-.1392)^-1 * (max((gcp-.1392)^3,0)*(.266-.039)-max((gcp-.266)^3,0)*(.1392-.039))) / (.266--.142)^2 if missing(gcp)~=1
gen Pgcp_blom = -.6320605237735673+spgcp1*6.933971587714574+spgcp2*-.279049576680591+spgcp3*12.19158086228509
* have a nice day

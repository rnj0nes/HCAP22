gen spgmem1=gmem
gen spgmem2 = (max((gmem--.1802)^3,0)-(.296-.154)^-1 * (max((gmem-.154)^3,0)*(.296--.1802)-max((gmem-.296)^3,0)*(.154--.1802))) / (.296--.1802)^2 if missing(gmem)~=1
gen spgmem3 = (max((gmem-.04)^3,0)-(.296-.154)^-1 * (max((gmem-.154)^3,0)*(.296-.04)-max((gmem-.296)^3,0)*(.154-.04))) / (.296--.1802)^2 if missing(gmem)~=1
gen Pgmem_blom = -.6153572018917837+spgmem1*5.659816903393915+spgmem2*.3459887117196282+spgmem3*8.640993300916417
* have a nice day

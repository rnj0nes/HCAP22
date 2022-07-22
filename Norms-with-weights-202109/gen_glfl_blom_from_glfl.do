gen spglfl1=glfl
gen spglfl2 = (max((glfl--.0826)^3,0)-(.152-.079)^-1 * (max((glfl-.079)^3,0)*(.152--.0826)-max((glfl-.152)^3,0)*(.079--.0826))) / (.152--.0826)^2 if missing(glfl)~=1
gen spglfl3 = (max((glfl-.022)^3,0)-(.152-.079)^-1 * (max((glfl-.079)^3,0)*(.152-.022)-max((glfl-.152)^3,0)*(.079-.022))) / (.152--.0826)^2 if missing(glfl)~=1
gen Pglfl_blom = -.6139466743373486+spglfl1*12.32552158393111+spglfl2*-.6660059274087266+spglfl3*20.00423900929775
* have a nice day

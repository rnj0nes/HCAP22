gen spmem1=mem
gen spmem2 = (max((mem--.1952)^3,0)-(.2985999999999999-.147)^-1 * (max((mem-.147)^3,0)*(.2985999999999999--.1952)-max((mem-.2985999999999999)^3,0)*(.147--.1952))) / (.2985999999999999--.1952)^2 if missing(mem)~=1
gen spmem3 = (max((mem-.0248)^3,0)-(.2985999999999999-.147)^-1 * (max((mem-.147)^3,0)*(.2985999999999999-.0248)-max((mem-.2985999999999999)^3,0)*(.147-.0248))) / (.2985999999999999--.1952)^2 if missing(mem)~=1
gen Pmem_blom = -.5290682637353471+spmem1*5.410404369769446+spmem2*.3295349698764447+spmem3*6.989401501858783
* have a nice day

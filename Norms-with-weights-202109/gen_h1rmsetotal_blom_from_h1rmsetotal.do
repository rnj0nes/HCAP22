gen sph1rmsetotal1=h1rmsetotal
gen sph1rmsetotal2 = (max((h1rmsetotal-24)^3,0)-(30-29)^-1 * (max((h1rmsetotal-29)^3,0)*(30-24)-max((h1rmsetotal-30)^3,0)*(29-24))) / (30-24)^2 if missing(h1rmsetotal)~=1
gen sph1rmsetotal3 = (max((h1rmsetotal-28)^3,0)-(30-29)^-1 * (max((h1rmsetotal-29)^3,0)*(30-28)-max((h1rmsetotal-30)^3,0)*(29-28))) / (30-24)^2 if missing(h1rmsetotal)~=1
gen Ph1rmsetotal_blom = -6.816659826945452+sph1rmsetotal1*.2201021250284133+sph1rmsetotal2*.2219973277532968+sph1rmsetotal3*.9010955361429108
* have a nice day

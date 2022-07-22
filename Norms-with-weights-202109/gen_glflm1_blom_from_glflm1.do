gen spglflm11=glflm1
gen spglflm12 = (max((glflm1--.1006)^3,0)-(.177-.081)^-1 * (max((glflm1-.081)^3,0)*(.177--.1006)-max((glflm1-.177)^3,0)*(.081--.1006))) / (.177--.1006)^2 if missing(glflm1)~=1
gen spglflm13 = (max((glflm1-.012)^3,0)-(.177-.081)^-1 * (max((glflm1-.081)^3,0)*(.177-.012)-max((glflm1-.177)^3,0)*(.081-.012))) / (.177--.1006)^2 if missing(glflm1)~=1
gen Pglflm1_blom = -.51311923322955+spglflm11*11.25491697628214+spglflm12*-.8370731595143689+spglflm13*9.547267967380993
* have a nice day

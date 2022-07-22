gen spage1=hcapage
gen spage2 = (max((hcapage-70)^3,0)-(94-86)^-1 * (max((hcapage-86)^3,0)*(94-70)-max((hcapage-94)^3,0)*(86-70))) / (94-70)^2 if missing(hcapage)~=1
gen spage3 = (max((hcapage-78)^3,0)-(94-86)^-1 * (max((hcapage-86)^3,0)*(94-78)-max((hcapage-94)^3,0)*(86-78))) / (94-70)^2 if missing(hcapage)~=1
* have a nice day

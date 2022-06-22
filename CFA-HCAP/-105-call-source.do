* a4-105-call-source.do
* Rich Jones
* 22 Jan 2019
* -------------------
* call data from source files
* (and process minimally in this file)


tex \section{Data handling}
tex \subsection{File using}
*tex using \verb+finalhcap.sas7bdat+
tex using `hc16hp_r_20220603.dta` from Ryan McCammon. This file had different missing value handling.

use $source/hc16hp_r_20220603.dta

lowercase
save w105.dta , replace


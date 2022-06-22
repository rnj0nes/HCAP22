* a4-001-preambling.do
* Rich Jones
* 22 Jan 2019
* -------------------
date // or today : RNJ ado's that provide locals for date
local today = "`r(date2)'" // e.g., "11 JAN 2011"
local datestr = "`r(datestr)'" // e.g., "20110111"
* Settings --------------------------------------------------
set seed 3481 // even if not sure needed, set it anyway
set more off // unless you really want it
local t=0
local f=0

* have a nice day

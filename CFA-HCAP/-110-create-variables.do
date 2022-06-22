* a4-110-create-variables.do
* Rich Jones
* 22 Jan 2019
*

* =========================================================
* Labels for items
la var h1rmse1 "oridate1" 
la var h1rmse2 "oridate2" 
la var h1rmse3 "oridate3" 
la var h1rmse4 "oridate4" 
la var h1rmse5 "oridate5" 
la var h1rmse6 "oriplace1" 
la var h1rmse7 "oriplace2" 
la var h1rmse8 "oriplace3" 
la var h1rmse9 "oriplace4" 
la var h1rmse10 "oriplace5" 
la var h1rmse11t "registration_trials" 
la var h1rmse11t1 "registration_trial1" 
la var h1rmse12a "d" 
la var h1rmse12b "l" 
la var h1rmse12c "r" 
la var h1rmse12d "o" 
la var h1rmse12e "w" 
la var h1rmse13 "recall" 
la var h1rmse14 "naming1" 
la var h1rmse15 "naming2" 
la var h1rmse16 "repeat_phrase" 
la var h1rmse17 "follow_command" 
la var h1rmse18 "threestep1" 
la var h1rmse19 "threestep2" 
la var h1rmse20 "threestep3" 
la var h1rmse21 "write_sentence" 
la var h1rmse22 "draw_polygons" 

cap drop head
gen head=. // to keep track of start and end of cog items
* =========================================================
* Orientation
* ---------------------------------------------------------
* MMSE 10 items
local var "vdori1"
local `var'_lab "MMSE 10 items (number of correct, 0-10)"
local `var'_source "h1rmse1 h1rmse2 h1rmse3 h1rmse4 h1rmse5 h1rmse6 h1rmse7 h1rmse8 h1rmse9 h1rmse10"
local `var'_domain "Orientation"
cap drop `var'
scoreit ``var'_source' , ///
   indicator(1) /// counting correct responses
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  : di %5.3f `r(alpha)' 
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ captures orientation to time and place using 10 items from the MMSE. It is coded as the sum of the number of \verb+h1rmse1-h1rmse10+ that have a value of 1, with 97, 98, and 99 responses treated as missing values. Persons who do not have at least 1 item in the list that has a response of 1 or 5 are treated as missing. This sum has a Cronbach's alpha of ``var'_alpha'." ;
#d cr 
* ---------------------------------------------------------
* HRS TICS Name President
local var "vdori2"
local `var'_lab "TICS name president correct (0,1)"
local `var'_source "h1rticspres"
local `var'_domain "Orientation"
cap drop `var'
scoreit  ``var'_source' , ///
   indicator(1) /// counting correct responses
   missinglist(7 8 9) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ identifies whether the respondent can correctly identify the President. It is a simple recode of the TICS name the President item. Responses of 7, 8 , 9 are treated as missing." ;
#d cr 
* =========================================================
* Memory: immediate episodic
* ---------------------------------------------------------
* CERAD WORD LIST IMMEDIATE: TRIAL 1-3 TOTAL CORRECT
local var "vdmie1" 
local `var'_lab "CERAD word list immediate sum of 3 trials (0-30)"
local `var'_source "h1rwlimm1score h1rwlimm2score h1rwlimm3score"
local `var'_domain "Memory, immediate episodic"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  : di %5.3f `r(alpha)' 
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the sum of three learning trials on the CERAD 10 item word list. Coded values of 97, 98, and 99 are treated as missing values. Persons who do not have at least 1 item in the list that has a response between 0 and 10 are treated as missing. This sum has a Cronbach's alpha of ``var'_alpha'." ;
#d cr
* ---------------------------------------------------------
* MMSE 3 word recognition
local var "vdmie2" 
local `var'_lab "MMSE 3 word recognition (0-3)"
local `var'_source "h1rmse11t1"
local `var'_domain "Memory, immediate episodic"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ represents the number of words immediately recalled on a 3 word list. It is the first registration trial of the MMSE. It is simply a recoded version of the original variable ``var'_source', with responses of 97, 98 , 99 treated as missing." ;
#d cr
* ---------------------------------------------------------
* LOGICAL MEMORY Immediate
local var "vdmie3" 
local `var'_lab "Logical memory immediate (0-25)"
local `var'_source "h1rlmimmscore"
local `var'_domain "Memory, immediate episodic"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the number correct on the WMS-IV Logical Memory I immediate story recall task. It is simply a renaming of `var_source'." ;
#d cr
* ---------------------------------------------------------
* Brave Man Immediate
local var "vdmie4"
local `var'_lab "Brave man immediate (0-12)"
local `var'_source "h1rbmimmscore"
local `var'_domain "Memory, immediate episodic"
cap drop `var'
gen `var' = ``var'_source'
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This item \verb+`var'+ is simply a renaming of ``var'_source'. No accomodation for missing or other non-response codes has been used." ;
#d cr
* =========================================================
* Memory: delayed episodic
* ---------------------------------------------------------
* CERAD WORD LIST DELAYED
local var "vdmde1" 
local `var'_lab "CERAD word list delayed (0-10)"
local `var'_source "h1rwldelscore"
local `var'_domain "Memory, delayed episodic"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the number correct on the CERAD delayed 10 word recall task. It is simply a renaming of ``var'_source'." ;
#d cr
* ---------------------------------------------------------
* LOGICAL MEMORY DELAYED
local var "vdmde2" 
local `var'_lab "Logical memory delayed (0-25)"
local `var'_source "h1rlmdelscore"
local `var'_domain "Memory, delayed episodic"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  "NA"
replace `var'=. if h1rlmdeltest==9
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the number correct on the WMS-IV Logical Memory I delayed story recall task. There are 25 story points to be recalled, and the source variable is the sum of these that are recalled. \verb+`var'+ is basically a renaming of ``var'_source'. {\bf Special handling:} if the HRS variable \verb+h1rlmdeltest+ has a value of 9 (imputed) the created variable \verb+`var'+ is set to missing." ;
#d cr
table h1rlmdeltest , c(n h1rlmdelscore med h1rlmdelscore sd h1rlmdelscore)
* ---------------------------------------------------------
* MMSE 3 word delayed recall
local var "vdmde3" 
local `var'_lab "MMSE 3 word delayed recall (0-3)"
local `var'_source "h1rmse13"
local `var'_domain "Memory, delayed episodic"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ represents the number of words recalled after a delay on the MMSE 3 word list. It is simply a recoded version of the original variable ``var'_source', with responses of 97, 98 , 99 treated as missing." ;
#d cr
* ---------------------------------------------------------
* PRAXIS RECALL
local var "vdmde4" 
local `var'_lab "CERAD constructional praxis delayed (0-11)"
local `var'_source "h1rcpdelscore"
local `var'_domain "Memory, delayed episodic"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the number correct shapes drawn from memory after a delay on the CERAD Constructional Praxis task. This is a delayed recall of the geometric shapes drawn in the test of CERAD Constructional Praxis (immediate) task. Respondents are asked to draw the shapes from earlier in the interview to the best of their memory. It is simply a renaming of ``var'_source'." ;
#d cr
* ---------------------------------------------------------
* Brave Man Delayed H1RBMDELSCORE
local var "vdmde5"
local `var'_lab "Brave man delayed score (0-12)"
local `var'_source "h1rbmdelscore"
local `var'_domain "Memory, delayed episodic"
cap drop `var'
gen `var' = ``var'_source'
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This item \verb+`var'+ is simply a renaming of ``var'_source'. No accomodation for missing or other non-response codes has been used." ;
#d cr
* =========================================================
* Memory: recognition
* ---------------------------------------------------------
* CERAD WORD LIST Recognition Task
local var "vdmre1" 
local `var'_lab "CERAD word list recognition task (0-20)"
local `var'_source "h1rwlrecyscore h1rwlrecnscore"
local `var'_domain "Memory, recognition"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha :  di %3.2f `r(alpha)'
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the number correct \emph{yes} and number correct \emph{no} on the CERAD delayed recognition task. This two item sum has an internal consistency reliability (alpha) coefficient of ``var'_alpha'." ;
#d cr
* =========================================================
* Memory: recognition ---------------------------------------------------------
* Logical memory recognition
local var "vdmre2" 
local `var'_lab "Logical memory recognition (0-15)"
local `var'_source "h1rlmrecscore"
local `var'_domain "Memory, recognition"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
   local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the number correct on the WMS-IV Logical Memory I story recognition task. It is simply a renaming of \verb+``var'_source'+ but missing codes (97, 98, 99) are treated as missing." ;
#d cr
* =========================================================
* Visuospatial --------------------------------------------
* Constructional praxis CERAD
local var "vdvis1"
local `var'_lab "CERAD Constructional praxis"
local `var'_source "h1rcpimmscore"
local `var'_domain "Visuospatial"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
   local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is CERAD constructional praxis immediate. The summary variable is a simple recode (for missing, other non-response codes as system missing) version of \verb+``var'_source'+" ;
#d cr
* ---------------------------------------------------------
* Copy polygons MMSE
local var "vdvis2"
local `var'_lab "MMSE copy polygons"
local `var'_source "h1rmse22"
local `var'_domain "Visuospatial"
cap drop `var'
scoreit ``var'_source' , ///
   indicator(1) /// count the 1's which are corrects in MMSE scoring
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
   local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the copy polygons item from the MMSE. It is based only on \verb+``var'_source'+, with missing codes excluded (97, 98, 99)." ;
#d cr

* =========================================================
* Executive Function --------------------------------------
* ---------------------------------------------------------
* Raven's progressive matrices
local var "vdexf1"
local `var'_lab "Raven's progressive matrices"
local `var'_source "h1rrvscore"
local `var'_domain "Executive function"
cap drop `var'
scoreit ``var'_source' , ///
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
   local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the score from Raven's progressive matrices. It is based only on \verb+``var'_source'+" ;
#d cr
* ---------------------------------------------------------
* Trailmaking part B
local var "vdexf2"
local `var'_lab "Trails B time (observed 32-300 seconds)"
local `var'_source "h1rtmb1min h1rtmb1sec"
local `var'_domain "Executive function"
cap drop `var'
cap drop tmtbtime
gen _tmtbtime=((h1rtmb1min*60)+h1rtmb1sec) if h1rtmb1min<990 & h1rtmb1sec<990
gen `var'=1-(log(_tmtbtime)/log(300)) 
cap drop _tmtbtime
local `var'_alpha "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is \\ \begin{center}\[1-\frac{\log (T_B)}{\log (300)}\]\end{center} where \(T_B\) is the number of seconds needed to complete the Trails B task, and 300 is the ceiling on the number of seconds allowed to complete the task. The resulting score is 0 when the participant took 300 seconds to complete the task (or did not complete the task in 300 seconds and was assigned a score of 300), and 1 when the task was completed in 0 seconds (unsurprisingly, we do not observe scores of 1). The \emph{direction} of this log transformed score is such that higher scores (approaching 1) are better and indicate faster performance. Missing codes (i.e., not between 0 and 300 on the source variable(s)) are treated as missing. NB the reverse transformation is \(300^{(1-B)}\) where \(B\) is the log transformed, log-normalized complement number of seconds to complete the Trails B task." ;
#d cr
* ---------------------------------------------------------
* Errors, Cancellation number of missed letters
local var "vdexf3"
local `var'_lab "Errors, Cancellation number of missed letters"
local `var'_source "h1rlcmissed"
local `var'_domain "Executive function"
cap drop `var'
gen `var'=``var'_source' 
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This item \verb+`var'+ is simply a renaming of ``var'_source'. The source item derives from the ELSA study. No accomodation for missing or other non-response codes has been used." ;
#d cr
* ---------------------------------------------------------
* Errors, Cancellation number of incorrect marked letters
local var "vdexf4"
local `var'_lab "Errors, Cancellation number of incorrectly marked letters"
local `var'_source "h1rlcscincorr"
local `var'_domain "Executive function"
cap drop `var'
gen `var'=``var'_source' 
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This item \verb+`var'+ is simply a renaming of ``var'_source'. The source item derives from the ELSA study. No accomodation for missing or other non-response codes has been used." ;
#d cr
* ---------------------------------------------------------
* Errors, Symbol Digit Modality Test errors
local var "vdexf5"
local `var'_lab "Errors, Symbol Digit Modalities Test"
local `var'_source "h1rsdmerr"
local `var'_domain "Executive function"
cap drop `var'
gen `var'=``var'_source' if ``var'_source' <997
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This item \verb+`var'+ is simply a renaming of ``var'_source' with the additional restriction that values in \verb+``var'_source' are not carried to \verb+`var'+ if a missing value code (997, 998, 999). {\bf ISSUE:} Note that according to the \emph{2016 Harmonized Cognitive Assessment Protocol (HCAP) Study Protocol Summary}, the SDMT score is the number of correct pairings minus any mistakes or skips. If that is accurate, then the information encoded in \verb+`var'+ is also contained in the SDMT score (in Attention Speed domain). This lack of independence creates a logical dependency that will violate the local independence assumption of factor analysis (and item response theory) models." ;
#d cr
* ---------------------------------------------------------
* Errors, Fluency task errors
local var "vdexf6"
local `var'_lab "Errors, fluency"
local `var'_source "h1rafincorr h1rafnumincorr"
local `var'_domain "Executive function"
cap drop `var'
gen `var'=h1rafnumincorr 
replace `var'=0 if h1rafincorr==5
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This item \verb+`var'+ is a renaming of \verb+h1rafnumincorr+. Also, if the checkpoint item (\verb+h1rafincorr+ \emph{IWER: DID YOU RECORD ANY INCORRECT NAMES?}) has a value of 5 (no) then zero is imputed for the number of incorrection mentions. No accomodation for missing or other non-response codes has been used." ;
#d cr
* ---------------------------------------------------------
* Number series
local var "vdexf7"
local `var'_lab "HRS Number Series"
local `var'_source "h1rnsscore"
local `var'_domain "Executive function"
cap drop `var'
gen `var'=``var'_source' if ``var'_source' < 996
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This is from the \emph{2016 Harmonized Cognitive Assessment Protocol (HCAP) Study Protocol Summary}: Developed for the HRS, this section evaluates Respondents ability for numeric reasoning by presenting a series of 6 individual series of numbers, where one or two numbers in the series is missing. The Respondent is asked to take as much time as s/he needs, with the help of scrap paper and a pencil, to identify the missing number/s. This test is a block-adaptive test. Respondents are given a set of three number series questions of varying difficulty to first complete. Based on the number of correct responses in this first set of three (score Range = 0 to 4), Respondents are then assigned to a second set of three questions, for which the difficulty level is based on the number correct on the first set. The HRS uses two versions of the Number Series questions and respondents are assigned to the version that was not done in the previous wave. For HRS-HCAP, Respondents were assigned to the Number Series that was not assigned in the 2016 Core interview. If a Respondent was not able to do the Number Series section in the 2016 Core interview (not able to do practice questions, was too confused), then they were skipped out of this section. In creating \verb+`var'+, missing codes (codes 996 and higher) on the source variable \verb+``var'_source'+ are treated as system missing.";
#d cr
* =========================================================
* Attention/Speed -----------------------------------------
* ---------------------------------------------------------
* Symbol Digit
local var "vdasp1"
local `var'_lab "Symbol Digit Modalities Test score"
local `var'_source "h1rsdmscore"
local `var'_domain "Attention, speed"
cap drop `var'
gen `var' = ``var'_source'
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This item \verb+`var'+ is simply a renaming of ``var'_source'. No accomodation for missing or other non-response codes has been used. Note that according to the \emph{2016 Harmonized Cognitive Assessment Protocol (HCAP) Study Protocol Summary}, the SDMT score is the number of correct pairings minus any mistakes or skips. Watch out for logical dependency or local dependence with SDMT errors (in executive function domain)." ;
#d cr
* ---------------------------------------------------------
* Trails A
local var "vdasp2"
local `var'_lab "Trails A"
local `var'_source "h1rtmascore"
local `var'_domain "Attention, speed"
cap drop `var'
gen `var'=1-(log(``var'_source')/log(300)) if ``var'_source'<996
local `var'_alpha "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is \\ \begin{center}\[1-\frac{\log (T_A)}{\log (300)}\]\end{center} where \(T_A\) is the number of seconds needed to complete the Trails A task, and 300 is the ceiling on the number of seconds allowed to complete the task. The resulting score is 0 when the participant took 300 seconds to complete the task (or did not complete the task in 300 seconds and was assigned a score of 300), and 1 when the task was completed in 0 seconds (unsurprisingly, we do not observe scores of 1). The \emph{direction} of this log transformed score is such that higher scores (approaching 1) are better and indicate faster performance. Missing codes (i.e., not between 0 and 300 on the source variables) are treated as missing." ;
#d cr
* ---------------------------------------------------------
* MMSE-DLROW
local var "vdasp3"
local `var'_lab "MMSE spell world backwards"
local `var'_source "h1rmse12a h1rmse12b h1rmse12c h1rmse12d h1rmse12e"
local `var'_domain "Attention, speed"
cap drop `var'
scoreit ``var'_source' , ///
   indicator(1) /// count the 1's
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  : di %5.3f `r(alpha)' 
la var `var' "``var'_lab'"
#d ;
local `var'_note "\verb+`var'+ is the sum of 5 recorded responses to the MMSE spell world backwards task, recored with five correct/incorrect indicators. Only correct responses are summed (code 1 on source variables). At least 1 of the five indicators must have a non-missing code (not missing or 96, 97, 98, 99) to get the 0-5 score on \verb+`var'+." ;
#d cr
* ---------------------------------------------------------
* Backwards counting
local var "vdasp4"
local `var'_lab "Backwards counting"
local `var'_source "h1rbcscore"
local `var'_domain "Attention, speed"
cap drop `var'
gen `var'= ``var'_source' if ``var'_source'<96
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This is from the  \emph{2016 Harmonized Cognitive Assessment Protocol (HCAP) Study Protocol Summary}: This test assesses speed and attention and is derived from the Backward Count measure in the MIDUS Study. Respondents are asked to begin at 100 and to count backwards as fast as possible. They are given 30 seconds and the number they reach and number of errors are recorded.";
#d cr
* ---------------------------------------------------------
* Letter cancellation
local var "vdasp5"
local `var'_lab "Letter cancellation"
local `var'_source "h1rlcscore"
local `var'_domain "Attention, speed"
cap drop `var'
gen `var'= ``var'_source' if ``var'_source'<96
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "This is from the  \emph{2016 Harmonized Cognitive Assessment Protocol (HCAP) Study Protocol Summary}: This test has been included in ELSA and assesses attention and speed. Respondents are given a paper with a large grid of letters and are asked to scan the grid as quickly as possible in a minute and to cross out as many \emph{P} and \emph{W} letters as they can in that time. This variable (\verb+`var'+, renamed and otherwise unmolested version of \verb+``var'_source'+) is the number of correctly crossed-out letters." ;
#d cr
* =========================================================
* Language, fluency ---------------------------------------
* ---------------------------------------------------------
* Category (animal) fluency	H1RAFSCORE	language/fluency
local var "vdlfl1"
local `var'_lab "Category fluency (animals)"
local `var'_source "h1rafscore"
local `var'_domain "Language, fluency"
cap drop `var'
gen `var'=``var'_source'
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "The created variable \verb+vdlfl1+ is simply a copied or renamed version of \verb+``var'_source'+. No handling of missing response codes was implemented (none were observed)." ;
#d cr
* ---------------------------------------------------------
* TICS – Naming “scissors”, “cactus”	TICSNAMING	language/fluency
local var "vdlfl2"
local `var'_lab "Naming 2 items HRS TICS scissors, cactus"
local `var'_source "h1rticsscisor h1rticscactus"
local `var'_domain "Language, fluency"
cap drop `var'
scoreit ``var'_source' , ///
   indicator(1) /// count the 1's
   missinglist(7 8 9) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  : di %5.3f `r(alpha)'
la var `var' "``var'_lab'"
#d ;
local `var'_note "This is the number of correct responses to the HRS TICS items name two objects (scisssor, cactus). Respondents must have at least 1 non-missing (not system missing, not 7, 8, 9) to get a score." ;
#d cr
* ---------------------------------------------------------
* MMSE – Naming “watch”, “pen”	MMSENAMING	language/fluency
local var "vdlfl3"
local `var'_lab "Naming 2 items MMSE"
local `var'_source "h1rmse14 h1rmse15"
local `var'_domain "Language, fluency"
cap drop `var'
scoreit ``var'_source' , ///
   indicator(1) /// count the 1's
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  : di %5.3f `r(alpha)'
la var `var' "``var'_lab'"
#d ;
local `var'_note "This is the number of correct responses to the two MMSE name objects questions. Respondents must have at least 1 non-missing (not system missing, not 97, 98, 99) to get a score." ;
#d cr
* ---------------------------------------------------------
* MMSE – Sentence	H1RMSE21	language/fluency
local var "vdlfl4"
local `var'_lab "MMSE write a sentence"
local `var'_source "h1rmse21"
local `var'_domain "Language, fluency"
cap drop `var'
gen `var'=``var'_source'==1 if ``var'_source'<96
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "The variable `var' is an indicator as to whether  ``var'_source' is scored as correct (value 1). Missing codes (any value coded 96 or higher) are treated as missing";
#d cr
* ---------------------------------------------------------
* MMSE – “No ifs, ands, buts”	H1RMSE16	language/fluency
local var "vdlfl5"
local `var'_lab "MMSE repeat phrase"
local `var'_source "h1rmse16"
local `var'_domain "Language, fluency"
cap drop `var'
gen `var'=``var'_source'==1 if ``var'_source'<96
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "The variable `var' is an indicator as to whether  ``var'_source' is scored as correct (value 1). Missing codes (any value coded 96 or higher) are treated as missing";
#d cr
* ---------------------------------------------------------
* MMSE – Fold paper	MMSEPAPER	language/fluency
local var "vdlfl6"
local `var'_lab "MMSE three step command"
local `var'_source "h1rmse18 h1rmse19 h1rmse20"
local `var'_domain "Langauge, fluency"
cap drop `var'
scoreit ``var'_source' , ///
   indicator(1) /// count the 1's
   missinglist(97 98 99) /// responses treated as missing
   minitems(1) all /// must have at least 1 item
   gen(`var') // name of variable 
local `var'_alpha  : di %5.3f `r(alpha)'
la var `var' "``var'_lab'"
#d ;
local `var'_note "This is the number of correct responses to the three step command task in the MMSE. Respondents must have at least 1 non-missing (not system missing, not 97, 98, 99) to get a score." ;
#d cr
* ---------------------------------------------------------
* MMSE – Close eyes	H1RMSE17	language/fluency
local var "vdlfl5"
local `var'_lab "MMSE read and follow command"
local `var'_source "h1rmse17"
local `var'_domain "Language, fluency"
cap drop `var'
gen `var'=``var'_source'==1 if ``var'_source'<96
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "The variable `var' is an indicator as to whether  ``var'_source' is scored as correct (value 1). Missing codes (any value coded 96 or higher) are treated as missing";
#d cr
* ---------------------------------------------------------
* CSI-D score (sum of elbow, hammer, store, point)	H1R1066SCORE	language/fluency
local var "vdlfl6"
local `var'_lab "1066 object naming"
local `var'_source "h1r1066score"
local `var'_domain "Language, fluency"
cap drop `var'
gen `var'=``var'_source'
local `var'_alpha  "NA"
la var `var' "``var'_lab'"
#d ;
local `var'_note "The created variable \verb+vdlfl1+ is simply a copied or renamed version of \verb+``var'_source'+. No handling of missing response codes was implemented (none were observed)." ;
#d cr

cap drop tail
gen tail=. // to keep track of start and end of cog items
gen _tmtbtime=((h1rtmb1min*60)+h1rtmb1sec) if h1rtmb1min<990 & h1rtmb1sec<990 // regenerate for comparison

save w110.dta , replace


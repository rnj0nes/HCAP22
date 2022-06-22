
# HCAP22-CFA-HCAP

This repo contains (mostly) Stata code used in analyses of the Health and
Retirement Study (HRS) Harmonized Cognitive Assessment Protocol (HCAP).

Using these command files will require:

* Stata (files were prepared using version 16)
* R (version 4.1+)
* Mplus (version 7.1+)

The workhorse software is Stata.

Using these files will also require HRS/HCAP data, as well as restricted use
data that cannot be provided or accessed outside of a special enclave.

## Four analysis projects in subfolders

This repo currently (6/22/2023) has four projects in four folders

|Project folder|Major analysis described|
|---|---|
|CFA-HCAP|The variable definition and factor analysis models. View summary report as [pdf](https://hrshcap.s3.amazonaws.com/Old_New_Compare/NEW-CFA-HCAP_a4.pdf)|
|Norms-with-weights-202109|The norming, adjusting and standardizing procedures for summary scores from the factor analysis. View a summary report [pdf](https://hrshcap.s3.amazonaws.com/Old_New_Compare/NEW-Norms-with-weights-202109_a6.pdf)|
|Dementia-algorithm|Dementia algorithm analyses. View a summary report as [html](https://hrshcap.s3.amazonaws.com/Old_New_Compare/NEW-dementia-algorithm-cut35-2021-10-05.html)|
|MS-prev-dem|Analyses for a paper under review summarizing the normalization, standardization, and dementia algorithm analyses. View a summary report as [docx](https://hrshcap.s3.amazonaws.com/Old_New_Compare/NEW-MS-Prev-Dem.docx)|


## Note on code: do files

Stata code are provided (`do` files). A summary report (PDF) is also provided.
The code is prepared to use Jann's `texdoc.ado` to execute the Stata code
and generate the PDF summary document.

The code is organized as follows. To run the code, open the `-000-master.do`
command file and run all of the lines. These lines `include` all of the
sub-command files (e.g., `-205-table1.do`).

I make extensive use of personal `ado` files. These are not shared in this
repo and I do not keep track of which of the commands I call are custom `ado`s.
The user will discover this, frustratingly, by `command not found` errors
thrown by Stata. A very easy way to avoid this is to add a folder holding my
custom `ado`s to your `adopath`. The way to do this is to run

`adopath +"https://quantsci.s3.amazonaws.com/Jones-ADO/"`

from the Stata command line before trying to execute the command files. Now, it
is possible you might run these programs and still get a `command not found`
error, but in this case the missing command is a command available from
SSC (or elsewhere). A way to protect yourself from this error is to also add a
copy of my plus commands to your `adopath`, with:

`adopath +"https://quantsci.s3.amazonaws.com/Jones-ADO-plus/"`

Or, you could encounter these errors and add the commands to your own "plus"
as they come up. That way is more painful and time consuming, but then you
have these ados in your workflow more permanently.

## Note on code: stmd files

Two of the subprojects are coded in German Rodriguez's `markstat` command /
framework. These are files with the "stmd" suffix. I especially like this
approach for the easy integration of `R` and `Stata`. However, this framework is
limited relative to R markdown and I'll still be transitioning to R. Regardless,
the command for executing these programs is embedded in the top of the command
file. For example in the `MS-prev-dem.stmd` file, there is near the top:

> `<!--`
> `cd /Users/rnj/Dropbox/Work/HCAP22/POSTED/ANALYSIS/MS-Prev-Dem/`
> `markstatit MS-Prev-Dem.stmd , strict keep bundle docx`
> `-->`

That code block is enclosed in markdown comments (`<!-- blah -->`). So when the
enclosing `stmd` file is sent to Stata/markstat, it will be deleted. I use this
block of code to execute the program from the code editor. I highlight the two
lines with Stata code and send those to Stata.


## Contact

Please feel free to contact me with questions, missing commands or files, or
any other challenges you have using these resources.

Rich Jones

[rich_jones@brown.edu](mailto:rich_jones@brown.edu)


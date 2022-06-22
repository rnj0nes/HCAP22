tex \newpage
tex \section{How to generate scores in a new sample}


tex \begin{description}
tex \item[1. Administer the HCAP] according to the procedures and scoring
tex                            rules used in the HRS/HCAP.
tex \item[2. Collect sociodemographic] information including age at testing, 
tex                            sex (only male/female), whether or not the 
tex                            examinee identifies as Black or African American, 
tex                            whether or not the examinee identifies as Hispanic,
tex                            and the number of years of schooling the examinee 
tex                            has obtained. The collection of this information
tex                            should also conform to the procedures used in HRS to 
tex                            maximize comparability.
tex \item[3. Generate factor scores] for processed HCAP data. I use Mplus
tex                            (version 8.1, Muthen \& Muthen, Los Angeles, CA)
tex                            to generate these factor scores. The
tex                            factor scores are either means or
tex                            random draws from a posterior distribution
tex                            of plausible scores given the previously
tex                            estimated model in HRS/HCAP. (It may be possible
tex                            to work out an open source solution to 
tex                            estimating these scores if Mplus is not
tex                            available.) Snippets of this procedure are contained
tex                            in the code prepared for the HRS/HCAP factor analysis 
tex                            manuscript, but are {\bf not} currently ready for production.
tex                            Code for this step will run from Stata, and use a wrapper function
tex                            to call Mplus, and therefore will not require specialized
tex                            knowledge of Mplus. Mplus is only used as a "factor scoring machine".
tex \item[4. Normalization of factor scores.] Factor scores were normalized in the 
tex                            norming sample using a rank-based transformation
tex                            (the Blom transformation). We have linear
tex                            functions based on restricted cubic
tex                            splines that can accomplish the same rescaling
tex                            in a new sample without making direct use of the
tex                            HRS/HCAP norming sample. These transformations 
tex                            are available as production-ready Stata code.
tex \item[5. Standardization of factor scores] using the regression adjustment
tex                            results obtained in the HRS/HCAP norming sample. This
tex                            step involves subtracting a predicted performance
tex                            score from an observed performance score, and scaling 
tex                            according to the standard error of estimate in
tex                            the norming sample. This
tex                            step is available as production-ready Stata code.
tex \end{description}
tex                            

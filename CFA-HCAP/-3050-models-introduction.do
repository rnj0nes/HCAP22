* a4-305-models.do
* Rich Jones
* 22 Jan 2019
* -----------------
*




use w206.dta , clear

tex \newpage
tex \section{Psychometric modeling - unidimensional models}

tex \subsection{Types of models}
tex I will be running a variety of types of confirmatory factor analysis models. Here is a quick overview:

tex \begin{center}
tex \includegraphics[width=\textwidth]{HCAP-Models-overview.png}
tex \end{center}

tex {\bf Single factor} models examine the fit of a single domain of functioning independent of
tex other domains. The single factor models are an end in and of 
tex themselves. One product we would like to generate
tex are estimates of domain-specific performance. For these,
tex all that are required are well-fitting and reasonably 
tex constructed single factor models. All other more complicated
tex models serve other purposes (e.g., obtaining an estimate of
tex general cognitive performance, summarizing across domains,
tex demonstrating the extent to which the domains measure
tex distinct constructs, taking advantage of the multi-domain
tex structure and non-independent measurements to obtain
tex estimates of individual domain performance from a reduced
tex set of items, etc.).\\[0.25cm]

tex {\bf Correlated factors with a methods factor}. The Correlated factors models 
tex examine the fit of a model with multiple domains simultaneosly, 
tex and no structure is imposed on the domain specific factors but they are allowed to 
tex correlate with one another freely. We include a 
tex specific factor that links items across domains that share stimulus material. For example,
tex the immediate and delayed recall of the same word list. \\[0.25cm]

tex {\bf Second order factor} models include specific domains, but attempt to account for
tex the correlation among domain specific factors with a single general and second order
tex factor.


tex \subsection{Assessing model fit}
tex Latent variable measurement models (CFA) were estimated using Mplus software 
tex and the weighted least squares estimator with mean and variance standardization (WLSMV) 
tex and theta parameterization. We only moved to multi-dimensional models after a 
tex satisfactorily fitting unidimensional models within an a priori specified domain was 
tex achieved. Model fit was evaluated with the standardized root mean square residual (SRMR), 
tex confirmatory fit index (CFI), and root mean squared error of approximation. 
tex Greatest weight was afforded the SRMR and an examination of model residuals.\\[0.5cm]

tex {\bf Guide to model fit}
tex Model fit is good, adequate or poor according to the following criteria:\\[0.5cm]
tex \begin{center}
tex \begin{tabular}{|p{2cm} | ccccc |}
tex \hline
tex {\bf Descriptor} & {\bf CFI} && {\bf RMSEA} && {\bf SRMR} \\
tex \hline
tex perfect & \(1.00\) & AND & \(0.00\) & AND & \(0.00 \) \\ 
tex \hline
tex good     & \(\ge 0.95\) & AND & \(\le 0.05\) & AND & \(\le 0.05 \) \\ 
tex \hline
tex adequate & \(\ge 0.90\) & AND & \(\le 0.08\) & AND &  \(\le 0.08 \) \\ 
tex \hline
tex poor & \(< 0.90\) & OR & \(> 0.08\) & OR & \(> 0.08 \) \\ 
tex \hline
tex \end{tabular}\\[0.5cm]
tex \end{center}

tex Note: Perfectly fitting models will arise when a common factor model is fit to less than four indicators.\\[0.25cm]

tex The {\bf SRMR} is an \emph{absolute fit measure} based on residuals and is not penalized for model complexity, 
tex and ideal values
tex approach 0.\\[0.25cm]

tex The {\bf RMSEA} is an \emph{absolute fit measure} can be viewed as an index of model discrepancy per degree of freedom. It is
tex computed as \(\frac{\sqrt{\chi^2-df}}{\sqrt{df(n-1)}}\) where \(\chi^2\) is the model
tex chi-square (higher values indicate greater discrepancy between observed mean and covariance 
tex matrix and model-implied mean and covariance matrix), \(df\) is the model degrees of freedom
tex (a function of the number of variables and number of parameters estimated) and \(n\) is 
tex the sample size. This fit index is sensitive to the number of parameters and sample size. Ideal
tex values approach 0 and when the computation is less than 0 the RMSEA is set to 0.\\[0.25cm]

tex the {\bf CFI} is an \emph{incremental fit measure} and compares the fit of the target model to a null model. It is 
tex computed as \(1-d_0/d_1\) where \(d = \chi^2-df\) and the subscript 0 indicates a null model and subscript 1 
tex indicates a target model.\\[0.25cm]

tex If SRMR indicates good fit but CFI and/or RMSEA do not, it could be that there extraneous
tex parameters being estimated 
tex (e.g., regressions or factor loadings that are not important).\\[0.25cm]

tex {\bf Mean weighted fit index}\\
tex In this report, I will summarize model fit using a novel heuristic index 
tex that I am calling the \emph{mean weighted fit index} that is
tex computed as 
tex \begin{center}
tex \( \text{MWFI} = 0.9 + \frac{1}{3} \left[ (CFI-0.9) + 1.25(0.08 - RMSEA) + 1.25(0.08 - SRMR)  \right] \)
tex \end{center}

tex The MWFI will take on values up to 1, and will be 0.9 when all three fit indices are at bare
tex adequate levels (CFI = 0.9, RMSEA = .08, SRMR = .08), will be 0.94 when all three criteria 
tex are equal to the "good" criteria detailed below, and will approach 1 as these
tex three fit indices approach their ideal points (CFI \(\rightarrow\) 1, RMSEA \(\rightarrow\) 0, 
tex SRMR \(\rightarrow\) 0 ). The utility of this MWFI is to judge fit taking into account
tex the three indices and to allow ranking of models within the same verbal descriptor
tex level. \\[0.5cm]

tex {\bf Factor reliability (Omega)}\\
tex For single factor models, I will also show the omega coefficient, which is a 
tex measure of internal consistency reliability and interpreted as one would a coefficient
tex alpha. It is computed as \\
tex \begin{center}
tex \(\omega_t =
tex       \frac{(\Sigma\lambda_j)^2}
tex            {\left[(\Sigma\lambda_j)^2+\Sigma(1-\lambda_j^2)\right]}\)
tex \end{center}
tex where \(\lambda_j\) is the standardized measurement slope (factor loading) for
tex indicator \(j\).

tex \subsection{Data notes}
tex In the psychometric data analysis, variables that have 10 or fewer discrete values
tex are treated as categorical variables. All other variables are treated as continuous.
tex Continuous variables are transformed to a 0-1 scale before modeling. Variables so
tex transformed have a \verb+"z"+ appended to their name.








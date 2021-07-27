* Recidivism in the U.S.

use https://www.stata.com/data/jwooldridge/eacsap/recid


desc

summ

* workprg	an indicator of participation in a work program

* The duration variable is called durat and represents time in months until return to prison or end of follow up.

* The censoring indicator is called cens and is coded 1 if the observation was censored (i.e. the individual had not returned to prison).

* We create a new variable fail coded 1 for failures.
gen fail = 1 - cens

* A Proportional Hazards Weibull Model

* Let us first fit a proportional hazards model with a Weibull baseline, using stset to set the data and survreg to fit the model. To avoid repetition we will save the predictors in a macro.

stset durat, failure(fail)

local predictors workprg priors tserved felon alcohol drugs ///
  black married educ age

streg `predictors', distrib(weibull)

* By default Stata exponentiates the coefficients to show relative risks. Use the option nohr for no hazard ratios to obtain the coefficients.

streg, nohr

* Woolridge Table 20.1: 
* All but three of the predictors have significant coefficients, the exceptions being participation in a work program, marital status, and education.

* The Weibull parameter p is 0.8, indicating that the risk of recidivism declines over time, about 21% per month. The hypothesis that the risk is constant over time would be soundly rejected.


* The exponentiated coefficient of drugs (1.32) indicates that former inmates with a history of drug use have 32.5% higher risk or returning to jail at any given time than peers with identical characteristics but no history of drug use.


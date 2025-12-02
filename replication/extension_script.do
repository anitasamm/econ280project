****************************************************************
* EXTENSION: Heterogeneous RD effect by baseline poverty (1980)
****************************************************************

clear all
set more off

* 1. Load the final dataset
use "FPM1980_1991_final.dta", clear

* 2. Keep observations near the RD cutof
keep if pscore > -10 & pscore < 10
count

* 3. Choose the outcome
local outcome educ19_2891

* 4. Standardize baseline poverty (poverty80)
summ poverty80
gen poverty80_std = (poverty80 - r(mean)) / r(sd)

* Make sure it's not all missing
summ poverty80_std

* 5. Interaction term for heterogeneity
gen aaa_pov80 = aaa * poverty80_std

* 6. Baseline RD model 
reg `outcome' aaa pscore pscore_a pscore_sq pscore_a_sq, r

* 7. Heterogeneous RD model
reg `outcome' aaa aaa_pov80 poverty80_std ///
    pscore pscore_a pscore_sq pscore_a_sq, r


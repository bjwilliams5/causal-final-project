clear
set mem 500m

cd F:\4248\D-Drive\emfield\peru\COFOPRI\revisions\QJE_Files\

use analysis_sample.dta, clear

tab region, gen(_I_dist)
forval X = 1/7 {
egen mean_I_dist`X'=mean(_I_dist`X')
gen new_I_dist`X'=_I_dist`X'- mean_I_dist`X'
gen ds`X'=squat*new_I_dist`X'
gen de`X'=enter*new_I_dist`X'

}

/*Table 4*/
/*Columns 1-3: Labor Hours*/

xi: svyreg totwkhrs squat enter enteryr entsquat lotsize tenure wrkage members seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de* 
quietly svylc entsquat
outreg2 squat entsquat using table4, replace  nonotes nor2 title("Table 4: Total HH Weekly Hours") addstat("Mean Program Effect", r(est), SE, r(se)) br nocons comma nolabel se adec(3) bdec(2) 10pct

xi: svyreg totwkhrs squat enter enteryr entsquat enteryrsquat lotsize tenure members wrkage seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de* 
svylc (2*enteryrsquat) +entsquat
outreg2 squat entsquat enteryrsquat using table4, append  nonotes nor2 addstat("Mean Program Effect", r(est), SE, r(se)) br nocons comma nolabel se adec(3) bdec(2) 10pct 

/*Note: "tenentsquat" in published version mistakenly defined using "tenureb" variable (respondent yrs in residence)". Fixed in dataset on 10/5/2009*/

xi: svyreg totwkhrs squat enter enteryr entsquat enteryrsquat lotsize tenure tenent tenuresquat tenentsquat wrkage wrkage2 wrkageent wrkagesquat wrkageent2 wrkagesquat2 wrkageentsquat wrkageentsquat2 members seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de*
svylc (2*enteryrsquat) +entsquat+(15*tenentsquat)+(4*wrkageentsquat)+(16*wrkageentsquat2)
outreg2 squat entsquat enteryrsquat tenentsquat wrkageentsquat wrkageentsquat2 using table4, append  nonotes nor2  addstat("Mean Program Effect", r(est), SE, r(se))  br nocons comma nolabel se adec(3) bdec(2) 10pct 

/* Total Hours Program Effect*/

svylc (2*enteryrsquat) +entsquat+(15*tenentsquat)+(4*wrkageentsquat)+(16*wrkageentsquat2)
return list
svylc (2*enteryrsquat) +entsquat+(15*tenentsquat)+(3*wrkageentsquat)+(9*wrkageentsquat2)
return list
svylc (2*enteryrsquat) +entsquat+(10*tenentsquat)+(3*wrkageentsquat)+(9*wrkageentsquat2)
return list


xi: svyreg totwkhrs squat enter enteryr entsquat tenure wrkage lotsize invader i.region ds*  de* 
quietly svylc entsquat
outreg2 squat entsquat using table4, append  nonotes nor2 title("Table 4: Total HH Weekly Hours")  addstat("Mean Program Effect", r(est), SE, r(se)) br nocons comma nolabel se adec(3) bdec(2) 10pct 

xi: svyreg totwkhrs squat enter enteryr entsquat enteryrsquat tenure wrkage invader lotsize i.region ds*  de* 
quietly svylc entsquat+(2*enteryrsquat)
outreg2 squat entsquat enteryrsquat using table4, append  nonotes nor2 addstat("Mean Program Effect", r(est), SE, r(se)) br nocons comma nolabel se adec(3) bdec(2) 10pct 

xi: svyreg hw squat enter enteryr entsquat tenure lotsize invader i.region ds*  de* 
quietly svylc entsquat
outreg2 squat entsquat using table4, append  nonotes nor2 addstat("Mean Program Effect", r(est), SE, r(se)) br nocons comma nolabel se adec(3) bdec(2) 10pct

xi: svyreg hw squat enter enteryr entsquat enteryrsquat tenure lotsize invader i.region ds*  de* 
quietly svylc entsquat+(2*enteryrsquat)
outreg2 squat entsquat enteryrsquat using table4, append  nonotes nor2 addstat("Mean Program Effect", r(est), SE, r(se)) br nocons comma nolabel se adec(3) bdec(2) 10pct 

xi: areg totwkhrs squat enter enteryr entsquat tenure wrkage lotsize invader , absorb(segment)
quietly lincom entsquat
outreg2 squat entsquat using table4, append  nonotes nor2 br nocons comma nolabel se bdec(2) 10pct 

xi: areg totwkhrs squat enter enteryr entsquat enteryrsquat tenure wrkage invader lotsize, absorb(segment)
quietly lincom entsquat+(2*enteryrsquat)
outreg2 squat entsquat enteryrsquat using table4, append  nonotes nor2 br nocons comma nolabel se bdec(2) 10pct 

/*Columns 9-10: Home Business*/
xi: reg homebus squat enter enteryr entsquat lotsize tenure invader  i.region ds*  de* 
outreg2 squat entsquat using table4, append nonotes br nocons comma nolabel se bdec(2) 10pct 

/*Column 10: Commuter in HH*/
xi: svyreg commuter squat enter enteryr entsquat lotsize tenure invader  i.region ds*  de*    
quietly svylc entsquat
outreg2 squat entsquat using table4, append  nonotes nor2  addstat("Mean Program Effect", r(est), SE, r(se)) br nocons comma nolabel se adec(3) bdec(2) 10pct 


/*Table 5: IV Regs*/

/*First endog var: Whether have a title (including municipal, COFOPRI, sales, or registered other)*/

xi: svyreg hastitle entsquat squat enter enteryr lotsize tenure wrkage members seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de* 
outreg2 squat entsquat using table5, replace nonotes br nocons comma nolabel se 10pct

xi: svyivreg totwkhrs (hastitle=entsquat) squat enter enteryr lotsize tenure wrkage members seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de* 
outreg2 squat hastitle using table5, append nonotes br nocons comma nolabel se 10pct

/*Second endog var: Whether have title and experienced improvement in tenure security 
(Note: Survey only asked people who have sales, municipal, or COFOPRI titles about change in security, so outcome missing for 101 obs considered titled by our definition (registered title of another type). outcome is zero for untitled even though not asked since outcome is titled AND experienced change in ten sec)*/

xi: svyreg chtensec entsquat squat enter enteryr lotsize tenure wrkage members seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de* 
outreg2 squat entsquat using table5, append nonotes br nocons comma nolabel se

xi: svyivreg totwkhrs (chtensec=entsquat) squat enter enteryr lotsize tenure wrkage members seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de* 
outreg2 squat chtensec using table5, append nonotes  br nocons comma nolabel se 10pct
 
/*Now exclude recently treated areas*/
xi: svyreg hastitle entsquat squat enter enteryr lotsize tenure wrkage members seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de* if enteryr~=1
outreg2 squat entsquat using table5, append nonotes br nocons comma nolabel se

xi: svyivreg totwkhrs (hastitle=entsquat) squat enter enteryr lotsize tenure wrkage members seniors agehd sexhd hshd collhd unihd pctmale   hadporg literhd invader shock plumbing  inherit walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region ds*  de* if  enteryr~=1
outreg2 squat hastitle using table5, append nonotes  br nocons comma nolabel se 10pct


/*Table 8*/
/*Column 1: Labor Hours*/

xi: quietly  svyreg totwkhrs squat enteryr_fut enteryr_futsquat lotsize tenure wrkage sexhd agehd hshd collhd unihd pctmale hadporg literhd seniors   invader shock plumbing inherit members walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region  de* ds*    
quietly svylc  (2*enteryr_futsquat)
outreg2 squat enteryr_fut enteryr_futsquat using table8, replace  nonotes nor2 title("Table 7: Control Exp")  addstat("Mean Program Effect", r(est), SE, r(se))  br nocons comma nolabel se 10pct adec(3) bdec(2)


/*Column 2: Home Business*/

xi: svyprobit homebus squat enteryr_fut enteryr_futsquat lotsize tenure wrkage sexhd agehd hshd collhd unihd pctmale hadporg literhd seniors   invader shock plumbing inherit members walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region  de* ds*   

/*Marginal Effects, no Interact*/

quietly mfx c, nose
matrix A=e(Xmfx_dydx)

gen mes=A[1,4]
quietly svylc (2*enteryr_futsquat)

outreg2 squat enteryr_fut enteryr_futsquat using table8, append nonotes addstat("Marginal FX", mes, "Mean Program Effect", r(est), SE, r(se))  br nocons comma nolabel se 10pct adec(3) bdec(2)

/*Column 3: Security*/

xi: dprobit secure3 squat enteryr_fut enteryr_futsquat lotsize tenure wrkage sexhd agehd hshd collhd unihd pctmale hadporg literhd seniors   invader shock plumbing inherit members walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region  de* ds* if tensec~=.
quietly lincom  (2*enteryr_futsquat)
outreg2 squat enteryr_fut enteryr_futsquat using table8, append  nonotes nor2 br nocons comma nolabel se 10pct  bdec(2)

xi: areg secure3 squat enteryr_fut enteryr_futsquat lotsize tenure wrkage if tensec~=., absorb(segment)
quietly lincom  (2*enteryr_futsquat)
outreg2 squat enteryr_fut enteryr_futsquat using table8, append  nonotes nor2  br nocons comma nolabel se 10pct bdec(2)

xi: dprobit secure1 squat enteryr_fut enteryr_futsquat lotsize tenure wrkage sexhd agehd hshd collhd unihd pctmale hadporg literhd seniors   invader shock plumbing inherit members walk1 walk2 walk6 walk8 walk10 tmtran1 tmtran2 tmtran3 tmtran4 tmtran5 s2y1 s2y2 s2y3 s2y4 s2y5 s1 s2 s3 s4 s5  segschlprog segsocprog segfamplan i.region  de* ds* if tensec~=.
quietly lincom  (2*enteryr_futsquat)
outreg2 squat enteryr_fut enteryr_futsquat using table8, append  nonotes nor2 br nocons comma nolabel se 10pct  bdec(2)

xi: areg secure1 squat enteryr_fut enteryr_futsquat lotsize tenure wrkage if tensec~=., absorb(segment)
quietly lincom  (2*enteryr_futsquat)

outreg2 squat enteryr_fut enteryr_futsquat using table8, append  nonotes nor2  br nocons comma nolabel se 10pct bdec(2)


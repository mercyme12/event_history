*******************byJeong, S.J.********************************
********************21.01.22.***********************************
*******[[main analysis:event_histroy, logit, mlogit]]***********
****************************************************************

use age50_survival_V2_210119_v1_stcox_result1, clear
use age50_survival_V2_210119, clear

gen voluntary = B4_1
recode voluntary 1=0 2=0 3=0 4=0 5=1 6=0 7=0 8=0 9=1 10=0 11=1 12=1 13=1 14=1 15=0 16=0 17=1 18=1 19=1, gen(voluntary_d)

gen econsatis_bf = G1A_1
gen healthsatis_bf = G1A_2
gen worksatis_bf = G1A_4
egen socialsatis_bf = rowmean(G1A_6 G1A_7 G1A_8 G1A_9)
gen lifesatis_bf = G1A_10
gen leisatis_bf = G1A_5

save age50_survival_V2_210119_v2_stcox_result2, replace // 변수 추가
save age50_survival_V2_210126_v2_stcox, replace // 변수 추가

drop if gender==2  //여성(409)은 제외 => 362

*******************
***event-history***
*******************

use age50_survival_V2_210119_v2_stcox_result2, clear // 변수 추가
use age50_survival_V2_210126_v2_stcox,  clear


drop if gender==2  //여성(409)은 제외 => 362
drop if age_1stend < 40 //
drop if age_1stend < 45 // 

save age50_survival_V2_210119_v2_40_survival, replace // 남자들만 저장해야지 첫 일자리 종료 연령 40세 이상
save age50_survival_V2_210119_v2_45_survival, replace // 남자들만 저장해야지 첫 일자리 종료 연령 45세 이상


recode JOB1 1=0 2=1, gen(job1_dummy) 


drop if surtime1 <0  // 재귀업 구직 소요기간(달)이 음수이면 다 제외 (35 obs deleted)
count if surtime < surtime2 //첫번째 일자리보다 두번째 일자리가 더 걸린 case 확인(11개이나 안지움)
order ID surtime surtime1 surtime2 surtime3



stset surtime1, failure(job1_dummy==1) //***일을 바로 그만 둔 남성은 2명밖에 없음!!! 은퇴2명, 재취업360명


//최종~~~!!! 심리적 상태 이전으로 바꾸기
stcox age i.location_re i.schooling_re_r marriage_dummy i.children_d ///
	lifesatis_1 jobsatis_1 healthsatis_1 ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	age_1stend workmonth_1 i.RA2_19 i.voluntary_d i.occupation_1_re i.workplace_5 ib6.prepare_re_re  // ib3.employment_1_re 은 employment 제거 	

outreg2 using age50_survival_V2_210119_v2_stcox_men_40_result.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)
outreg2 using age50_survival_V2_210119_v2_stcox_men_45_result.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


list ID B7 B7_3 if B7_3==1 | B7_3==2 | B7_3==3 , nod noobs
list ID B7_3 if B7_3==1 | B7_3==2 | B7_3==3 | B7_3==4 , nod noobs
list ID B7_3 if  B7_3==3 , nod noobs

order ID JOB1 JOB2 B7_3 B7
tab B7_3

****21.01.26_survival proportionality assupmtion check***************
***************************************************************
****************************************************************
//tvc and the texp options
stcox age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	lifesatis_1 jobsatis_1 healthsatis_1 ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	age_1stend workmonth_1 i.RA2_19 i.voluntary_d i.occupation_1_re i.workplace_5 ib6.prepare_re_re, ///
	nohr tvc(age i.location_re i.schooling_re_r i.marriage_dummy i.children_d lifesatis_1 jobsatis_1 healthsatis_1 ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	age_1stend workmonth_1 i.RA2_19 i.voluntary_d i.occupation_1_re i.workplace_5 ib6.prepare_re_re) texp(ln(_t))


stcox age i.location_re i.schooling_re_r marriage_dummy i.children_d ///
	lifesatis_1 jobsatis_1 healthsatis_1 ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	age_1stend workmonth_1 i.RA2_19 i.voluntary_d i.occupation_1_re i.workplace_5 ib6.prepare_re_re  ///
	marriage_dummy#_t age_1stend#_t 

	
//Schoenfeld and scaled Schoenfeld residuals
qui stcox age i.location_re i.schooling_re_r marriage_dummy i.children_d ///
	lifesatis_1 jobsatis_1 healthsatis_1 ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	age_1stend workmonth_1 i.RA2_19 i.voluntary_d i.occupation_1_re i.workplace_5 ib6.prepare_re_re, schoenfeld(sch*) scaledsch(sca*)
stphtest, detail


************
***mlogit***
************
use age50_survival_V2_210119_v2_stcox_result2, clear // 변수 추가

drop if gender==2  //여성(409)은 제외 => 362
drop if job1_dummy==0 //은퇴한 사람(2) => 360
drop if age_1stend < 40 // 첫 일자리를 종료한 연령(12)이 40대 미만 => 348
//drop if age_1stend < 45 // 첫 일자리를 종료한 연령(12)이 40대 미만 => 348

save age50_survival_V2_210119_v2_40, replace // 남자들만 저장해야지 첫 일자리 종료 연령 40세 이상
save age50_survival_V2_210119_v2_45, replace // 남자들만 저장해야지 첫 일자리 종료 연령 45세 이상

//employment 1= 정규직, 2=비정규직, 3=자영업 최종~~~!!!
mlogit employment_2_3 ///
    age i.location_re i.schooling_re_r marriage_dummy i.children_d ///
	lifesatis_1 jobsatis_1 healthsatis_1 ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	age_1stend workmonth_1 i.RA2_19 i.voluntary_d i.occupation_1_re i.workplace_5 ib6.prepare_re_re , rrr // ib3.employment_1_re 
	
outreg2 using mlogit_V2_50plus_v2_men_40_employment.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


outreg2 using mlogit_V2_50plus_v2_men_45_employment.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


//연봉
gen paygap = A2_17 - A1_17
su paygap, de
hist paygap

gen paygap_dummy = 0
gen pay80 = A1_17 * 0.8
recode paygap_dummy 0=1 if A1_17 * 0.8 <= A2_17 // 1이면 주된일자리 수입 80% <= 은퇴후 일자리, 주된일자리 임금의 80% 이상

order A1_17 A2_17 pay80 paygap paygap_dummy
tab paygap_dummy // 0=124, 1=169 in 45, 0=134, 1=214 in 40


***********
***logit***
***********

logit paygap_dummy ///
    age i.location_re i.schooling_re_r marriage_dummy i.children_d ///
	lifesatis_1 jobsatis_1 healthsatis_1 /// 
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	age_1stend workmonth_1 i.RA2_19 i.voluntary_d i.occupation_1_re i.workplace_5 ib6.prepare_re_re , or // ib3.employment_1_re 
	
outreg2 using mlogit_V2_50plus_v2_men_40_pay.doc, replace ctitle(model2) alpha(0.001, 0.01, 0.05)

outreg2 using mlogit_V2_50plus_v2_men_45_pay.doc, replace ctitle(model2) alpha(0.001, 0.01, 0.05)


save age50_survival_V2_210119_v2_men_40_result, replace // 21.01.22
save age50_survival_V2_210119_v2_men_45_result, replace

recode A2_17 min/199=1 200/399=2 400/599=3 600/799=4 800/max=5, gen(A2_17_dummy)
recode A1_17 min/199=1 200/399=2 400/599=3 600/799=4 800/max=5, gen(A1_17_dummy)



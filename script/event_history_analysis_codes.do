***************By Jeong, S. J.*******************
*************************************************
***************[[Event_history_analysis]]********

stset surtime1, failure(event==1)
kdensity surtime1, kernel(gaussian)

* stset date1, origin(time date0) id(pid) failure(event=9) time(date0)
stsum
stsum, by(employment_2)

sts graph, by(employment_2)  //카플란마이어방법_집단별
sts graph, scheme(s2mono) //전체
sts graph, hazard kernel(epan2) scheme(s2mono) //위험률 함수 전체
sts graph, hazard kernel(epan2) by(employment_2) // 위험률함수에 그룹별


*****cox regression******

**★★★★★**근무형태 코딩 + 직종 코딩 + 고용형태 코딩 제거 **20.10.28. ** 변수추가: prepare 
stcox ib2.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  income_m_1_ln 퇴직전근로사업소득 income_before_ln 퇴직전 가계총소득
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 ib2.occupation_1_re ib3.workplace_4 ib3.employment_1_re /// present psychological state + 1st job model에 효과없은 employment 제거 	
	ib6.prepare_re_re
outreg2 using stcox_13.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

reg surtime1 ib2.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay ///  income_m_1_ln 퇴직전근로사업소득 income_before_ln 퇴직전 가계총소득
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 ib2.occupation_1_re ib3.workplace_4 ib3.employment_1_re /// present psychological state + 1st job model에 효과없은 employment 제거 	
	ib6.prepare_re
outreg2 using reg_14.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

save age50_survivalanalysis_v6_drop, replace 
save age50_survivalanalysis_v7_201028, replace 


gen workplace_4 =  workplace_1_re_r_r

stcurve, hazard at1(gender=1) at2(gender=2) kernel(gauss) // 생존그래프
stcurve, hazard at1(age_1stend=1) kernel(gauss)
stcurve, hazard at1(severancepay=1) at2(severancepay=2) kernel(gauss)
stcurve, hazard at1(occupation_1_re=1) at2(occupation_1_re=2) at3(occupation_1_re=3) at4(occupation_1_re=4) kernel(gauss)
stcurve, hazard at1(workplace_4=1) at3(workplace_4=3) at4(workplace_4=4) at5(workplace_4=5)   kernel(gauss)
stcurve, hazard at1(schooling_re_r=1) at2(schooling_re_r=2) kernel(gauss)
stcurve, hazard at1(occupation_1_re=1) at2(occupation_1_re=2) at3(occupation_1_re=3) at4(occupation_1_re=4) kernel(gauss)
stcurve, hazard at1(workplace_4=1) at3(workplace_4=3) at4(workplace_4=4) at5(workplace_4=5) kernel(gauss)
stcurve, hazard at1(employment_1_re=1) at2(employment_1_re=2) at3(employment_1_re=3) kernel(gauss)
stcurve, hazard at1(RA2_19=1) at2(RA2_19=2) kernel(gauss)

sts graph, by(gender)  //카플란마이어방법_집단별
sts graph, by(marriage_dummy) 
sts graph, by(schooling_re_r) 
sts graph, by(severancepay) 
sts graph, by(occupation_1_re) 
sts graph, by(workplace_4) 
sts graph, by(RA2_19) 
sts graph, by(employment_1_re) 


stcox A2_19 i.A1_15 A1_5_3, nohr  //콕스비례위험모형_coefficient
stcox A2_19 i.A1_15 A1_5_3 // 콕스비례위험모형_Hazard Ratio _HR이 1보다 작으면 효과가 작은 것으로 간주함.

save age50_survivalanalysis_v5, replace 
save age50_survivalanalysis_v6_drop, replace // 20.09.22. 21:44


**★★★**근무형태 코딩 + 직종 코딩 + 고용형태 코딩 제거 **20.09.22.
stcox ib2.gender ib2.gender*surtime1 age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 ib2.occupation_1_re ib3.workplace_4 ib3.employment_1_re // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_12.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)



*****************************************************
*********20.09.22. correspondence analysis***********
****************************************************

tab occupation_1_re occupation_2_re, chi row 
tab workplace_1_re_r workplace_2_re_r, row
tab employment_1 employment_2, row


tab occupation_1_re occupation_2_re , chi2 cchi exp //after 1=관리자/전문가, 2=사무종사자 3-서비스및판매종사자 4=농림/조립/단순노무 5=군인,기타
ca occupation_1_re occupation_2_re 
cabiplot, origin //plotting


tab workplace_1_re_r workplace_2_re_r , chi2 cchi exp //after 1=대기업, 중견기업 3-중소기업, 4=공공기관, 5=사업체운영, 6=프리랜서/협회/단체
ca workplace_1_re_r workplace_2_re_r 
cabiplot, origin //plotting

tab employment_1_re employment_2_re , chi2 cchi exp //after 1=정규직 2=비정규직 3=자영업 
ca employment_1_re employment_2_re
cabiplot, origin //plotting


*****************************************************
*********21.01.15. description analysis ************
****************************************************

ttest surtime1, by(gender)
median surtime1, by(gender)
ranksum surtime1, by(gender)

oneway surtime1 age_r, t
ttest surtime1, by(location_re)
ttest surtime1, by(schooling_re_r)
ttest surtime1, by(marriage_dummy)
ttest surtime1, by(children_d)

oneway surtime1 occupation_1_re, t sc
oneway surtime1 workplace_4, t sc
oneway surtime1 employment_1_re, t
ttest surtime1, by(RA2_19)
oneway surtime1 prepare_re_re, t


tab occupation_1_re occupation_2_re, chi  cchi exp

	   
*************survival analysis***************

stset surtime3, failure(event3==1)
kdensity surtime3, kernel(gaussian)


stcox ib2.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  income_m_1_ln 퇴직전근로사업소득 income_before_ln 퇴직전 가계총소득
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA3_19 ib2.occupation_2_re ib3.workplace_2_re_r ib3.employment_2_re /// present psychological state + 1st job model에 효과없은 employment 제거 	
	ib6.prepare_re_re
outreg2 using stcox_15_surtime3.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


save age50_survivalanalysis_v8_210115, replace 


*************logistic analysis***************
logit event3 ib2.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  income_m_1_ln 퇴직전근로사업소득 income_before_ln 퇴직전 가계총소득
	lifesatis selfesteem healthsatis_1 ///
	age_1stend workmonth_1 i.RA3_19 ib2.occupation_2_re ib3.workplace_2_re_r ib3.employment_2_re /// present psychological state + 1st job model에 효과없은 employment 제거 	
	ib6.prepare_re_re
outreg2 using logit_16_surtime3.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)



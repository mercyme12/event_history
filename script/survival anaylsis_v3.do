*******
cd C:\Users\LORDSHIP\Dropbox\12.DATA\50\survival
cd C:\Users\MERCYME\Dropbox\12.DATA\50\survival

use age50, clear

*****기본적 변인*************
gen firstjobend = ym(A1_5_1,A1_5_2) // 주된일자리 퇴직년월
format firstjobend %tm 

gen secjobst = ym(A2_4_1,A2_4_2) // 퇴질후일자리 입직년월
format secjobst %tm 

gen secjobend = ym(A2_5_1,A2_5_2) // 퇴질후일자리 입직년월
format secjobend %tm 

gen surtime1= secjobst- firstjobend //재고용까지 소요 기간

gen surtime2= secjobend- secjobst //재취업 고용 기간

gen  gender  = SQ1
gen age = SQ2_3+1
gen location = SQ3

recode 1=1 2=0 3=0 4=0 5=0 6=0 7=0 8=0 9=0 10=0 11=0 12=0 13=0 14=0 ///
15=0 16=0 17=0 18=0 19=0 20=0 21=0 22=1 23=1 24=1 25=0, gen(location_re)

recode location 1=1 2=1 3=1 4=2 5=2 6=2 7=2 8=2 9=2 10=2 11=2 12=3 13=3 14=3 ///
15=4 16=4 17=4 18=4 19=4 20=4 21=4 22=5 23=5 24=5 25=5, gen(location_re_5)
//①종로구 ②중구 ③용산구 ④성동구 ⑤ 광진구 ⑥동대문구 ⑦중랑구
//⑧성북구 ⑨강북구 ⑩도봉구 ⑪노원구 ⑫은평구 ⑬서대문구 ⑭마포구
//⑮양천구 ⑯강서구 ⑰구로구 ⑱금천구 ⑲영등포구 ⑳동작구 ◯21 관악구 ◯22 서초구 ◯23 강남구 ◯24 송파구 ◯25 강동구

gen schooling=DQ1
recode schooling 1=1 2=2 3=3 4=3, gen(schooling_re)
recode schooling 1=1 2=1 3=2 4=2, gen(schooling_re_r)
recode schooling 1=1 2=1 3=2 4=3, gen(schooling_re_re)


*****첫번째 일경험 관련 변인*************
gen workmonth = B2_2  //퇴직전 총 근무 개월
gen workmonth_1= B2_1*12 + workmonth //퇴직전 총 근무개월 
recode workmonth_1 (1/119=1) (120/239=2) (240/359=3) (360/479=4), gen(workmonth_1_re)
gen workmonth_tl=B1_1*12 + B1_2 //생애 총 근무개월 

gen severancepay = B6 //퇴직금 유무

gen age_1stend = A1_5_3 -1 
recode age_1stend (min/29=1) (30/39=2) (40/49=3) (50/59=4) (60/max=5), gen(age_1stend_re)

gen industry_1 = A1_8  //주된일자리 산업
gen occupation_1= A1_13   // 주된일자리 직업
recode occupation_1 (1/2=1) (3=2) (4/5=3) (6/9=4) (10/11=4), gen(occupation_1_re) //after 1=관리자/전문가, 2=사무종사자 3-서비스및판매종사자 4=농림/조립/단순노무 5=군인,기타


gen workplace_1=A1_14   //주된일자리 근무형태
recode workplace_1 (1=1) (2=2) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_1_re)
recode workplace_1 (1/2=1) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_1_re_r)

gen employment_1=A1_15   //주된일자리 고용형태
recode employment_1 (1=1) (2=2) (3/4=3), gen(employment_1_re)
gen income_m_1=A1_17   //월 평균 수입 주된일자리
gen income_m_1_ln=ln(income_m_1) //퇴직 전 근로사업소득(부부)

recode surtime1 (-100/0=6)(1/11=1) (12/35=2) (36/59=3) (60/83=4) (84/438=5), gen(surtime1_re)

*****두번째 일경험 관련 변인*************
gen industry_2=A2_8   //주된일자리 산업
gen occupation_2=A2_13  // 주된일자리 직업
recode occupation_2 (1/2=1) (3=2) (4/5=3) (6/9=4) (10/11=5), gen(occupation_2_re)

gen age_2ndstart = A3_4_3 -1
recode age_2ndstart (min/29=1) (30/39=2) (40/49=3) (50/59=4) (60/max=5), gen(age_2ndstart_re)

gen workplace_2=A2_14  //주된일자리 근무형태
recode workplace_2 (1=1) (2=2) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_2_re)
recode workplace_2 (1/2=1) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_2_re_r)

gen employment_2=A2_15  //주된일자리 고용형태s
recode employment_2 (1=1) (2=2) (3/4=3), gen(employment_2_re)

gen income_m_2=A2_17   //월 평균 수입 두번째


**********added variable*********
gen job_before=SQ6_1 // 퇴직 전 일자리 개수
gen job_after=SQ6_3 // 퇴직 후 일자리 개수
gen activity_after=SQ6_4 // 퇴직 후 활동 없다 906 있다 104

gen lifesatis_1 = G1A_10 //생활만족도 퇴직 전
gen finansatis_1 =  G1A_1  // 주관적 경제 상태 만족도 전
gen healthsatis_1 =  G1A_2 // 주관적 건강상태 만족도 전
gen jobsatis_1 =  G1A_4 //전반적 일상태 만족도 전


gen lifesatis_2 = G1B_10 //생활만족도 퇴직 후
gen finansatis_2 =  G1B_1  // 주관적 경제 상태 만족도 후
gen healthsatis_2 =  G1B_2 // 주관적 건강상태 만족도 후
gen jobsatis_2 =  G1B_4 //전반적 일상태 만족도 후


gen lifesatis = G2 //현재 삶 만족도 10점 만점, 효과 있음 집단 4
gen status = G3 //본인이 인식하는 사다리 지위 10점 만점, 효과 없음
egen selfesteem = rowmean(G5_1  G5_2 G5_3 G5_4 G5_5 G5_6 G5_7 G5_8 G5_9 G5_10)

gen prepare =  B5_1
recode prepare 1=1 2=2 3=3 4=4 5=4 6=4 7=3 8=3 9=3 10=5 11=6 12=2 13=5 14=6, gen(prepare_re) //1=정보습득 2=인맥 
//3=자격즉, 교육훈련 4=알선, 상담, 방문 5=적극적 구직행동 6=하향조정 및 준비X
recode prepare_re 1=1 2=2 3=3 4=3 5=3, gen(prepare_re_re)
recode prepare_re 1=1 2=2 3=3 4=3 5=4, gen(prepare_re_re_re)


gen event =1 
count if surtime1 < 0  //=>40명 + 
tab surtime if surtime < 0
drop if surtime1 <0 
su surtime1, de

****workingyears****
gen working1year = A1_5_3-A1_4_3
gen working2year = A2_5_3-A2_4_3
gen working3year = A3_5_3-A3_4_3
gen working4year = A4_5_3-A4_4_3
//count if working1year > working2year ==  941


save age50_survivalanalysis_v4, replace 

*egen V = rowmean (v1 v2 v3)


******09.01***************
***추가변수 고민***
****************FINANCE********************
recode BA05 1=0 2=1 3=0 4=0, gen(marriage_dummy) //혼인=1 그외=0 // ① 미혼 ② 기혼(사실혼 포함) ③ 별거 및 이혼 ④ 사별
recode BA05 1=. 2=1 3=2 4=2, gen(marriage_dummy_3) //혼인=1 그외=0
tab marriage_dummy cluster5, chi row //
recode BA08 1=0 2=1 3=2 4=2, gen(children)
recode BA08 1=0 2=1 3=1 4=1, gen(children_d)


*** C3_2//현재 재정상태 만족도
gen finance_satis=C3_2 
gen finance_satis_ago=C3_1  //퇴직전 재정상태 만족도

*******근로소득********* C2B_1//현재 부부 근로사업소득
*gen workingincome=C2B_1 //현재 근로사업소득(부부)
gen workingincome_before=income_job_before_retire //퇴직 전 근로사업소득(부부)
gen workingincome_before_ln=ln(workingincome_before)
hist workingincome_before_ln
su workingincome_before, de

*******총 소득*********
gen income_before_ln = ln(income_before)
hist income_before_ln
su income_before, de


**주된 일자리 관련**  
gen income_m=MTA1_17  // 생애주된일자리 월 평균 소득

gen stage=A1_4_3 // 생애주된일자리 시작연령 평균
gen endage=A1_5_3 // 생애주된일자리 종료연령 평균
gen incomesatis=ATA1_18 // 생애주된일자리 소득만족도 평균(5)
gen incomesatis_r=MTA1_18 // 생애주된일자리 소득만족도 평균(100)

save age50_survivalanalysis_v6_added, replace 


********************************

A2_21 //퇴직 후 첫번째 일자리 활동여부임. 즉, 퇴직후 첫 일자리 생존기간의 censored data 확인 가능 예 802(지금도 일하는중)  아니오 208(그만두었음)


***********************************

twoway (line subj date, connect(L))(scatter subj date if censored==0), /// 
       ylabel(1 2 3 4) legend(order (2 "censored"))
	   
	   
*************survival analysis***************

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
stcox i.gender age i.location_re i.severancepay // basic model
outreg2 using stcox.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

stcox i.gender age i.location_re i.severancepay lifesatis status selfesteem //present psychological state _status, self-esteem 효과있음.
outreg2 using stcox_1.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


stcox i.gender age i.location_re i.severancepay lifesatis_1 finansatis_1 healthsatis_1 jobsatis_1 //1st psychological state _건강상태만 효과
stcox i.gender age i.location_re i.severancepay workmonth_1 ///
	i.occupation_1_re i.workplace_1_re_r i.employment_1 income_m_1 //1st job model _employment 효과없음, workplace도 거의 효과 없음(1개 빼고)
	
stcox i.gender age i.location_re i.severancepay lifesatis_2 finansatis_2 healthsatis_2 jobsatis_2 //2nd psychological state _ 효과없음
stcox i.gender age i.location_re i.severancepay /// 
	i.occupation_2_re i.workplace_2_re_r i.employment_2 income_m_2 //2nd job model

stcox i.gender age i.location_re i.severancepay lifesatis status selfesteem workmonth_1 ///
	i.occupation_1_re i.workplace_1_re_r i.employment_1 income_m_1 // present psychological state + 1st job model
	
stcox i.gender age_1stend_re i.location_re i.severancepay lifesatis status selfesteem workmonth_1 ///
	i.occupation_1_re i.workplace_1_re_r income_m_1 // present psychological state + 1st job model에 효과없은 employment 제거 
outreg2 using stcox_2.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

**09.03.**
stcox i.gender age_1stend_re i.b5.location_re_5 i.schooling_re i.marriage_dummy i.children ///
	finance_satis_ago workingincome_before_ln i.severancepay /// income_before_ln 
	lifesatis status selfesteem workmonth_1 RA2_19 ///RA2_19 경력연관성
	i.occupation_1_re i.workplace_1_re_r income_m_1 // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_4.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


**첫일자리 기준으로 변수를 변경하였음***(퇴직과 첫일자리 종료는 다른 것이라)
stcox i.gender age i.b5.location_re_5 i.schooling_re i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis i.severancepay /// income_before_ln 
	lifesatis selfesteem ///RA2_19 경력연관성
	stage endage age_2ndstart workmonth_1 RA2_19 i.occupation_1_re i.workplace_1_re_r // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_4.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

***첫일자리 기준으로 변수를 변경하였음***(퇴직과 첫일자리 종료는 다른 것이라) + endage와 두번째 시작 나이를 제거함. 
stcox i.gender age i.b5.location_re_5 i.schooling_re i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis i.severancepay /// income_before_ln 
	lifesatis selfesteem healthsatis_1 ///RA2_19 경력연관성
	stage workmonth_1 RA2_19 i.occupation_1_re i.workplace_1_re_r // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_5.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

**★**첫일자리 기준으로 변수를 변경하였음***(퇴직과 첫일자리 종료는 다른 것이라) + endage와 두번째 시작 나이를 제거함. + 가계 총소득 로그 + 학력 재코딩
stcox i.gender age i.b5.location_re_5 i.schooling_re i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis i.severancepay income_before_ln /// income_before_ln 
	lifesatis selfesteem healthsatis_1 ///RA2_19 경력연관성
	age_1stend workmonth_1 RA2_19 i.occupation_1_re i.workplace_1_re_r // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_8.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

recode employment_1 1=1 2=2 3=3 4=3, gen(employment_1_re)
recode workplace_1_re_r 1=1 3=3 4=5 5=4 6=5, gen(workplace_1_re_r_r)

stcox i.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis i.severancepay income_before_ln /// income_before_ln 
	lifesatis selfesteem healthsatis_1 ///RA2_19 경력연관성
	age_1stend workmonth_1 RA2_19 i.occupation_1_re i.workplace_1_re_r // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_7.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


**★★**근무형태 코딩 + 직종 코딩 + 고용형태 코딩
stcox i.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis i.severancepay income_before_ln ///  
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 RA2_19 i.occupation_1_re i.workplace_1_re_r_r // i.employment_1_re // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_9.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

**★★**근무형태 코딩 + 직종 코딩 + 고용형태 코딩 제거
stcox i.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis i.severancepay income_before_ln ///  
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 RA2_19 i.occupation_1_re i.workplace_4 i.employment_1_re, nohr // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_10.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

**★★★**근무형태 코딩 + 직종 코딩 + 고용형태 코딩 제거 **20.09.22.
stcox ib2.gender age i.location_re_5 i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 ib2.occupation_1_re ib3.workplace_4 ib3.employment_1_re // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_11.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

**★★★**근무형태 코딩 + 직종 코딩 + 고용형태 코딩 제거 **20.09.22.
stcox ib2.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 ib2.occupation_1_re ib3.workplace_4 ib3.employment_1_re // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_12.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

**★★★★★**근무형태 코딩 + 직종 코딩 + 고용형태 코딩 제거 **20.10.28. ** 변수추가: prepare 
stcox ib2.gender age i.location_re i.schooling_re_r i.marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  income_m_1_ln 퇴직전근로사업소득 income_before_ln 퇴직전 가계총소득
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 ib2.occupation_1_re ib3.workplace_4 ib3.employment_1_re /// present psychological state + 1st job model에 효과없은 employment 제거 	
	ib6.prepare_re_re
outreg2 using stcox_13.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


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


********************************
*********20.09.03. 추가분석*************
********************************


*****job sequence variable*************
gen firstjobst = ym(A1_4_1,A1_4_2) // 퇴질후일자리 입직년월
format firstjobst %tm 

*gen firstjobend = ym(A1_5_1,A1_5_2) // 주된일자리 퇴직년월
*format firstjobend %tm 

*gen secjobst = ym(A2_4_1,A2_4_2) // 퇴질후일자리 입직년월
*format secjobst %tm 

*gen secjobend = ym(A2_5_1,A2_5_2) // 퇴질후일자리 입직년월
*format secjobend %tm 

gen thirdjobst = ym(A3_4_1,A3_4_2) // 퇴질후일자리 입직년월
format thirdjobst %tm 

gen thirdjobend = ym(A3_5_1,A3_5_2) // 주된일자리 퇴직년월
format thirdjobend %tm 

gen fourthjobst = ym(A4_4_1,A4_4_2) // 퇴질후일자리 입직년월
format fourthjobst %tm 

gen fourthjobend = ym(A4_5_1,A4_5_2) // 주된일자리 퇴직년월
format fourthjobend %tm 

gen fifthjobst = ym(A5_4_1,A5_4_2) // 퇴질후일자리 입직년월
format fifthjobst %tm 

gen fifthjobend = ym(A5_5_1,A5_5_2) // 주된일자리 퇴직년월
format fifthjobend %tm 


***재직기간****

gen stay1= firstjobend-firstjobst //
gen stay2= secjobend-secjobst //
gen stay3= thirdjobend-thirdjobst //
gen stay4= fourthjobend-fourthjobst //
gen stay5= fifthjobend-fifthjobst //

count if stay1 < stay2
count if stay1 > stay2 // 950
tab ID if stay1 < stay2  //18명. 
drop if stay1 < stay2

save age50_survivalanalysis_v6_drop, replace 
 

tab ID if stay2 < stay3


order ID stay1 stay2 stay3 stay4 stay5 check
gen check = 1 if stay1 < stay2
sort check //
sort ID //ID 순번으로 

tab A1_4_3 if stay1 < stay2




********************************
*********20.09.17. 추가분석*************
********************************

stcox age ndrugtx i.treat i.site c.age#i.site, nohr
estimates store m1
stcox age ndrugtx i.treat i.site, nohr
lrtest . m1




*****************************************************
*********20.09.22. 대응분석-첫번째 일자리-두번째 일자리 연관성*************
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

*******
cd C:\Users\LORDSHIP\Dropbox\12.DATA\50\survival
cd C:\Users\MERCYME\Dropbox\12.DATA\50\survival

/use age50, clear



*****기본적 변인*************
gen firstjobst = ym(A1_4_1,A1_4_2) // 주된일자리 퇴직년월
format firstjobst %tm 


gen firstjobend = ym(A1_5_1,A1_5_2) // 주된일자리 퇴직년월
format firstjobend %tm 

gen secjobst = ym(A2_4_1,A2_4_2) // 퇴직후일자리 입직년월
format secjobst %tm 

gen secjobend = ym(A2_5_1,A2_5_2) // 퇴직후일자리 종료년월
format secjobend %tm 

gen thijobst = ym(A3_4_1,A3_4_2) // 퇴직후일자리 입직년월
format thijobst %tm 

gen surtime = firstjobend - firstjobst //1번째 일자리 고용기간

gen surtime1= secjobst- firstjobend //재구직까지 소요 기간

gen surtime2= secjobend- secjobst //2재취업 고용 기간

gen surtime3= thijobst - secjobend //재구직 소요 기간


gen  gender  = SQ1
gen age = SQ2_3+1
gen location = SQ3

recode location 1=1 2=0 3=0 4=0 5=0 6=0 7=0 8=0 9=0 10=0 11=0 12=0 13=0 14=0 ///
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
recode workplace_1 (1=1) (2=2) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_6)
recode workplace_1 (1/2=1) (3=2) (4=3) (5=4) (6/11=5), gen(workplace_5)
recode workplace_1 (1/2=1) (3=2) (4=3) (5=3) (6/11=4), gen(workplace_4)

gen employment_1=A1_15   //주된일자리 고용형태
recode employment_1 (1=1) (2=2) (3/4=3), gen(employment_3)
gen income_m_1=A1_17   //월 평균 수입 주된일자리
gen income_m_1_ln=ln(income_m_1) //퇴직 전 근로사업소득(부부)

recode surtime1 (-100/0=6)(1/11=1) (12/35=2) (36/59=3) (60/83=4) (84/438=5), gen(surtime1_re)

*****두번째 일경험 관련 변인*************
gen industry_2=A2_8   //주된일자리 산업
gen occupation_2=A2_13  // 주된일자리 직업
recode occupation_2 (1/2=1) (3=2) (4/5=3) (6/11=4), gen(occupation_2_re)

gen age_2ndstart = A3_4_3 -1
recode age_2ndstart (min/29=1) (30/39=2) (40/49=3) (50/59=4) (60/max=5), gen(age_2ndstart_re)

gen workplace_2=A2_14  //주된일자리 근무형태
recode workplace_2 (1=1) (2=2) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_2_re)
recode workplace_2 ((1/2=1) (3=2) (4=3) (5=3) (6/11=4), gen(workplace_2_4)
recode workplace_2 (1/2=1) (3=2) (4=3) (5=4) (6/11=5), gen(workplace_2_5)


gen employment_2=A2_15  //주된일자리 고용형태s
recode employment_2 (1=1) (2=2) (3/4=3), gen(employment_2_3)

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

recode age 40/54=1 55/64=2 65/70=3, gen(age_r)
recode age 46/49=1 50/54=2 55/59=3 60/64=4 65/70=5, gen(age_re)
recode age 50/54=1 55/60=2 60/64=3, gen(age_dummy)


****workingyears****
gen working1year = A1_5_3-A1_4_3
gen working2year = A2_5_3-A2_4_3
gen working3year = A3_5_3-A3_4_3
gen working4year = A4_5_3-A4_4_3
//count if working1year > working2year ==  941

*egen V = rowmean (v1 v2 v3)


******09.01***************
***추가변수 고민***
****************FINANCE********************
recode BA05 1=0 2=1 3=0 4=0, gen(marriage_dummy) //혼인=1 그외=0 // ① 미혼 ② 기혼(사실혼 포함) ③ 별거 및 이혼 ④ 사별
recode BA05 1=. 2=1 3=2 4=2, gen(marriage_dummy_3) //혼인=1 그외=0
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
gen workplace_4 =  workplace_1_re_r_r


save age50_survival_V2_210119, replace 


keep if BA02_1 ==2 //50+세대만 해보자 => 806
//JOB1 1 은퇴 34, 2 첫번째 일자리 재취업 772
//JOB2 첫일자리 후 쉽 44, 첫일자리 근무중 614, 두번째 일자리로 이동 114
//JOB3 두일자리 후 쉼 9, 두일자리 근무중 95, 세일자리로 이동 10

recode JOB1 1=0 2=1, gen(job1_dummy) 
save age50_survival_V2_210119_v1, replace // surtime1 음수 지우기 이전 버전임.

drop if surtime1 <0  // 재귀업 구직 소요기간(달)이 음수이면 다 제외 (35 obs deleted)
count if surtime < surtime2 //첫번째 일자리보다 두번째 일자리가 더 걸린 case 확인(11개이나 안지움)
order ID surtime surtime1 surtime2 surtime3 JOB1
order ID A1_5_3 A2_4_3 surtime1 JOB1 A2_1

**********21.01.19.  1.STCOX*******************
****************************************************************
****************************************************************
****************************************************************
stset surtime1, failure(job1_dummy==1)
stdes
sort ID
stsum
stvary
sts test gender, logrank
sts test schooling_re_r, logrank
sts list, by(age) at(5(5)40)

//최종~~~!!! 심리적 상태 이전으로 바꾸기
stcox ib2.gender age i.location_re i.schooling_re_r marriage_dummy i.children_d ///
    lifesatis_1 jobsatis_1 healthsatis_1 /// 
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  
	age_1stend workmonth_1 i.RA2_19 i.occupation_1_re i.workplace_5 ib3.employment_1_re ib6.prepare_re_re // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_V2_50plus_v4.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

//20.01.22.버전
stcox ib2.gender age i.location_re i.schooling_re_r marriage_dummy i.children_d ///
    lifesatis selfesteem healthsatis_1 /// 
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  
	age_1stend workmonth_1 i.RA2_19 i.occupation_1_re i.workplace_5 ib3.employment_1_re ib6.prepare_re_re // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_V2_50plus_v3.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

//원본
stcox ib2.gender age i.location_re_5 i.schooling_re_re  i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 ib2.occupation_1_re i.workplace_5 ib3.employment_1_re // present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_V2_50plus_v3.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

save age50_survival_V2_210119_v1_stcox_result1, replace // 21.01.19


list id rx bili time status rec if id==5 | id==18, nod noobs


************21.01.19.  2.MLOGIT********************
****************************************************************
****************************************************************
****************************************************************

drop if JOB1==1
//employment 1= 정규직, 2=비정규직, 3=자영업 최종~~~!!!
mlogit employment_2_3 ///
    ib2.gender age i.location_re i.schooling_re_r marriage_dummy i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 i.occupation_1_re i.workplace_5 ib3.employment_1_re ib6.prepare_re_re , rrr // 
outreg2 using mlogit_V2_50plus_v1.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)

save age50_survival_V2_210119_v1_mlogit_result1, replace // 21.01.19



//logit job1_dummy ib2.gender age i.location_re_5 i.schooling_re_re  i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///
	lifesatis  healthsatis_1 /// 
	workmonth_1 i.RA2_19 i.occupation_1_re i.workplace_4 // 
//outreg2 using logistic_V2_v1_.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)


*******21.01.19. (X)퇴직 후 첫일자리에서 두번쨰 일자리로************
****************************************************************
****************************************************************
****************************************************************

use age50_survival_V2_210119, clear

keep if BA02_1 ==2 //50+세대만 해보자 => 806

drop if JOB2==2 //JOB2*****
recode JOB2 1=0 3=1, gen(job2_dummy)
save age50_survival_V2_210119_v2, replace 

logit job2_dummy ib2.gender age i.schooling_re_re  i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay  ///  
	lifesatis  healthsatis_1 ///
	workmonth_1 i.RA3_19 ib2.occupation_2_re  ib3.employment_2_3 // 
outreg2 using logistic_V2_v1_.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05) // n=67이므로 분석이 어려워짐.



stcox ib2.gender age i.location_re_5 i.schooling_re_re  i.children_d ///
	income_m_1_ln incomesatis ib2.severancepay income_before_ln ///  
	lifesatis selfesteem healthsatis_1 /// 
	age_1stend workmonth_1 i.RA2_19 ib2.occupation_1_re ib3.workplace_4 ib3.employment_1_re prepare_re_re// present psychological state + 1st job model에 효과없은 employment 제거 	
outreg2 using stcox_11.doc, replace ctitle(model1) alpha(0.001, 0.01, 0.05)



*****************************************************
*********21.01.20. 은퇴/재취업 분포**********
****************************************************
use age50_survival_V2_210119_v1_stcox_result1, clear

tab  gender job1_dummy
//recode SQ2_3 50/54=1 55/59=2  60/64=3, gen(age_50plus)
tab  SQ2_3 job1_dummy //연령
tab  location_re job1_dummy
tab  schooling_re_r job1_dummy //1. 대학이상 0. 고졸이하
tab  marriage_dummy job1_dummy
tab  children_d job1_dummy
tab  occupation_1_re job1_dummy
tab  workplace_5 job1_dummy
tab  employment_1_re job1_dummy
tab  RA2_19 job1_dummy
tab  prepare_re_re job1_dummy






*****************************************************
*********21.01.20. 소요기간 차이 분석**********
****************************************************
use age50_survival_V2_210119_v1_stcox_result1, clear

ttest surtime1, by(gender)
//median surtime1, by(gender)
//ranksum surtime1, by(gender)

oneway surtime1 age_50plus, t
ttest surtime1, by(location_re)
ttest surtime1, by(schooling_re_r)
ttest surtime1, by(marriage_dummy)
ttest surtime1, by(children_d)
ttest surtime1, by(voluntary_d)


oneway surtime1 occupation_1_re, t sc
oneway surtime1 workplace_5, t sc
oneway surtime1 employment_1_re, t
ttest surtime1, by(RA2_19)
oneway surtime1 prepare_re_re, t


tab occupation_1_re occupation_2_re, chi  cchi exp




*****************************************************
*********21.01.20. 소요기간 차이 분석**********
****************************************************
use age50_survival_V2_210119_v1_stcox_result1, clear
stset

stset surtime1, failure(job1_dummy==1)
ltable surtime1 job1_dummy, by(gender) interval (12 24 36 48 60 72 84 96 156 216 276 396 ) failure 
ltable surtime1 job1_dummy, graph by(gender) overlay  

stdes
sort ID
stsum
stvary
sts test gender, logrank
sts test schooling_re_r, logrank
sts list, by(age) at(5(5)40)


//lpattern(solid dash dot, dash_dot, shortdash, shortdash_dot, longdash, longdash_dot blank)
sts graph, by(gender)  //카플란마이어방법_집단별
sts graph, by(marriage_dummy) 
sts graph, by(schooling_re_r) 
sts graph, by(severancepay) 
sts graph, by(occupation_1_re) 
sts graph, by(workplace_5) 
sts graph, by(RA2_19) 
sts graph, by(employment_1_re) 
sts graph, by(prepare_re_re)


********************21.01.22.***********************************
*****************교수님 회의 후 남자 샘플만 뽑아서 새롭게 분석*******************
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

********************21.01.22_1.survival*************************
****************************************************************
****************************************************************
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





*****************21.01.22_2.mlogit***************
***************************************************************
****************************************************************
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

//일자리 지속기간
//4대보험




***************By Jeong, S. J.*******************
*************************************************
***************[[Data cleaning]]*****************


use age50, clear

*****기본적 변인*************
gen firstjobend = ym(A1_5_1,A1_5_2) // finishing point of year, month of the main job
format firstjobend %tm 

gen secjobst = ym(A2_4_1,A2_4_2) // starting point year, month of the 1st bridging job
format secjobst %tm 

gen secjobend = ym(A2_5_1,A2_5_2) // finishing point year, month of the 1st bridging job 
format secjobend %tm 

gen thijobst = ym(A3_4_1,A3_4_2) //finishing point year, month of the 2nd bridging job 
format thijobst %tm 

gen surtime1= secjobst- firstjobend //time(months) spent for searching 1st bridging job

gen surtime2= secjobend- secjobst //period of re-employment

gen surtime3= thijobst - secjobend //time(months) spent for searching 1st bridging job


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


*****variables of the main job*************
gen workmonth = B2_2  //Period of employment before retiring the main job(year)
gen workmonth_1= B2_1*12 + workmonth //Period of employment before retiring the main job(months)
recode workmonth_1 (1/119=1) (120/239=2) (240/359=3) (360/479=4), gen(workmonth_1_re)
gen workmonth_tl=B1_1*12 + B1_2 //Period of employment of his/her life time

gen severancepay = B6 //a retiring allowance

gen age_1stend = A1_5_3 -1 
recode age_1stend (min/29=1) (30/39=2) (40/49=3) (50/59=4) (60/max=5), gen(age_1stend_re)

gen industry_1 = A1_8  //industry of the main job
gen occupation_1= A1_13   // occupation of the main job
recode occupation_1 (1/2=1) (3=2) (4/5=3) (6/9=4) (10/11=4), gen(occupation_1_re) //after 1=관리자/전문가, 2=사무종사자 3-서비스및판매종사자 4=농림/조립/단순노무 5=군인,기타


gen workplace_1=A1_14   //workplace of the main job
recode workplace_1 (1=1) (2=2) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_1_re)
recode workplace_1 (1/2=1) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_1_re_r)

gen employment_1=A1_15   //employment of the main job
recode employment_1 (1=1) (2=2) (3/4=3), gen(employment_1_re)
gen income_m_1=A1_17   //monthly working income of the main job
gen income_m_1_ln=ln(income_m_1) //working income(including partner)

recode surtime1 (-100/0=6)(1/11=1) (12/35=2) (36/59=3) (60/83=4) (84/438=5), gen(surtime1_re)

*****두번째 일경험 관련 변인*************
gen industry_2=A2_8   //industry
gen occupation_2=A2_13  // occupation
recode occupation_2 (1/2=1) (3=2) (4/5=3) (6/11=4), gen(occupation_2_re)

gen age_2ndstart = A3_4_3 -1
recode age_2ndstart (min/29=1) (30/39=2) (40/49=3) (50/59=4) (60/max=5), gen(age_2ndstart_re)

gen workplace_2=A2_14  //workaplce
recode workplace_2 (1=1) (2=2) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_2_re)
recode workplace_2 (1/2=1) (3=3) (4=4) (5=5) (6/8=6), gen(workplace_2_re_r)

gen employment_2=A2_15  //employment
recode employment_2 (1=1) (2=2) (3/4=3), gen(employment_2_re)

gen income_m_2=A2_17   //monthly working income 


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


***Variables added***
***FINANCE****
recode BA05 1=0 2=1 3=0 4=0, gen(marriage_dummy) //혼인=1 그외=0 // ① 미혼 ② 기혼(사실혼 포함) ③ 별거 및 이혼 ④ 사별
recode BA05 1=. 2=1 3=2 4=2, gen(marriage_dummy_3) //
tab marriage_dummy cluster5, chi row //
recode BA08 1=0 2=1 3=2 4=2, gen(children)
recode BA08 1=0 2=1 3=1 4=1, gen(children_d)

gen finance_satis=C3_2 //satisfaction of the work
gen finance_satis_ago=C3_1  //퇴직전 재정상태 만족도

*******working income********* C2B_1//현재 부부 근로사업소득
*gen workingincome=C2B_1 //현재 근로사업소득(부부)
gen workingincome_before=income_job_before_retire //퇴직 전 근로사업소득(부부)
gen workingincome_before_ln=ln(workingincome_before)
hist workingincome_before_ln
su workingincome_before, de

*******total income*********
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
	   
	
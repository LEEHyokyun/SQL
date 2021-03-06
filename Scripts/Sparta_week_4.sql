select * from orders o
where email like '%gmail.com'
or email like '%naver.com';

select * from users u 
left join point_users pu 
on pu.user_id = u.user_id
where pu.point_user_id is not null;

select enrolled_detail_id, seen_date, done_date, DATEDIFF(done_date , seen_date) 
/* DATEDIFF를 사용해서 하나의 필드로 나타낼 수 있다 */
from enrolleds_detail ed 
where done = true 
and seen = true 
and DATEDIFF(done_date , seen_date) > 0;

select enrolled_detail_id, seen_date, done_date, TIMESTAMPDIFF(SECOND, seen_date, done_date) 
/* 분단위 : MINUTE, 시단위 : HOUR */
from enrolleds_detail ed 
where done = true 
and seen = true 
and TIMESTAMPDIFF(SECOND, seen_date, done_date) > 0;

select enrolled_detail_id, CURDATE(), done_date, 
	DATEDIFF(CURDATE(), done_date)
from enrolleds_detail ed
where done = true
and seen = true

select enrolled_detail_id, ADDDATE(CURDATE(), 100), done_date, 
	DATEDIFF(ADDDATE(CURDATE(), 100), done_date)
from enrolleds_detail ed
where done = true
and seen = true

/*gorup by로 여러 필드를 범주화하기 개수세기 */
select ed.enrolled_id, ed.week, count(*) 
from enrolleds_detail ed 
group by ed.enrolled_id, ed .week

/*enrolled_id로 우선 정렬한 후, 그 안에서 week를 기준으로 한번 더 정렬하기 */
/*order by로 여러 데이터 정렬하기 */
select * from enrolleds_detail ed 
order by enrolled_id, week, current_order 

/* @를 기준으로 첫번째 문자열, 즉 앞 부분의 문자열만 쪼개고 싶을때 */
 select user_id, email, 
 	SUBSTRING_INDEX(email, '@', 1) 
 	/* 뒤에 있는 문자열은 -1로 기재한다 */
 from users

 /*필드명, 첫글자(1)부터 5글자(5)까지만 출력하고 싶다(띄어쓰기 포함)*/
select c.checkin_id, c.comment, 
	SUBSTRING(c.comment, 1, 5) 
from checkins c 

select order_no, payment_method, 
/*하나의 필드로 사용가능하고, 특정 필드의 case에 따라 경우를 나뉜다*/
	case payment_method 
	when 'kakaopay' then '카카오페이' 
	when 'CARD' then '카드' 
	else '기타' END as '결제수단' 
/*case문의 끝은 END, 해당 필드의 이름은 as로 명명*/
 from orders
 
 select pu.point_user_id, pu.point, 
 	case when pu.point > 10000 then '잘 하고 있어요!' 
 	else '조금 더 달려주세요!' END as '구분' 
 from point_users pu;
 
/*평균보다 높은 포인트를 가지고 있으면 잘하고있어요 출력하기*/
/*subquery 적용시*/
select pu.point_user_id, pu.point, 
case when pu.point > (select avg(pu2.point) from point_users pu2) then '잘하고 있어요!'
end as '구분'
from point_users pu;

/*subquery 미적용시*/
select pu.point_user_id, pu.point, 
case when pu.point > 5380 then '잘하고 있어요!'
end as '구분'
from point_users pu;

/*한 강의를 보기 시작한 시간과, 수강완료한 시간의 일자 차이가 가장 큰 순서대로 정렬하기 */
select ed.enrolled_detail_id, ed.seen_date, ed.done_date,
	DATEDIFF(ed.done_date, ed.seen_date) as diff
from enrolleds_detail ed 
where ed.seen = true
and ed.done = true
order by diff desc

/*이메일 도메인별 유저의 수 세어보기*/
select 
	SUBSTRING_INDEX(u.email, '@', -1), count(SUBSTRING_INDEX(u.email, '@', -1))
from users u 
group by SUBSTRING_INDEX(u.email, '@', -1)

select pu.point_user_id, pu.point,
	case when pu.point > 1000 then '잘하고 있어요!'
	else '조금 더 달려주세요!'
	end as '구분'
from point_users pu 

/*화이팅이 포함된 코멘트 출력*/
/*주차별로 화이팅이 몇개인지 */
select c.week, count(*) from checkins c
where c.comment like '%화이팅%'
group by c.week

/*수강등록정보별 전체 강의수와, 들은 강의의수 춮력해보기 */
select ed.enrolled_id, count(ed.enrolled_id),
	(select count(*) from enrolleds_detail ed2
	where ed2.done = TRUE
	and ed2.seen = TRUE 
	and ed2.enrolled_id = ed.enrolled_id) 
from enrolleds_detail ed
group by ed.enrolled_id 

/*
select * from enrolleds_detail ed
where ed.done = TRUE
and ed.seend = TRUE 
and ed.enrolled_id = ""
*/

/*수강등록정보별 전체 강의수와 들은 강의의수, 진도율 출력해보기 */
select ed.enrolled_id, count(ed.enrolled_id) as totla_lecture,
	(select count(*) from enrolleds_detail ed2
	where ed2.done = TRUE
	and ed2.seen = TRUE 
	and ed2.enrolled_id = ed.enrolled_id) as lecture_count,
	/*진도율*/
	(select count(*) from enrolleds_detail ed2
	where ed2.done = TRUE
	and ed2.seen = TRUE 
	and ed2.enrolled_id = ed.enrolled_id)/count(ed.enrolled_id) * 100 as rate
from enrolleds_detail ed
group by ed.enrolled_id 

/*숙제1. 유저 이름별 완료한 강의개수를 세어보고, 완료한 강의수가 많은 순서대로 정렬*/
/*출력필드 : user_id, name, email, 완료강의수 */
select u.user_id, u.name, u.email,
	(select count(*) from enrolleds_detail ed /*enrolled_id*, done*/
	where ed.done = TRUE
	and ed.enrolled_id = e.enrolled_id
	) as lecture_count
from enrolleds e /*user_id, enrolled_id(detail과 연결)*/
left join users u
on u.user_id = e.user_id
group by user_id, lecture_count
order by lecture_count desc

/*
select count(done) from enrolleds_detail ed /*enrolled_id*, done*/ 
/*
where ed.done = TRUE
group by enrolled_id 
order by count(done) desc
*/
/*
select u.user_id, u.name, u.email from users u /*user_id, name, email */


/*숙제2. 한 강의를 보기 시작한 시간과, 수강완료한 시간의 날짜의 차이가 큰 순서대로 유저정보 출력*/
/*user_id, name, email, 날짜차이 */
/*Subquery로 복잡하게 생각할 필요없이, left join으로 다 끌어온다음 한번에 일괄 정리하는 것도 방법*/
select u.user_id, u.name, u.email,
	DATEDIFF(ed.seen_date, ed.done_date) as max_datediff
from users u
left join enrolleds e
on e.user_id = u.user_id 
left join enrolleds_detail ed
on ed.enrolled_id = e.enrolled_id
where ed.done = true
order by max_datediff desc

/*done_date, seen_date, enrolled_id로 연결*/
/*
select * from enrolleds_detail 
*/

/*user_id와 연결*/
/*
select * from enrolleds e
*/ 
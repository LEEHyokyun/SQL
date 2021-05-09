select * from checkins /*이름과 연락처를 알아야 하는데 user_id 정보만 있는 상황!*/ 
left join users
on checkins.user_id = users.user_id 

select * from point_users
left join users 
on point_users.user_id = users.user_id

select * from users 
left join point_users
on users.user_id = point_users.user_id;

select * from users 
inner join point_users 
on users.user_id = point_users.user_id;

select * from orders o /* 성씨가 없는데, 성씨를 붙여보자 */
left join users u2 
on o.user_id = u2.user_id

select * from checkins
left join users
on checkins.user_id = users.user_id

select co.title, count(co.title) as checkin_count from checkins ci 
left join courses co 
on ci.course_id = co.course_id 
group by co.title;

/*과목별 오늘의 다짐 개수 세어보기 */
select co.title, count(co.title) as course_title from checkins ch /*1.다짐정보가 나타난 테이블 */
left join courses co /*2. 과목정보가 나타난 테이블 불러오기, course id별로 과목정보(title)이 기재되어있음 */
on ch.course_id = co.course_id /*checkins의 course id와 course의 course id를 연계시킨다 */
group by co.title /*course의 title을 범주화하기 떄문에, 경로와 필드명을 정확히 입력한다.*/

/*포인트를 많이 받은 순서대로 유저 데이터 정렬하기 */
select * from point_users pu 
left join users u 
on pu.user_id = u.user_id 
order by pu.point desc;

select u.name, count(u.name) as count_name from orders o 
left join users u 
on o.user_id = u.user_id 
where u.email like '%naver.com' 
group by u.name;

/*Subquery 사용하기 */
select * from users u
where u.user_id in (select o.user_id /*아래 조건을 만족하는 user_id로 출력해줄것*/
	from orders o /*users.user_id에 대한 공통조건은, orders table에서 */
	where o.payment_method = "kakaopay" /*결제방법이 카카오 페이인 user_id를 공통분모로 */
)

/*위 subquery문을 join으로 작성할때 */
select * from users u /*users table내 필드명을 일일이 모두 써줘야 한다*/
inner join orders o
on u.user_id = o.user_id
where o.payment_method = 'kakaopay' /*이것만 작성해도 관련된 모든 정보들(users, orders)이 출력된다*/

/*오늘의 다짐에 달린 좋아요 수와, 해당 유저가 평균적으로 받은 좋아요 수를 모두 나타내줄때*/
select c.checkin_id, c.user_id, c.likes, /*checkins table에서 선별적으로 나타나는 데이터에서도*/
	(select avg(c2.likes) from checkins c2 /*Subquery를 사용해서, 그 자체가 나타나는 데이터(필드값)이 될 수 있다 */
	where c2.user_id = c.user_id) as avg_like_users
from checkins c
	
select * from users u
where u.user_id in (select o.user_id from orders o
where o.payment_method = 'kakaopay')

select ch.checkin_id, ch.user_id, ch.likes,
	(select avg(likes) from checkins ch2
		where ch2.user_id = ch.user_id) as avg_likes 
from checkins ch 

/*위 select절에 사용된 subquery를 이해하기위해 아래 알고리즘을 참조할것*/
/*
select user_id, avg(likes) from checkins c 
where user_id = '4b8a10e6'
*/

/*select 절로 subquery가 사용되는데, 하나의 조건으로 이용될 경우 */
/*전체 유저가 가지는 포인트보다 많은 포인트를 가진 유저들만 선별해서 나타낼 경우*/
select * from point_users pu 
where pu.point > (select avg(pu2.point) from point_users pu2);

/*이씨 성을 가진 유저들의 평균 포인트보다 더 많은 포인트를 가지고 있는 유저들을 추출할 경우*/
select * from point_users pu 
where pu.point > /*1. 유저들 테이블에서 나타내고, 그 조건은 일단 포인트가 커야된다 */ 
	(select avg(pu2.point) 
	from point_users pu2 
	left join users u /*2. 위 유저 테이블에서는 성씨조건이 없기 때문에 일단 left join으로 연결한다 */
	on pu2.user_id = u.user_id /* left join on해서 user_id를 연결한다 =*/ 
	where u.name = "이**");

/*헷갈리면, 아래처럼 일단 문제를 부분화시킨후 서브쿼리를 넣던가, 값(평균포인트등)을 대입하던가 한다.*/

/* select avg(pu2.point) 
	from point_users pu2 
	left join users u /*2. 위 유저 테이블에서는 성씨조건이 없기 때문에 일단 left join으로 연결한다 */
/*	on pu2.user_id = u.user_id /* left join on해서 user_id를 연결한다 */ 
/*	where u.name = "이**" */

/* Select절에 들어가는 Subquery, checkins 테이블에 course_id별 평균 likes수 우측필드에 붙여보기*/
select checkin_id, course_id, user_id, likes, 
	(select avg(c2.likes) 
	from checkins c2 
	where c.course_id = c2.course_id) 
	from checkins c;
	
/*checkins 테이블에 과목명별 평균 like수 붙여보기 */
select checkin_id, c3.title, user_id, likes, 
	(select avg(c2.likes) from checkins c2 
	where c.course_id = c2.course_id) from checkins c 
/*과목명은 checkin 테이블에 없기 때문에, course 테이블을 가져와야 한다*/
/*그냥 가져오면 안되고, left join을 해줘야 한다*/
left join courses c3 on c.course_id = c3.course_id;
/*현재 나타난 테이블은 checkin이기 때문에, checkin 테이블을 기준으로 알고리즘 작성*/

/* checkin 테이블에 week별 최대 likes수 필드 우측에 붙여보기 */
select c1.week, c1.likes,
	(select max(c2.likes) from checkins c2
	where c2.likes = c1.likes) as max_likes
from checkins c1 

select o.payment_method, count(o.payment_method) from orders o 
left join users u
on o.user_id = u.user_id
where u.name = "김**"
group by o.payment_method 

/*is_regisered = false일때, 수강완료한 강의 중 가장 나중 강의의 current_order(=가장 높은 강의) 구해보기 */
select current_order, max(current_order) from enrolleds_detail ed 
left join enrolleds e2 
on ed.enrolled_id = e2.enrolled_id 
	where e2.is_registered = false
and ed.done = true

/*이씨 성을 가진 유저들의 평균 포이늩 + 1000점 보다 더 많은 포인트를 가진 데이터를 추출해보기 */
select * from point_users pu 
where pu.point > (select avg(pu2.point) from point_users pu2
left join users u
on pu2.user_id = u.user_id 
where u.name ="이**") + 1000;

/*
select avg(pu2.point) from point_users pu2
left join users u
on pu2.user_id = u.user_id 
where u.name ="이**"
*/

/*enrolled_id별 수강완료한 강의중, 가장 나중 강의의 curent_order 구해보기 */

select e.enrolled_id, e.user_id,
	(select max(ed.current_order) from enrolleds_detail ed 
	 where ed.done = true
	 and ed.enrolled_id = e.enrolled_id) as recent_current_order 
from enrolleds e; 

/*enrolled_id별 수강완료한 강의 개수 및 강의 개수는 내림차순으로 정렬*/
select enrolled_id, user_id,
	(select count(done) from enrolleds_detail e2
	where e2.done = true
	and e2.enrolled_id = e1.enrolled_id) as max_count
from enrolleds e1
order by max_count desc


/*
select enrolled_id, count(done) from enrolleds_detail e2
where done = true
group by e2.enrolled_id
order by count(done) desc
*/
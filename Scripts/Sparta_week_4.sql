select * from orders o
where email like '%gmail.com'
or email like '%naver.com';

select * from users u 
left join point_users pu 
on pu.user_id = u.user_id
where pu.point_user_id is not null;

select enrolled_detail_id, seen_date, done_date, DATEDIFF(done_date , seen_date) 
/* DATEDIFF�� ����ؼ� �ϳ��� �ʵ�� ��Ÿ�� �� �ִ� */
from enrolleds_detail ed 
where done = true 
and seen = true 
and DATEDIFF(done_date , seen_date) > 0;

select enrolled_detail_id, seen_date, done_date, TIMESTAMPDIFF(SECOND, seen_date, done_date) 
/* �д��� : MINUTE, �ô��� : HOUR */
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

/*gorup by�� ���� �ʵ带 ����ȭ�ϱ� �������� */
select ed.enrolled_id, ed.week, count(*) 
from enrolleds_detail ed 
group by ed.enrolled_id, ed .week

/*enrolled_id�� �켱 ������ ��, �� �ȿ��� week�� �������� �ѹ� �� �����ϱ� */
/*order by�� ���� ������ �����ϱ� */
select * from enrolleds_detail ed 
order by enrolled_id, week, current_order 

/* @�� �������� ù��° ���ڿ�, �� �� �κ��� ���ڿ��� �ɰ��� ������ */
 select user_id, email, 
 	SUBSTRING_INDEX(email, '@', 1) 
 	/* �ڿ� �ִ� ���ڿ��� -1�� �����Ѵ� */
 from users

 /*�ʵ��, ù����(1)���� 5����(5)������ ����ϰ� �ʹ�(���� ����)*/
select c.checkin_id, c.comment, 
	SUBSTRING(c.comment, 1, 5) 
from checkins c 

select order_no, payment_method, 
/*�ϳ��� �ʵ�� ��밡���ϰ�, Ư�� �ʵ��� case�� ���� ��츦 ������*/
	case payment_method 
	when 'kakaopay' then 'īī������' 
	when 'CARD' then 'ī��' 
	else '��Ÿ' END as '��������' 
/*case���� ���� END, �ش� �ʵ��� �̸��� as�� ���*/
 from orders
 
 select pu.point_user_id, pu.point, 
 	case when pu.point > 10000 then '�� �ϰ� �־��!' 
 	else '���� �� �޷��ּ���!' END as '����' 
 from point_users pu;
 
/*��պ��� ���� ����Ʈ�� ������ ������ ���ϰ��־�� ����ϱ�*/
/*subquery �����*/
select pu.point_user_id, pu.point, 
case when pu.point > (select avg(pu2.point) from point_users pu2) then '���ϰ� �־��!'
end as '����'
from point_users pu;

/*subquery �������*/
select pu.point_user_id, pu.point, 
case when pu.point > 5380 then '���ϰ� �־��!'
end as '����'
from point_users pu;

/*�� ���Ǹ� ���� ������ �ð���, �����Ϸ��� �ð��� ���� ���̰� ���� ū ������� �����ϱ� */
select ed.enrolled_detail_id, ed.seen_date, ed.done_date,
	DATEDIFF(ed.done_date, ed.seen_date) as diff
from enrolleds_detail ed 
where ed.seen = true
and ed.done = true
order by diff desc

/*�̸��� �����κ� ������ �� �����*/
select 
	SUBSTRING_INDEX(u.email, '@', -1), count(SUBSTRING_INDEX(u.email, '@', -1))
from users u 
group by SUBSTRING_INDEX(u.email, '@', -1)

select pu.point_user_id, pu.point,
	case when pu.point > 1000 then '���ϰ� �־��!'
	else '���� �� �޷��ּ���!'
	end as '����'
from point_users pu 

/*ȭ������ ���Ե� �ڸ�Ʈ ���*/
/*�������� ȭ������ ����� */
select c.week, count(*) from checkins c
where c.comment like '%ȭ����%'
group by c.week

/*������������� ��ü ���Ǽ���, ���� �����Ǽ� �����غ��� */
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

/*������������� ��ü ���Ǽ��� ���� �����Ǽ�, ������ ����غ��� */
select ed.enrolled_id, count(ed.enrolled_id) as totla_lecture,
	(select count(*) from enrolleds_detail ed2
	where ed2.done = TRUE
	and ed2.seen = TRUE 
	and ed2.enrolled_id = ed.enrolled_id) as lecture_count,
	/*������*/
	(select count(*) from enrolleds_detail ed2
	where ed2.done = TRUE
	and ed2.seen = TRUE 
	and ed2.enrolled_id = ed.enrolled_id)/count(ed.enrolled_id) * 100 as rate
from enrolleds_detail ed
group by ed.enrolled_id 

/*����1. ���� �̸��� �Ϸ��� ���ǰ����� �����, �Ϸ��� ���Ǽ��� ���� ������� ����*/
/*����ʵ� : user_id, name, email, �Ϸᰭ�Ǽ� */
select u.user_id, u.name, u.email,
	(select count(*) from enrolleds_detail ed /*enrolled_id*, done*/
	where ed.done = TRUE
	and ed.enrolled_id = e.enrolled_id
	) as lecture_count
from enrolleds e /*user_id, enrolled_id(detail�� ����)*/
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


/*����2. �� ���Ǹ� ���� ������ �ð���, �����Ϸ��� �ð��� ��¥�� ���̰� ū ������� �������� ���*/
/*user_id, name, email, ��¥���� */
/*Subquery�� �����ϰ� ������ �ʿ����, left join���� �� ����´��� �ѹ��� �ϰ� �����ϴ� �͵� ���*/
select u.user_id, u.name, u.email,
	DATEDIFF(ed.seen_date, ed.done_date) as max_datediff
from users u
left join enrolleds e
on e.user_id = u.user_id 
left join enrolleds_detail ed
on ed.enrolled_id = e.enrolled_id
where ed.done = true
order by max_datediff desc

/*done_date, seen_date, enrolled_id�� ����*/
/*
select * from enrolleds_detail 
*/

/*user_id�� ����*/
/*
select * from enrolleds e
*/ 
select * from checkins /*�̸��� ����ó�� �˾ƾ� �ϴµ� user_id ������ �ִ� ��Ȳ!*/ 
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

select * from orders o /* ������ ���µ�, ������ �ٿ����� */
left join users u2 
on o.user_id = u2.user_id

select * from checkins
left join users
on checkins.user_id = users.user_id

select co.title, count(co.title) as checkin_count from checkins ci 
left join courses co 
on ci.course_id = co.course_id 
group by co.title;

/*���� ������ ���� ���� ����� */
select co.title, count(co.title) as course_title from checkins ch /*1.���������� ��Ÿ�� ���̺� */
left join courses co /*2. ���������� ��Ÿ�� ���̺� �ҷ�����, course id���� ��������(title)�� ����Ǿ����� */
on ch.course_id = co.course_id /*checkins�� course id�� course�� course id�� �����Ų�� */
group by co.title /*course�� title�� ����ȭ�ϱ� ������, ��ο� �ʵ���� ��Ȯ�� �Է��Ѵ�.*/

/*����Ʈ�� ���� ���� ������� ���� ������ �����ϱ� */
select * from point_users pu 
left join users u 
on pu.user_id = u.user_id 
order by pu.point desc;

select u.name, count(u.name) as count_name from orders o 
left join users u 
on o.user_id = u.user_id 
where u.email like '%naver.com' 
group by u.name;

/*Subquery ����ϱ� */
select * from users u
where u.user_id in (select o.user_id /*�Ʒ� ������ �����ϴ� user_id�� ������ٰ�*/
	from orders o /*users.user_id�� ���� ����������, orders table���� */
	where o.payment_method = "kakaopay" /*��������� īī�� ������ user_id�� ����и�� */
)

/*�� subquery���� join���� �ۼ��Ҷ� */
select * from users u /*users table�� �ʵ���� ������ ��� ����� �Ѵ�*/
inner join orders o
on u.user_id = o.user_id
where o.payment_method = 'kakaopay' /*�̰͸� �ۼ��ص� ���õ� ��� ������(users, orders)�� ��µȴ�*/

/*������ ������ �޸� ���ƿ� ����, �ش� ������ ��������� ���� ���ƿ� ���� ��� ��Ÿ���ٶ�*/
select c.checkin_id, c.user_id, c.likes, /*checkins table���� ���������� ��Ÿ���� �����Ϳ�����*/
	(select avg(c2.likes) from checkins c2 /*Subquery�� ����ؼ�, �� ��ü�� ��Ÿ���� ������(�ʵ尪)�� �� �� �ִ� */
	where c2.user_id = c.user_id) as avg_like_users
from checkins c
	
select * from users u
where u.user_id in (select o.user_id from orders o
where o.payment_method = 'kakaopay')

select ch.checkin_id, ch.user_id, ch.likes,
	(select avg(likes) from checkins ch2
		where ch2.user_id = ch.user_id) as avg_likes 
from checkins ch 

/*�� select���� ���� subquery�� �����ϱ����� �Ʒ� �˰����� �����Ұ�*/
/*
select user_id, avg(likes) from checkins c 
where user_id = '4b8a10e6'
*/

/*select ���� subquery�� ���Ǵµ�, �ϳ��� �������� �̿�� ��� */
/*��ü ������ ������ ����Ʈ���� ���� ����Ʈ�� ���� �����鸸 �����ؼ� ��Ÿ�� ���*/
select * from point_users pu 
where pu.point > (select avg(pu2.point) from point_users pu2);

/*�̾� ���� ���� �������� ��� ����Ʈ���� �� ���� ����Ʈ�� ������ �ִ� �������� ������ ���*/
select * from point_users pu 
where pu.point > /*1. ������ ���̺��� ��Ÿ����, �� ������ �ϴ� ����Ʈ�� Ŀ�ߵȴ� */ 
	(select avg(pu2.point) 
	from point_users pu2 
	left join users u /*2. �� ���� ���̺����� ���������� ���� ������ �ϴ� left join���� �����Ѵ� */
	on pu2.user_id = u.user_id /* left join on�ؼ� user_id�� �����Ѵ� =*/ 
	where u.name = "��**");

/*�򰥸���, �Ʒ�ó�� �ϴ� ������ �κ�ȭ��Ų�� ���������� �ִ���, ��(�������Ʈ��)�� �����ϴ��� �Ѵ�.*/

/* select avg(pu2.point) 
	from point_users pu2 
	left join users u /*2. �� ���� ���̺����� ���������� ���� ������ �ϴ� left join���� �����Ѵ� */
/*	on pu2.user_id = u.user_id /* left join on�ؼ� user_id�� �����Ѵ� */ 
/*	where u.name = "��**" */

/* Select���� ���� Subquery, checkins ���̺� course_id�� ��� likes�� �����ʵ忡 �ٿ�����*/
select checkin_id, course_id, user_id, likes, 
	(select avg(c2.likes) 
	from checkins c2 
	where c.course_id = c2.course_id) 
	from checkins c;
	
/*checkins ���̺� ����� ��� like�� �ٿ����� */
select checkin_id, c3.title, user_id, likes, 
	(select avg(c2.likes) from checkins c2 
	where c.course_id = c2.course_id) from checkins c 
/*������� checkin ���̺� ���� ������, course ���̺��� �����;� �Ѵ�*/
/*�׳� �������� �ȵǰ�, left join�� ����� �Ѵ�*/
left join courses c3 on c.course_id = c3.course_id;
/*���� ��Ÿ�� ���̺��� checkin�̱� ������, checkin ���̺��� �������� �˰��� �ۼ�*/

/* checkin ���̺� week�� �ִ� likes�� �ʵ� ������ �ٿ����� */
select c1.week, c1.likes,
	(select max(c2.likes) from checkins c2
	where c2.likes = c1.likes) as max_likes
from checkins c1 

select o.payment_method, count(o.payment_method) from orders o 
left join users u
on o.user_id = u.user_id
where u.name = "��**"
group by o.payment_method 

/*is_regisered = false�϶�, �����Ϸ��� ���� �� ���� ���� ������ current_order(=���� ���� ����) ���غ��� */
select current_order, max(current_order) from enrolleds_detail ed 
left join enrolleds e2 
on ed.enrolled_id = e2.enrolled_id 
	where e2.is_registered = false
and ed.done = true

/*�̾� ���� ���� �������� ��� ���̈p + 1000�� ���� �� ���� ����Ʈ�� ���� �����͸� �����غ��� */
select * from point_users pu 
where pu.point > (select avg(pu2.point) from point_users pu2
left join users u
on pu2.user_id = u.user_id 
where u.name ="��**") + 1000;

/*
select avg(pu2.point) from point_users pu2
left join users u
on pu2.user_id = u.user_id 
where u.name ="��**"
*/

/*enrolled_id�� �����Ϸ��� ������, ���� ���� ������ curent_order ���غ��� */

select e.enrolled_id, e.user_id,
	(select max(ed.current_order) from enrolleds_detail ed 
	 where ed.done = true
	 and ed.enrolled_id = e.enrolled_id) as recent_current_order 
from enrolleds e; 

/*enrolled_id�� �����Ϸ��� ���� ���� �� ���� ������ ������������ ����*/
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
select count(*) from orders
where course_title = "������ ���չ�"
/*������ ���չ��� ������ ����� �ళ��(=�����) count =*/

select name, count(*) from users /* users table���� name / count(*) �ʵ带 �����ϰ� */
group by name /*�����ϵ�, ���� ������ �ʵ� �����ʹ� name, name �׸��� ����ȭ!! */
order by count(*) desc /*������������ �����Ͱ� �����ȴ� */

select name , count(*) from users 
group by name;

select name, count(*) from users
group by name;

select count(*) from users
where name = '��**' /*�ž� �������� ������ ��Ÿ����*/

select name, count(*) from users
group by name 

select * from checkins
limit 10

select week, count(*) from checkins
group by week;

select count(*) from checkins
where week = 3

select * from checkins 
where likes = 1

select week, max(likes) from checkins
group by week;

select week, avg(likes) from checkins 
group by week;

select name, count(*) from users 
group by name
order by count(*)


select name, count(*) from users 
group by name
order by count(*) desc

select * from checkins
order by likes desc

select payment_method , count(*) from orders 
where course_title = "������ ���չ�"
group by payment_method
order by count(*) desc

select payment_method, count(*) from orders
group by payment_method /*�����Ͱ� ����ȭ�Ǳ� �ϴµ�, ���������θ� ����ȭ�Ǿ� ��Ÿ���� */
 						/*����ȭ ����� ���ǰ� ���� �ʾ����Ƿ�, ����ȭ ����� �������ش� */

select * from users
order by email

select * from users
order by created_at desc

select payment_method , count(*) from orders
where course_title = "�۰��� ���չ�"
group by payment_method 

select * from orders as o
where o.course_title = "�۰��� ���չ�"

select name, count(*) as freq from users
group by name

select payment_method, count(*) from orders
where course_title = "�۰��� ���չ�"
and email like "%naver%"
group by payment_method 

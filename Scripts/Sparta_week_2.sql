select count(*) from orders
where course_title = "웹개발 종합반"
/*웹개발 종합반을 수강한 사람의 행개수(=사람수) count =*/

select name, count(*) from users /* users table에서 name / count(*) 필드를 생성하고 */
group by name /*생성하되, 지금 나오는 필드 데이터는 name, name 항목을 범주화!! */
order by count(*) desc /*내림차순으로 데이터가 정리된다 */

select name , count(*) from users 
group by name;

select name, count(*) from users
group by name;

select count(*) from users
where name = '신**' /*신씨 데이터의 개수를 나타내줌*/

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
where course_title = "웹개발 종합반"
group by payment_method
order by count(*) desc

select payment_method, count(*) from orders
group by payment_method /*데이터가 범주화되긴 하는데, 제한적으로만 범주화되어 나타난다 */
 						/*범주화 방법이 정의가 되지 않았으므로, 범주화 방법을 정의해준다 */

select * from users
order by email

select * from users
order by created_at desc

select payment_method , count(*) from orders
where course_title = "앱개발 종합반"
group by payment_method 

select * from orders as o
where o.course_title = "앱개발 종합반"

select name, count(*) as freq from users
group by name

select payment_method, count(*) from orders
where course_title = "앱개발 종합반"
and email like "%naver%"
group by payment_method 

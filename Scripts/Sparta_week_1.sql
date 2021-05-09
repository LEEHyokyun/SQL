select * from users
where email like 's%net'
and name = "이**"

show tables;
select email from users 
where name = "남**"

select * from users 
where email like '%gmail.com'
and created_at between '2020-07-12' and '2020-07-14'

show tables;

select * from orders;
where email like '%naver%'
and course_title = "웹개발 종합반"
and payment_method = "kakaopay"

select * from orders
where email like '%naver%'
and payment_method = "kakaopay"
and course_title = "웹개발 종합반"
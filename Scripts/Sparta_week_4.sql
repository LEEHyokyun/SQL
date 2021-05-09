select * from orders o
where email like '%gmail.com'
or email like '%naver.com';

select * from users u 
left join point_users pu 
on pu.user_id = u.user_id
where pu.point_user_id is not null;

select enrolled_detail_id, seen_date, done_date, DATEDIFF(done_date , seen_date) 
/* DATEDIFF¸¦ »ç¿ëÇØ¼­ ÇÏ³ªÀÇ ÇÊµå·Î ³ªÅ¸³¾ ¼ö ÀÖ´Ù */
from enrolleds_detail ed 
where done = true 
and seen = true 
and DATEDIFF(done_date , seen_date) > 0;

select enrolled_detail_id, seen_date, done_date, TIMESTAMPDIFF(SECOND, seen_date, done_date) 
/* ºĞ´ÜÀ§ : MINUTE, ½Ã´ÜÀ§ : HOUR */
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

/*gorup by·Î ¿©·¯ ÇÊµå¸¦ ¹üÁÖÈ­ÇÏ±â °³¼ö¼¼±â */
select ed.enrolled_id, ed.week, count(*) 
from enrolleds_detail ed 
group by ed.enrolled_id, ed .week

/*enrolled_id·Î ¿ì¼± Á¤·ÄÇÑ ÈÄ, ±× ¾È¿¡¼­ week¸¦ ±âÁØÀ¸·Î ÇÑ¹ø ´õ Á¤·ÄÇÏ±â */
/*order by·Î ¿©·¯ µ¥ÀÌÅÍ Á¤·ÄÇÏ±â */
select * from enrolleds_detail ed 
order by enrolled_id, week, current_order 

/* @¸¦ ±âÁØÀ¸·Î Ã¹¹øÂ° ¹®ÀÚ¿­, Áï ¾Õ ºÎºĞÀÇ ¹®ÀÚ¿­¸¸ ÂÉ°³°í ½ÍÀ»¶§ */
 select user_id, email, 
 	SUBSTRING_INDEX(email, '@', 1) 
 	/* µÚ¿¡ ÀÖ´Â ¹®ÀÚ¿­Àº -1·Î ±âÀçÇÑ´Ù */
 from users

 /*ÇÊµå¸í, Ã¹±ÛÀÚ(1)ºÎÅÍ 5±ÛÀÚ(5)±îÁö¸¸ Ãâ·ÂÇÏ°í ½Í´Ù(¶ç¾î¾²±â Æ÷ÇÔ)*/
select c.checkin_id, c.comment, 
	SUBSTRING(c.comment, 1, 5) 
from checkins c 

select order_no, payment_method, 
/*ÇÏ³ªÀÇ ÇÊµå·Î »ç¿ë°¡´ÉÇÏ°í, Æ¯Á¤ ÇÊµåÀÇ case¿¡ µû¶ó °æ¿ì¸¦ ³ª´¶´Ù*/
	case payment_method 
	when 'kakaopay' then 'Ä«Ä«¿ÀÆäÀÌ' 
	when 'CARD' then 'Ä«µå' 
	else '±âÅ¸' END as '°áÁ¦¼ö´Ü' 
/*case¹®ÀÇ ³¡Àº END, ÇØ´ç ÇÊµåÀÇ ÀÌ¸§Àº as·Î ¸í¸í*/
 from orders
 
 select pu.point_user_id, pu.point, 
 	case when pu.point > 10000 then 'Àß ÇÏ°í ÀÖ¾î¿ä!' 
 	else 'Á¶±İ ´õ ´Ş·ÁÁÖ¼¼¿ä!' END as '±¸ºĞ' 
 from point_users pu;
 
/*Æò±Õº¸´Ù ³ôÀº Æ÷ÀÎÆ®¸¦ °¡Áö°í ÀÖÀ¸¸é ÀßÇÏ°íÀÖ¾î¿ä Ãâ·ÂÇÏ±â*/
/*subquery Àû¿ë½Ã*/
select pu.point_user_id, pu.point, 
case when pu.point > (select avg(pu2.point) from point_users pu2) then 'ÀßÇÏ°í ÀÖ¾î¿ä!'
end as '±¸ºĞ'
from point_users pu;

/*subquery ¹ÌÀû¿ë½Ã*/
select pu.point_user_id, pu.point, 
case when pu.point > 5380 then 'ÀßÇÏ°í ÀÖ¾î¿ä!'
end as '±¸ºĞ'
from point_users pu;

/*ÇÑ °­ÀÇ¸¦ º¸±â ½ÃÀÛÇÑ ½Ã°£°ú, ¼ö°­¿Ï·áÇÑ ½Ã°£ÀÇ ÀÏÀÚ Â÷ÀÌ°¡ °¡Àå Å« ¼ø¼­´ë·Î Á¤·ÄÇÏ±â */
select ed.enrolled_detail_id, ed.seen_date, ed.done_date,
	DATEDIFF(ed.done_date, ed.seen_date) as diff
from enrolleds_detail ed 
where ed.seen = true
and ed.done = true
order by diff desc

/*ÀÌ¸ŞÀÏ µµ¸ŞÀÎº° À¯ÀúÀÇ ¼ö ¼¼¾îº¸±â*/
select 
	SUBSTRING_INDEX(u.email, '@', -1), count(SUBSTRING_INDEX(u.email, '@', -1))
from users u 
group by SUBSTRING_INDEX(u.email, '@', -1)

select pu.point_user_id, pu.point,
	case when pu.point > 1000 then 'ÀßÇÏ°í ÀÖ¾î¿ä!'
	else 'Á¶±İ ´õ ´Ş·ÁÁÖ¼¼¿ä!'
	end as '±¸ºĞ'
from point_users pu 

/*È­ÀÌÆÃÀÌ Æ÷ÇÔµÈ ÄÚ¸àÆ® Ãâ·Â*/
/*ÁÖÂ÷º°·Î È­ÀÌÆÃÀÌ ¸î°³ÀÎÁö */
select c.week, count(*) from checkins c
where c.comment like '%È­ÀÌÆÃ%'
group by c.week

/*¼ö°­µî·ÏÁ¤º¸º° ÀüÃ¼ °­ÀÇ¼ö¿Í, µéÀº °­ÀÇÀÇ¼ö ­‹·ÂÇØº¸±â */
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

/*¼ö°­µî·ÏÁ¤º¸º° ÀüÃ¼ °­ÀÇ¼ö¿Í µéÀº °­ÀÇÀÇ¼ö, ÁøµµÀ² Ãâ·ÂÇØº¸±â */
select ed.enrolled_id, count(ed.enrolled_id) as totla_lecture,
	(select count(*) from enrolleds_detail ed2
	where ed2.done = TRUE
	and ed2.seen = TRUE 
	and ed2.enrolled_id = ed.enrolled_id) as lecture_count,
	/*ÁøµµÀ²*/
	(select count(*) from enrolleds_detail ed2
	where ed2.done = TRUE
	and ed2.seen = TRUE 
	and ed2.enrolled_id = ed.enrolled_id)/count(ed.enrolled_id) * 100 as rate
from enrolleds_detail ed
group by ed.enrolled_id 

/*¼÷Á¦1. À¯Àú ÀÌ¸§º° ¿Ï·áÇÑ °­ÀÇ°³¼ö¸¦ ¼¼¾îº¸°í, ¿Ï·áÇÑ °­ÀÇ¼ö°¡ ¸¹Àº ¼ø¼­´ë·Î Á¤·Ä*/
/*Ãâ·ÂÇÊµå : user_id, name, email, ¿Ï·á°­ÀÇ¼ö */
select u.user_id, u.name, u.email,
	(select count(*) from enrolleds_detail ed /*enrolled_id*, done*/
	where ed.done = TRUE
	and ed.enrolled_id = e.enrolled_id
	) as lecture_count
from enrolleds e /*user_id, enrolled_id(detail°ú ¿¬°á)*/
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


/*¼÷Á¦2. ÇÑ °­ÀÇ¸¦ º¸±â ½ÃÀÛÇÑ ½Ã°£°ú, ¼ö°­¿Ï·áÇÑ ½Ã°£ÀÇ ³¯Â¥ÀÇ Â÷ÀÌ°¡ Å« ¼ø¼­´ë·Î À¯ÀúÁ¤º¸ Ãâ·Â*/
/*user_id, name, email, ³¯Â¥Â÷ÀÌ */
/*Subquery·Î º¹ÀâÇÏ°Ô »ı°¢ÇÒ ÇÊ¿ä¾øÀÌ, left joinÀ¸·Î ´Ù ²ø¾î¿Â´ÙÀ½ ÇÑ¹ø¿¡ ÀÏ°ı Á¤¸®ÇÏ´Â °Íµµ ¹æ¹ı*/
select u.user_id, u.name, u.email,
	DATEDIFF(ed.seen_date, ed.done_date) as max_datediff
from users u
left join enrolleds e
on e.user_id = u.user_id 
left join enrolleds_detail ed
on ed.enrolled_id = e.enrolled_id
where ed.done = true
order by max_datediff desc

/*done_date, seen_date, enrolled_id·Î ¿¬°á*/
/*
select * from enrolleds_detail 
*/

/*user_id¿Í ¿¬°á*/
/*
select * from enrolleds e
*/ 
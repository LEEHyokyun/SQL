create table student(
	number int,
	name varchar(30),
	age int,
	class int,
	height float
);

insert into student(number, name, age, class, height)
values(1, "½ºÅºÀÌ", 17, 1, 173.3)

insert into student(number, name, age, height)
values(2, "¸£ÅºÀÌ", 17, 173.3)


alter table student
add is_graduated boolean default false;

select * from student; 

alter table student 
drop number;

select * from student;

alter table student 
modify column name varchar(30) not null;

select * from student

alter table student 
add id int primary key auto_increment;

select * from student;

 update student 
 set age = 18
 where name = "¸£ÅºÀÌ";
 
select * from student

update student 
set age = age + 1

delete from student 
where name = "¸£ÅºÀÌ"

select * from student;

drop table student;

select * from student;
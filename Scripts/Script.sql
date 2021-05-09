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


select number, name, age, class, height from student;

select * from student where class is null;
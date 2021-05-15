select distinct name from student;

select count(*) from student;
select count(name) from student;

select min(height) from student;

select sum(height) from student;
select avg(height) from student;

INSERT INTO student(name, age, class, height)
VALUES ("호창이", 19, 2, 188.5);
INSERT INTO student(name, age, class, height)
VALUES ("상현이", 19, 2, 120.4);

select class, avg(height) from student group by class;
select class, avg(height) from student group by class having avg(height) > 140;

select * from student order by height;
select * from student order by height limit 3;

select id from class where name = "수학";

select student.id from student
inner join student_class on student.id = student_class.student_id
where (student_class.class_id = (select id from class where name = "수학"));

select student.id from student
inner join student_class on student.id = student_class.student_id
inner join class on class.id = student_class.class_id
where class.name = "수학";
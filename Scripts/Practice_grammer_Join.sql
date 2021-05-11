create table student (
	id int auto_increment primary key, #primary에 not null 옵션이 포함되어, not null은 기재안해줘도 됨
	name varchar(30) not null,
	age int not null,
	class int,
	height float
)

create table teacher (
	id int auto_increment primary key,
	name varchar(30) not null,
	age int not null,
	phone_number varchar(30)
)

create table class ( #teacher table과 1:N 관계로 외래키를 설정필요
					 #teacher tale이 부모 table이 된다. 
	id int auto_increment primary key,
	name varchar(30) not null,
	teacher_id int not null, #foreign key, 자식 테이블에서 부모 테이블로 관계맺을때 기준이 되는 key값
	foreign key (teacher_id) #어떤 필드값을 외래키로 설정할 것인가
	references teacher(id) #어떤 부모테이블, 어떤 필드에 해당 외래키 값을 연결할 것인가
)

insert into teacher(name, age, phone_number) #id는 auto 옵션으로 자동생성
	values ("조정식", 28, "010-1234-1234") 

insert into class(name, teacher_id)
	values ("체육", 1)
	
INSERT INTO teacher(name, age, phone_number)
VALUES("신승범", 42, "010-2933-3492");
INSERT INTO teacher(name, age, phone_number)
VALUES("한석원", 49, "010-3939-33939");
INSERT INTO class(name, teacher_id)
VALUES ("미술", 1);
INSERT INTO class(name, teacher_id)
VALUES ("음악", 1);
INSERT INTO class(name, teacher_id)
VALUES ("수학", 2);
INSERT INTO class(name, teacher_id)
VALUES ("영어", 3);
INSERT INTO class(name, teacher_id)
VALUES ("도덕", 3);

CREATE TABLE class_info(
class_id INT NOT NULL PRIMARY KEY,
description VARCHAR(30) NOT NULL,
midterm_date VARCHAR(30) NOT NULL
);

INSERT INTO class_info(class_id, description, midterm_date) VALUES(1, "체육 수업입니다", "4/14");
INSERT INTO class_info(class_id, description, midterm_date) VALUES(2, "미술 수업입니다", "4/15");
INSERT INTO class_info(class_id, description, midterm_date) VALUES(4, "수학 수업입니다", "4/16");
INSERT INTO class_info(class_id, description, midterm_date) VALUES(5, "도덕 수업입니다", "4/16");

select * from teacher;
select * from class;
select * from class_info;

#class의 id와 class_info의 class_id를 left join(첫번째필드를 기준으로 테이블 연결)
select * from class left join class_info on class.id = class_info.class_id;
select * from class inner join class_info on class.id = class_info.class_id;
select * from class right join class_info on class.id = class_info.class_id;

create table student_class(
	student_id int not null,
	class_id int not null,
	foreign key (student_id)
	references student(id),
	foreign key (class_id)
	references class(id)	
);

insert into student (name, age, class, height)
	values ("르탄이", 12, 1, 156);
insert into student (name, age, class, height)
	values ("르탄이", 12, 1, 156);
insert into student (name, age, class, height)
	values ("스판이", 12, 1, 172);
insert into student (name, age, class, height)
	values ("스탄이", 12, 1, 176);
	
insert into student_class (student_id, class_id)
	values (1, 1);
insert into student_class (student_id, class_id)
	values (1, 2);
insert into student_class (student_id, class_id)
	values (1, 3);
insert into student_class (student_id, class_id)
	values (2, 2);
insert into student_class (student_id, class_id)
	values (2, 3);
insert into student_class (student_id, class_id)
	values (2, 4);
	
select * from student_class

select * from student inner join student_class on student.id = student_class.student_id;

select * from student inner join student_class on student.id = student_class.student_id where id = 1;
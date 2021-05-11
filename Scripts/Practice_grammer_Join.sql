create table student (
	id int auto_increment primary key, #primary�� not null �ɼ��� ���ԵǾ�, not null�� ��������൵ ��
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

create table class ( #teacher table�� 1:N ����� �ܷ�Ű�� �����ʿ�
					 #teacher tale�� �θ� table�� �ȴ�. 
	id int auto_increment primary key,
	name varchar(30) not null,
	teacher_id int not null, #foreign key, �ڽ� ���̺��� �θ� ���̺�� ��������� ������ �Ǵ� key��
	foreign key (teacher_id) #� �ʵ尪�� �ܷ�Ű�� ������ ���ΰ�
	references teacher(id) #� �θ����̺�, � �ʵ忡 �ش� �ܷ�Ű ���� ������ ���ΰ�
)

insert into teacher(name, age, phone_number) #id�� auto �ɼ����� �ڵ�����
	values ("������", 28, "010-1234-1234") 

insert into class(name, teacher_id)
	values ("ü��", 1)
	
INSERT INTO teacher(name, age, phone_number)
VALUES("�Ž¹�", 42, "010-2933-3492");
INSERT INTO teacher(name, age, phone_number)
VALUES("�Ѽ���", 49, "010-3939-33939");
INSERT INTO class(name, teacher_id)
VALUES ("�̼�", 1);
INSERT INTO class(name, teacher_id)
VALUES ("����", 1);
INSERT INTO class(name, teacher_id)
VALUES ("����", 2);
INSERT INTO class(name, teacher_id)
VALUES ("����", 3);
INSERT INTO class(name, teacher_id)
VALUES ("����", 3);

CREATE TABLE class_info(
class_id INT NOT NULL PRIMARY KEY,
description VARCHAR(30) NOT NULL,
midterm_date VARCHAR(30) NOT NULL
);

INSERT INTO class_info(class_id, description, midterm_date) VALUES(1, "ü�� �����Դϴ�", "4/14");
INSERT INTO class_info(class_id, description, midterm_date) VALUES(2, "�̼� �����Դϴ�", "4/15");
INSERT INTO class_info(class_id, description, midterm_date) VALUES(4, "���� �����Դϴ�", "4/16");
INSERT INTO class_info(class_id, description, midterm_date) VALUES(5, "���� �����Դϴ�", "4/16");

select * from teacher;
select * from class;
select * from class_info;

#class�� id�� class_info�� class_id�� left join(ù��°�ʵ带 �������� ���̺� ����)
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
	values ("��ź��", 12, 1, 156);
insert into student (name, age, class, height)
	values ("��ź��", 12, 1, 156);
insert into student (name, age, class, height)
	values ("������", 12, 1, 172);
insert into student (name, age, class, height)
	values ("��ź��", 12, 1, 176);
	
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
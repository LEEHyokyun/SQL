set autocommit = 0;

start transaction;
	select * from student;
	update student set name = "����2" where id = 8;
	/*�� ���̿� COMMIT�� �ϸ� ����2�� UPDATE�� ������ ����ȴ�*/
	delete from student where id = 9;
	select * from student;
rollback;


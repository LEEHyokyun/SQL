set autocommit = 0;

start transaction;
	select * from student;
	update student set name = "서빈2" where id = 8;
	/*이 사이에 COMMIT을 하면 서빈2로 UPDATE한 내역은 저장된다*/
	delete from student where id = 9;
	select * from student;
rollback;


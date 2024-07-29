create database college;
use college; -- use the database 
create table student( sid int primary key, sname varchar(20) not null, address varchar(30),marks int);

#drop a database
drop database college; -- not executed

#drop a table
drop table student;  -- not executed

# to see the schema of the table
DESCRIBE student;


#insert into table
insert into student (sid,sname,address, marks) values(1,"abc","manglore",123);
insert into student values(2,"pqr","banglore",234); -- to insert like this have to give all the values correctly
insert into student (sid,sname,address, marks) values(3,"xyz","goa",876);
insert into student (sid,sname,address, marks) values(4,"rtu","delhi",453);
insert into student (sid,sname,address, marks) values(5,"abc","manglore",123);
insert into student (sid,sname,address) values(6,"ram","hydrabad");
insert into student (sid,sname,address, marks) values(7,"pqr","banglore",234);
insert into student (sid,sname,address, marks) values(8,"rrr","manglore",678);
insert into student (sid,sname,address, marks) values(9,"pqr","udupi",111);
insert into student (sid,sname,address, marks) values(10,"hari","mandya",905);

#to delete a row from table
delete from student where sid=2; -- not executed 

# alter table 
# rename the table stud into student_info
ALTER TABLE stud RENAME TO student_info; -- not executed

# add a column 
ALTER TABLE stud ADD dob DATE; -- not executed <we can also use the  ADD COLUMN>

# drop or delete a column
ALTER TABLE stud DROP COLUMN dob ; -- not executed 

# to change the  column name
ALTER TABLE stud RENAME COLUMN student_id TO id; -- not executed

# to change the  column datatype
ALTER TABLE student MODIFY sid VARCHAR(20); -- not executed

# basic sql query
SELECT * from student; -- select
SELECT `sname` from student; -- best practice

# distinct 
SELECT DISTINCT address FROM student; -- it will give the distinct or unique or all the different address in the table ignoreing the repeated one 
SELECT DISTINCT `address`, sname FROM student; -- give the unique address and name with respect to both of them
SELECT DISTINCT s.`address` AS Address , s.sname AS Name FROM student  s; -- can be use < student AS s > also

# where query
select sname , marks 
from student 
where sid=2;
 
# and
select sname  
from student 
where sid=2 AND marks= 234;

#or
select sname,sid
from student 
where marks= 234 or marks= 400;

#not
select sname , sid 
from student 
where NOT marks=234; -- o/p is 7 bcz 6 is null so it is not considered

# Aggriate function
select COUNT(sid) from student; -- count
 
select AVG(marks) from student; # average
 
select SUM(marks) from student; -- sum

#min 
SELECT sid, sname, marks 
FROM student
WHERE  marks=(select min(marks) from student);

#max
SELECT max(marks) from student; -- gives the max mark  or below
SELECT sid, sname
FROM student
WHERE  marks < (select max(marks) from student);

#extra 
SELECT sid, sname 
FROM student
WHERE marks > (SELECT AVG(marks) FROM student);

# group by
SELECT sname,COUNT(sname) 
FROM student
GROUP BY sname;

#having
SELECT sid, sname,marks 
FROM student
group by sid,sname,marks
having max(marks)>200;

 #oreder
select sid ,sname,marks
from student
order  by marks ASC;

#IS NULL
select sid ,sname,marks
from student
where marks IS NULL;

#IS NOT NULL
select sid ,sname,marks
from student
where marks IS NOT NULL;

#update
update student set sname="manu" where sid=7;

#In operator
select sid ,sname,marks
from student
where marks IN (234,123,456);

#between operator
select sid ,sname,marks
from student
where marks between 234 and 700;

#alias
select sid as student_id ,sname as student_name
from student; 

#like condition
select * from student where sname LIKE'r%'; -- display all the names that start from r
select * from student where sname LIKE'r' 'a' '_'; -- display all the names that start from  r a

#case operation
select CASE(address)
when 'banglore' then 'karnataka'
when 'hydrabad' then 'telangana'
else 'not decided'
END
from student;

# insert before trigger
create trigger added_mark
before insert
on student
for each row
set new.marks=new.marks+100;

insert into student (sid,sname,address, marks) values(11,"abi","mysore",756);
select * from student;

#insert-after trigger
/* create table final_marks(total_mark int); 
create trigger end_marks
after insert
on student
for each row
insert into final_marks values(new.marks);

insert into student (sid,sname,address, marks) values(12,"Deelip","Pune",300);
select * from final_marks;
*/

 # deop a trigger
 drop trigger end_marks;
 
 # display trigger in database
 SHOW TRIGGERS IN  college;

#display trigger in table
SHOW TRIGGERS LIKE 'student';

#drop the table
drop table  final_marks;

#addition of insert after trigger
create table final_marks (ID int ,Student_Name varchar(20),Address varchar(30),total_mark int); 
create trigger end_marks
after insert
on student
for each row
insert into final_marks values(new.sid,new.sname,new.address, new.marks);

insert into student (sid,sname,address, marks) values(13,"Utra","Maharastra",550);
select * from final_marks;

#joins

select * from student;


#seperate table for the joins
CREATE TABLE employee(eid int primary key, ename varchar(30), phone int, address varchar(30));
insert into employee(eid,ename,phone,address) values (1,"Abu",1234567,"manglore");
insert into employee(eid,ename,phone,address) values (2,"Ram",9876400,"banglore");
insert into employee(eid,ename,phone,address) values (3,"Hari",8945624,"goa");
insert into employee(eid,ename,phone,address) values (4,"Vinu",9874663,"delhi");
insert into employee(eid,ename,phone,address) values (5,"Guru",4657029,"haydrabad");

select * from employee;

CREATE TABLE project(pid int primary key, eid int, cid int, pname varchar(30) );
insert into project(pid,eid,cid,pname) values (111,1,12,"Project-1");
insert into project(pid,eid,cid,pname) values (222,2,22,"Project-2");
insert into project(pid,eid,cid,pname) values (333,3,32,"Project-3");
insert into project(pid,eid,cid,pname) values (444,3,52,"Project-4");
insert into project(pid,eid,cid,pname) values (555,5,62,"Project-5");
insert into project(pid,eid,cid,pname) values (666,8,42,"Project-6");
insert into project(pid,eid,cid,pname) values (777,7,82,"Project-7");
insert into project(pid,eid,cid,pname) values (888,9,92,"Project-8");

select * from project;

# inner join
select e.eid as EmployeeID , e.ename as EmployeeName, e.phone as PhoneNo , p.pid as ProjectId , p.pname as ProjectName
from employee as e
INNER JOIN project as p ON e.eid= p.eid;
#or
select * 
from employee
INNER JOIN project
ON employee.eid= project.eid; -- it will give the all the matching  value in both the table along with repeated value eg: eid

# left join or left outer join
select e.ename as EmployeeName, e.phone as PhoneNo , p.pid as ProjectId , p.pname as ProjectName
from employee as e
LEFT JOIN project as p ON e.eid= p.eid; -- since vinu has no value on project table (right table)but it display null value for project table details

# right join or right outer join 
select e.ename as EmployeeName, e.phone as PhoneNo , p.pid as ProjectId , p.pname as ProjectName
from employee as e
RIGHT JOIN project as p ON e.eid= p.eid;

#full join or full outer join   
# full join will not work in mysql workbench to get full join use UNION in b\n left and right join
select e.ename as EmployeeName, e.phone as PhoneNo , p.pid as ProjectId , p.pname as ProjectName
from employee as e
LEFT JOIN project as p ON e.eid= p.eid
UNION
select e.ename as EmployeeName, e.phone as PhoneNo , p.pid as ProjectId , p.pname as ProjectName
from employee as e 
RIGHT JOIN project as p ON e.eid= p.eid; -- it will give all the details

#natural join
select * 
from employee
NATURAL JOIN project; -- it doesn't give the repeated column

# many to many relation (with seperate example) 
/*  made the entire as comment 
CREATE TABLE stud (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES stud(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
select * from stud;
INSERT INTO stud (name) VALUES ('Alice'), ('Bob'), ('Charlie');
INSERT INTO courses (course_name) VALUES ('Math'), ('Science'), ('History');
INSERT INTO enrollments (student_id, course_id) VALUES
(1, 1), 
(2, 2), 
(1, 2), 
(3, 3),  
(1, 3);  

SELECT stud.name, courses.course_name
FROM stud
JOIN enrollments ON stud.student_id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.course_id;

*/

# sql built in func
select SQRT(16) *2 ;-- square root func. result is 8
select now() ; -- return the current date and time

#stored procedure
# without parameter
DELIMITER $$  -- used to take multiple statement inside the stored procedure
CREATE PROCEDURE ex() -- the procedure name should be written as getEmployeeDetails
BEGIN
    SELECT * FROM employee;
END$$
DELIMITER ; -- again go back to the single statement stored procedure

# to drop the procedure
drop procedure ex;

# to execute the stored  procedure
CALL ex(); -- syntax: CALL procedure_name();

# stored procedure with parameter
DELIMITER $$  
CREATE PROCEDURE example(IN EmpId INT)
BEGIN
    SELECT * FROM employee
    WHERE eid=EmpId;
END$$
DELIMITER ;

# calling the parameterized procedure
CALL example(2); -- have to give only one parameter

# multiple parameter
DELIMITER $$  
CREATE PROCEDURE example_m(IN EmpId INT, EmpName varchar(30) )
BEGIN
    SELECT * FROM employee
    WHERE eid=EmpId AND ename= EmpName;
END$$
DELIMITER ; 

call example_m(1,'ram'); -- display the empty list because no match is found
call example_m(2,'ram'); -- display the details

# output parameter
DELIMITER $$
CREATE PROCEDURE example_o(IN EmpId INT, OUT Count INT) 
BEGIN
    -- Set the value of the OUT parameter
    SET Count = (SELECT COUNT(*) FROM employee WHERE eid = EmpId);
END$$
DELIMITER ;

#to call the stored procedure
CALL example_o(1, @outputCount); -- @outputCount- is variable to store the value

# to get the output
SELECT @outputCount; -- display the value stored in @outputCount

# user defined function
# scalar function without parameter
DELIMITER $$
CREATE FUNCTION getTotalEmployees()
RETURNS INT
DETERMINISTIC -- DETERMINISTIC: This indicates that the function will return the same result whenever it is called with the same data. 
			-- Since the function only reads data and does not modify it, it can be declared deterministic
READS SQL DATA -- READS SQL DATA: This indicates that the function performs SQL operations that read data but do not modify it.
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM employee;
    RETURN total;
END$$
DELIMITER ;

# to execute the scalar func
SELECT getTotalEmployees();

# scalar func with parameter
DELIMITER $$
CREATE FUNCTION getEmployeeName(empId INT) 
RETURNS VARCHAR(30)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE result VARCHAR(30);
    SELECT ename INTO result 
    FROM employee 
    WHERE eid = empId
    LIMIT 1;  -- Ensure only one value is selected bcz scalar func return  only one value
    RETURN result;
END$$
DELIMITER ;

# to execute this 
SELECT getEmployeeName(1); -- 1 is the emp id 

# scalar example for string concatination with 2 parameter
DELIMITER $$
CREATE FUNCTION getExampleString(FName varchar(30), LName varchar(30)) 
RETURNS VARCHAR(30)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE result VARCHAR(30);
    SET result = CONCAT(FName, SPACE(2), LName);  -- to concartinate two string
    RETURN result;
END$$
DELIMITER ;

select getExampleString('abc','efg') as Full_Name;

#limit
select * from student limit 5;

#offset
select * from student limit 3 offset 5;

# note: we cant be able to alter the stored procedure or function in mysql



 



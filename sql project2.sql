# answer1
create database alumni;
use alumni;

# answer3
SELECT * FROM college_a_hs;
SELECT * FROM college_a_se;
SELECT * FROM college_a_sj;
SELECT * FROM college_b_sj;
SELECT * FROM college_b_se;
SELECT * FROM college_b_sj;

# answer6
select * from college_a_hs where EntranceExam is null;
create view College_A_HS_V as select * from college_a_hs where EntranceExam is not null;
select * from College_A_HS_V;

# answer 7
# no null values in this field
create view College_A_SE_V as select * from college_a_se;
select * from College_A_SE_V;


#answer 8
# no null values in this field
create view College_A_SJ_V as select * from college_a_sj;
select * from College_A_SJ_V;

# answer9
# no null values in this field
create view College_B_HS_V as select * from college_b_sj;
select * from College_B_HS_V;

# answer10
# no null values in this field
create view College_B_SE_V as select * from college_b_se;
select * from College_B_SE_V;

# answer 11
# no null values in this field
create view College_B_SJ_V as select * from college_b_sj;
select * from College_B_SJ_V;

# answer 12

select * from College_A_HS_V;
delimiter $$
create procedure getnamedata()
begin
     select RollNo,LastUpdate,lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName,Batch,Degree,PresentStatus,HSDegree,EntranceExam,Institute,Location from College_A_HS_V;
     select RollNo,LastUpdate,lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName,Batch,Degree,PresentStatus,Organization,Location from College_A_SE_V;
	 select RollNo,LastUpdate,lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName,Batch,Degree,PresentStatus,Organization,Designation,Location from College_A_SJ_V;
	 select RollNo,LastUpdate,lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName,Batch,Degree,PresentStatus,Organization,Designation,Location from College_B_HS_V;
	 select RollNo,LastUpdate,lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName,Batch,Degree,PresentStatus,Organization,Location from College_B_SE_V;
	 select RollNo,LastUpdate,lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName,Batch,Degree,PresentStatus,Organization,Designation,Location from College_B_SJ_V;

    end $$
delimiter $$
call getnamedata();


# answer 14 

delimiter $$
create procedure getname_A
(INOUT namesofa LONGTEXT
)
begin
     declare finished int default 0;
     declare earth VARCHAR(8000) DEFAULT "";
     declare namedetail
              cursor for 
					select name from college_a_hs_v
                    union all
                    select name from college_a_se_v
                    union all
                    select name from college_a_sj_v;
	 declare continue handler
              for not found set finished=1;
open namedetail;
getna:
loop
fetch namedetail into earth;
    if finished=1 then leave getna;
    end if ;
    set namesofa= concat(earth," : ",namesofa);
end loop
getna;
close namedetail;
end$$
delimiter ;
set @namesofa="";

call getname_A(@namesofa);
select @namesofa Names_of_college_A;

# answer 15

delimiter $$
create procedure getname_B
(INOUT namesofa LONGTEXT
)
begin
     declare finished int default 0;
     declare earth VARCHAR(8000) DEFAULT "";
     declare namedetail
              cursor for 
					select name from college_b_hs_v
                    union all
                    select name from college_b_se_v
                    union all
                    select name from college_b_sj_v;
	 declare continue handler
              for not found set finished=1;
open namedetail;
getna:
loop
fetch namedetail into earth;
    if finished=1 then leave getna;
    end if ;
    set namesofa= concat(earth," : ",namesofa);
end loop
getna;
close namedetail;
end$$
delimiter ;
set @namesofa="";

call getname_b(@namesofa);
select @namesofa Names_of_college_B;

#answer 16

SELECT "HigherStudies" PresentStatus,(SELECT COUNT(*) FROM college_a_hs)/
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_hs)/
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100
College_B_Percentage
UNION
SELECT "Self Employed" PresentStatus,(SELECT COUNT(*) FROM college_a_se)/
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_se)/
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100
College_B_Percentage
UNION
SELECT "Service Job" PresentStatus,(SELECT COUNT(*) FROM college_a_sj)/
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_sj)/
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100
College_B_Percentage;




























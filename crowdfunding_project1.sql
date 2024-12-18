create database crowdfunding;
use crowdfunding;

select*from category;
select*from category where name="music";
select*from calendar;
select*from location;
select*from projects;
select*from creator1;



select count(id) from category;
select count(date) from calendar;
select count(ID) from location;
select count(ProjectID) from projects;
select count(id)from creator1;


SELECT from_unixtime(created_at) from projects;


select* from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 inner join category on
p1.category_id = category.id inner join location on p1.location_id = location.id  ;


select count(projectid) from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1;


select * from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1;











--  Total Projects By Outcomes --

select state as Outcomes,concat(round(count(name)/1000,2)," K") as "Number Of projects" from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 group by state;





-- Total Projects By Locations --
select country as location,concat(round(count(name)/1000,2)," K") as "Number Of projects" from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 group by location;






-- Total  projects by category --

select c1.name as category,concat(round(count(c1.name)/1000,2)," K") as "Number of Projects"  from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 inner join category c1 on
p1.category_id = c1.id group by category order by count(c1.name) desc ;




-- Total projects by Year Quarter and Month --

select year(created_at) `year` ,concat("Q",quarter(created_at)) `Quarter`, monthname(created_at) `month`,concat(round(count(name)/1000,3)," K") `Number Of Projects`
from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1
group by `year`,`Quarter`,`month`order by `year`,`Quarter`,`month` ;





-- Amount Raised & No of Backers For successful Projects --

select concat(round(sum(usd_pledged)/1000000000,2)," B") "amount Raised",concat(round(sum(backers_count)/1000000,2)," M") "Numbers Of Backers" from(select projectid,state,name,country,creator_id,location_id,category_id,
date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,
date(from_unixtime(successful_at)) successful_at,date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 where state ="successful";





-- Average Number Of Days For Successful Projects --

select avg(datediff(successful_at,created_at)) "Average No Of Days For Successful Projects" from(select projectid,state,name,country,creator_id,location_id,category_id,
date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,
date(from_unixtime(successful_at)) successful_at,date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 where state ="successful";



-- Top Successful Projects by No Of Backers --

select name `Top projects`,sum(backers_count) `Number Of Backers` from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 where state ="Successful" group by `Top projects` order by `Number Of Backers`desc ;
;


-- Top successful Projects by Amount Raised --

select name `Top projects`,sum(Usd_pledged) `Amount Raised` from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 where state ="Successful" group by `Top projects` order by `Amount Raised` desc;
;

-- Percentage of Successful Projects overall --

select concat(round(count(name)/(select count(name) from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1)*100,2),"%") as "Overall % Of Successful projects" from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 where state="successful";

select count(name) from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1;



-- Percentage of Successful Projects  by Category --

select c1.name `category`,concat(round(count(p1.name)/(select count(name) from(select projectid,state,name,country,creator_id,location_id,category_id,
date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) 
state_changed_at,date(from_unixtime(successful_at)) successful_at,date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate 
as "goal in usd",backers_count from projects) p1 where state="successful")*100,2),"%") `% Of SuccessfulProjects` from(select projectid,state,name,country,creator_id,location_id,
category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at))
state_changed_at,date(from_unixtime(successful_at)) successful_at,date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as 
"goal in usd",backers_count from projects) p1 inner join category c1 on p1.category_id = c1.id where state = "successful" group by `category` order by `% Of SuccessfulProjects` 
desc;





select count(name) from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 where state="successful";


-- Percentage of Successful Projects by Year , Month etc --

select year(created_at) `Year`,monthname(created_at) `month`,concat(round(count(name)/(select count(name) from(select projectid,state,name,country,creator_id,location_id,
category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) 
state_changed_at,date(from_unixtime(successful_at)) successful_at,date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as
 "goal in usd",backers_count from projects) p1 where state="successful")*100,2),"%") `% Of Successful Projects`from(select projectid,state,name,country,creator_id,location_id,
 category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at))
 state_changed_at,date(from_unixtime(successful_at)) successful_at,date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as 
 "goal in usd",backers_count from projects) p1 where state="successful" group by `year`,`month` order by `year`,`month` ;
 
 
 
--   Percentage of Successful projects by Goal Range --
select 
case
 when `goal in usd` >=0 and `goal in usd` <= 500000 then "0 - 500000"
 when `goal in usd` >500000 and `goal in usd` <= 1000000 then "500000 - 1000000" 
 when `goal in usd` >1000000 and `goal in usd` <= 1500000 then "1000000 - 1500000"
 when `goal in usd` >1500000 and `goal in usd` <= 2000000 then "1500000 - 2000000"
 when `goal in usd` >2000000 and `goal in usd` <= 2500000 then "2000000 - 2500000"
 end `Goal Range`,
 concat(Round(count( `goal in usd`) /(select count(name) from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,
 date(from_unixtime(deadline)) deadline,date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) 
 successful_at,date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as "goal in usd",backers_count from projects) p1 where 
 state="successful")*100,2),"%") "% Of Successful Projects"
 from(select projectid,state,name,country,creator_id,location_id,category_id,date(from_unixtime(created_at)) created_at,date(from_unixtime(deadline)) deadline,
date(from_unixtime(updated_at)) updated_at,date(from_unixtime(state_changed_at)) state_changed_at,date(from_unixtime(successful_at)) successful_at,
date(from_unixtime(launched_at)) launched_at,goal,pledged,usd_pledged,static_usd_rate,goal*static_usd_rate as `goal in usd`,backers_count from projects) p1
where state="successful" group by `Goal Range`;











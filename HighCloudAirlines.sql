# Q.A Year
select `year` from `maindata`;
# Q.B Month_Number
select `Month (#)` from `maindata`;
select * from 	`maindata`;
# Q.c MOnth Name
alter table  `maindata` add `Month Name` varchar(10);
update `maindata` set `Month Name`= MONTHNAME(STR_TO_DATE(CONCAT('2024-', `Month (#)`, '-01'), '%Y-%m-%d'));
select * from `maindata`;

#Q.D Quater
alter table `maindata` add `Quarter` int after `Month (#)`;
update `maindata` set `Quarter`=quarter( STR_TO_DATE(CONCAT('2024-', `Month (#)`, '-01'), '%Y-%m-%d')) ;
select * from `maindata`;
#Q.E Year-month
select date_format( str_to_date(concat(`Year`,'-',`Month (#)`,'-01'),'%Y-%m-%d'),'%Y-%b') as YearMonth from `maindata`;
 alter table `maindata` add `Year Month`  varchar(10) after `Quarter`;
 select * from `maindata`;
 update `maindata` set `year month` =date_format( str_to_date(concat(`Year`,'-',`Month (#)`,'-01'),'%Y-%m-%d'),'%Y-%b');
 #Q.F  Weekday Number
 select weekday(`Day`) from `maindata`;
 select   `day`, weekday(str_to_date(concat('2021-','09-',`Day`),'%Y-%m-%d'))  as `weekday number` from `maindata`;
 alter table `maindata`add  `Weekday Number` int after`day` ;
 update `maindata`  set `Weekday Number`= weekday(str_to_date(concat('2021-','01-',`Day`),'%Y-%m-%d'));
 alter table `maindata` drop `Weekday Number`;
select * from `maindata`;
 #Q.G Weekday Name 
 select date_format(str_to_date(concat('2021-01-',`Weekday Number`),'%Y-%m-%d'),'%W')  from `maindata`;
 alter table `maindata` add column `Weekday Name` varchar(20) after `Weekday Number`;
 update `maindata` set `Weekday Name`= date_format(str_to_date(concat('2021-01-',`Weekday Number`+1),'%Y-%m-%d'),'%W')
 where `Weekday Number` between 0 and 31;
 select * from `maindata`;
 alter table `maindata` drop `Weekday Name`;
 #Q H Financial month
 
 select(`Month (#)`) as `Calnder Month`, `Month Name`,
 mod((`Month (#)`) +8,12)+1 as `Finacinal month`
from `maindata`;
alter table `maindata` add column `Finacinal Month` varchar(10) after `Month Name`;
update `maindata` set `Finacinal month` =  mod((`Month (#)`) +8,12)+1;
select * from `maindata`;
alter table `maindata` drop `Finacinal Quater`;
alter table `maindata` drop `Finacinal Month`;
select `Month (#)`,
concat("Q" ,mod(floor((`Month (#)` +8)/3),4)+1)from `maindata`;
alter table `maindata` add column `Finacinal Quater` varchar(10) after `Finacinal Month`;
update `maindata` set `Finacinal Quater` =concat("Q", mod(floor((`Month (#)`+8)/3),4)+1);
select * from `maindata`;
select count(*) from `maindata`;
select * from `maindata`;
#-----------------### 3. Find the load Factor percentage on a Carrier Name basis --------------------------
select  * from `maindata`;
select `Carrier Name` ,round((sum(`# Transported Passengers`) / sum(`# Available Seats`))*100,2) as `Load Factor` from `maindata`
where `# Available Seats` > 0
group by 
`Carrier Name`
order by `Load Factor` desc;
#---------# 4. Identify Top 10 Carrier Names based passengers preference ----------------
select 	`carrier Name`,sum(`# Transported Passengers` )as Total_passangers from `maindata`
group by  `carrier Name` 
order by  Total_passangers desc
limit 10;
# %5 Display top Routes ( from-to City) based on Number of Flights 
select `From - To City`,count(`%Airline ID`) as `Number of flights`  from `maindata`
group by `From - To City`
order by  `Number of flights` desc;
##### Question 6#######
#--------- Identify the how much load factor is occupied on Weekend vs Weekdays.

select`Weekday Name`,( case when `Weekday Name`="Sunday"  then "Weekend" when `Weekday Name`="Saturday" then "Weekend"
else "Weekday" end) as `Weekday Vs Weekend` from `maindata`;
alter table `maindata` add  column  `Weekday Vs Weekend` varchar(20)  after `Weekday Name`;
update `maindata` set `Weekday Vs Weekend`= (case when `Weekday Name`="Sunday"  then "Weekend" when `Weekday Name`="Saturday" then "Weekend"
else "Weekday" end) ;
select round((`# Transported Passengers`/`# Available Seats`),2) As `Load FActor` from `maindata`;
alter table `maindata` add column `Load Factor` float;
update `maindata` set `Load Factor`= (`# Transported Passengers`/`# Available Seats`)
where `# Available Seats`>0 ;
select * from `maindata`;
#_________________############
select round(sum(`Load Factor`),2) as "Weekend",(select  round(sum(`Load Factor`),2) from `maindata`
where `Weekday vs Weekend`="Weekday") as Weekday from `maindata`
where `Weekday Vs Weekend`="Weekend";
#  7 Identify number of flights based on Distance group
select * from `maindata`;
select `carrier Name`  ,`%Distance Group ID` as  `Distance Group`,count(`%Airline ID`)  as number_of_flights
from `maindata`
group by  `%Distance Group ID`,`carrier Name`
order by number_of_flights desc; 


######
#------ Find the load Factor percentage on a yearly , Quarterly , Monthly basis ( Transported passengers / Available seats) #

select `Month (#)`,concat(round((sum(`# Transported Passengers`) / sum(`# Available Seats`)*100),2) ,'%')as `Load Factor` from `maindata`
where `# Available Seats` > 0
group by `Month (#)`
order by `Month (#)` asc;
select * from `maindata`;
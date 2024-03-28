select * from project.data1;

select * from project.data2;

select count(*) from project.data1;

-- see the district from two states 

select * from project.data1 where State in ('Tamil Nadu' , 'Kerala')

select * from project.data2 where state in ('Maharashtra' , 'Uttar Pradesh')

select avg(growth) from project.data1;

-- avg growth in tamil nadu

select avg(growth) from project.data1 where state in ('Tamil Nadu')

-- avg growth in all district

select state,
avg(growth)*100 avg_growth
from project.data1
group by state;

-- avg sex ratio 

select state,
round(avg(sex_ratio),0)
avg_growth 
from project.data1 
group by state;

-- order by function 

select state,
round(avg(sex_ratio),0) avg_sex_ratio from project.data1 
group by state order by avg_sex_ratio asc;

-- avg literacy rate 

select state,
round(avg(literacy),0) 
avg_literacy_rate
 from project.data1 
 group by state
 order by avg_literacy_rate desc;

-- top 3 states highest growth ratio 

select state,
avg(growth)*100 avg_growth from project.data1 
group by state 
order by avg_growth desc limit 3;


-- bottom 3 lowest growth ratio

select state,
avg(growth)*100 avg_growth from project.data1
group by state 
order by avg_growth asc limit 3;

-- list the district from starting letter and ending letter 

select distinct state from project.data1 where lower(state) like 'a%' or lower(state) like 'b%'

select distinct state from project.data1 where lower(state) like 'a%' and lower(state) like '%m'

select distinct state from project.data1 where lower(state) like 'b%' and lower(state) like 'e%'


-- top 3 district from each state by using rank 

select district,state,literacy,rank() over(partition by state order by literacy desc) rnk from project.data1

select district,state,population,rank() over(partition by area_km2 order by population desc) rnk from project.data2 
order by rnk desc;

select * from project.data2;

-- joining both tables 

select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from project.data1 a inner join project.data2 b on a.district=b.district

-- finding number of males and females

select d.state,
sum(d.males) total_males,
sum(d.females) total_females from 
(select c.district,c.state,
round(c.population/(c.sex_ratio+1),0) males,
 round(c.population/(c.sex_ratio)/(c.sex_ratio+1),0) females from
(select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from project.data1 a inner join project.data2 b on a.district=b.district ) c) d
group by d.state

-- Total Literacy

select c.state,
sum(literate_people) total_literate_population,
sum(illiterate_people) total_illiterate_pop from
(select d.district,d.state,
d.literacy_ratio*d.population literate_people,(1-d.literacy_ratio)* d.population illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population from project.data1 a inner join project.data2 b on a.district=b.district) d) c
group by c.state














create table orders_data
(
order_id int,
customer_id int,
product_id int,
);

insert into orders_data VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

select * from orders_data
select * from products




select * from orders_data
select * from orders_data


with cte1 as (
select o1.order_id,
		o1.product_id as product1,
		o2.product_id as product2
		from orders_data as o1
		inner join orders_data as o2
		on o1.order_id=o2.order_id
		where o1.product_id<o2.product_id
)
select p1.name+' '+p2.name as pair,
count(*) as purchase_freq
from cte1 as c1
inner join products as p1 on c1.product1=p1.id
inner join products as p2 on c1.product2=p2.id
group by p1.name+' '+p2.name


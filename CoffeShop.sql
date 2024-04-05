create database CoffeShop;
use CoffeShop;

create table Coffe(
	id varchar(20),
    title varchar(100),
    image varchar(200),
    description varchar(200),
    amount double,
    primary key (id)
);

insert into Coffe(id, title, image, description, amount) 
values ('c1', 'Coffe', 'https://images.pexels.com/photos/2396220/pexels-photo-2396220.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'with cream', 4.5);
insert into Coffe(id, title, image, description, amount) 
values ('c2', 'Cappuccino', 'https://images.pexels.com/photos/2638019/pexels-photo-2638019.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'with cololate flavor', 5.2);
insert into Coffe(id, title, image, description, amount) 
values ('c3', 'Flat White', 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'steamed milk foam', 4.3);
insert into Coffe(id, title, image, description, amount) 
values ('c4', 'Mocha', 'https://elegantcoffee.com/wp-content/uploads/2020/06/mocha_new-500x500.jpg', 'chocolate flavor', 6.4);
insert into Coffe(id, title, image, description, amount) 
values ('c5', 'Latte', 'https://images.unsplash.com/photo-1557142046-c704a3adf364?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', 'vanilla favor', 7.5);
insert into Coffe(id, title, image, description, amount) 
values ('c6', 'Espresso', 
'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', 
'thik blak coffee', 4.6);

create table User(
	id int auto_increment,
	username varchar(30),
    password varchar(50),
    imagePath varchar(200),
    name nvarchar(50),
    primary key (id)
);

insert into User(username, password, imagePath, name) values('truongnnd', '1', '', 'Nguyen Dan Truong');
insert into User(username, password, imagePath, name) values('hiepnd', '1', '', 'Nguyen Duc Hiep');
insert into User(username, password, imagePath, name) values('tuandv', '1', '', 'Duong Van Tuan');
insert into User(username, password, imagePath, name) values('phucnv', '1', '', 'Nguyen Vu Phuc');

create table UserCart(
	id_user int,
    id_coffe varchar(20),
    quantity int,
    primary key(id_user, id_coffe),
    foreign key (id_user) references User(id),
    foreign key (id_coffe) references Coffe(id)
);

create table Orders(
	id int auto_increment,
    id_user int,
    amount double,
    date_time datetime,
    primary key(id)
);

create table OrdersItem(
	id_order int,
    id_coffe varchar(20),
    quantity int, 
    price double,
    primary key(id_order, id_coffe),
    foreign key(id_order) references Orders(id),
    foreign key(id_coffe) references Coffe(id)
);



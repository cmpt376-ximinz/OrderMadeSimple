CREATE TABLE restaurant (
	restaurant_id SERIAL UNIQUE PRIMARY KEY,
	restaurant_name varchar(40) NOT NULL UNIQUE,
	order_code varchar(10)
);

CREATE TABLE restaurant_info (
	restaurant_id integer PRIMARY KEY REFERENCES restaurant(restaurant_id),
	phone varchar(20), 
	address varchar(50) 
);

CREATE TABLE restaurant_hour (
	open_day varchar(20), 
	restaurant_id integer REFERENCES restaurant(restaurant_id),
	open_hr varchar(20),
	close_hr varchar(20),
	PRIMARY KEY(open_day, restaurant_id)
);

CREATE TABLE user_user(
	user_id SERIAL UNIQUE PRIMARY KEY,
	username varchar(30) NOT NULL,
	password varchar(150) NOT NULL,
	restaurant_id INTEGER NOT NULL
);

CREATE TABLE token(
	token_id SERIAL UNIQUE PRIMARY KEY,
	token varchar(150),
	username varchar(30) NOT NULL,
	expire_time TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE TABLE dish (
	dish_id	SERIAL UNIQUE PRIMARY KEY,
	dish_ver_id INTEGER,
	deleted boolean DEFAULT FALSE
);


CREATE TABLE dish_ver(
	dish_ver_id SERIAL UNIQUE PRIMARY KEY,
	version_number int NOT NULL,
	dish_id INTEGER NOT NULL REFERENCES dish(dish_id),
	dish_name varchar(200) NOT NULL,
	description varchar(200) ,
	restaurant_name varchar(40) NOT NULL REFERENCES restaurant(restaurant_name),
	price real NOT NULL,
	menu_flag varchar(200)
);

CREATE TABLE order_order(
	order_id SERIAL UNIQUE PRIMARY KEY,
	restaurant_name varchar(40) REFERENCES restaurant(restaurant_name),
	time TIMESTAMP WITH TIME ZONE,
	status varchar(30) NOT NULL,
	table_number varchar(30),
	included_in_eod_report BOOLEAN DEFAULT TRUE,
	created_by_user INTEGER
);

CREATE TABLE order_details(
	order_details_id SERIAL UNIQUE PRIMARY KEY,
	order_id INTEGER REFERENCES order_order(order_id),
	dish_ver_id INTEGER REFERENCES dish_ver(dish_ver_id),
	order_detail_status varchar(30) NOT NULL,
	special_note varchar(100)
);

CREATE TABLE customer(
	cid SERIAL PRIMARY KEY,
	fname varchar(50) NOT NULL,
	lname varchar(50) NOT NULL,
	phone varchar(20) NOT NULL
);

CREATE TABLE dining_table(
	tid SERIAL PRIMARY KEY,
	seats integer
);

CREATE TABLE duration(
	tid integer REFERENCES dining_table(tid),
	booking varchar(60),
	isBooked BOOLEAN,
	PRIMARY KEY(tid, booking)
);

CREATE TABLE reserve(
	cid integer REFERENCES customer(cid),
	tid integer REFERENCES dining_table(tid)
);


CREATE TABLE Library (
  category_id INT PRIMARY KEY,
  category VARCHAR(30),
  self_no INT CHECK (self_no BETWEEN 1 AND 10),
  row_no INT CHECK (row_no BETWEEN 1 AND 5)
);

CREATE TABLE Book (
  book_id INT PRIMARY KEY,
  category_id INT,
  book_name VARCHAR(30),
  publisher VARCHAR(30),
  edition VARCHAR(50),
  FOREIGN KEY (category_id) REFERENCES Library(category_id)
);


CREATE TABLE Reader (
  Id INT PRIMARY KEY,
  name VARCHAR(30),
  phone_num NUMERIC(11),
  email VARCHAR(30),
  book_id INT,
  FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

CREATE TABLE Order_book (
  Issue_no INT PRIMARY KEY,
  Book_id INT,
  Reader_id INT,
  issue_date DATE,
  FOREIGN KEY (Book_id) REFERENCES Book(book_id),
  FOREIGN KEY (Reader_id) REFERENCES Reader(Id)
);

select table_name from user_tables; //show all table

//add column
alter table book add(puslish_year char(4));
desc book;

//modify domain 
alter table book modify (publish_year numeric(4));
desc book;

//rename column name
alter table book rename column category_id to cat_id;
desc book;
alter table book rename column cat_id to category_id;

//delete column
alter table book drop column publish_year;
desc column;

//rename table name
rename book to book_info;
select table_name from user_tables;
rename book_info to book;

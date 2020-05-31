DROP DATABASE IF EXISTS LMS;
CREATE DATABASE LMS;
USE LMS;
CREATE TABLE BOOK(Isbn VARCHAR(10) primary key, Title VARCHAR(1000) not null, isCheckedOut boolean);

CREATE TABLE AUTHORS(Author_id INT UNSIGNED primary key, Name VARCHAR(100));

CREATE TABLE BOOK_AUTHORS(Isbn VARCHAR(10),Author_id INT UNSIGNED  ,primary key(Author_id,Isbn),FOREIGN KEY(Author_id) references AUTHORS(Author_id),FOREIGN KEY(Isbn) references BOOK(Isbn));

CREATE TABLE BORROWER(Card_id VARCHAR(10) primary key ,Ssn varchar(9) NOT NULL unique, Bname VARCHAR(100) NOT NULL,Address VARCHAR(1000) NOT NULL,Phone varchar(10));

CREATE TABLE BOOK_LOANS(Loan_id INT unsigned AUTO_INCREMENT primary key,Isbn VARCHAR(10) ,Card_id VARCHAR(10) ,Date_out datetime, Due_date datetime,Date_in datetime,FOREIGN KEY(Isbn) references BOOK(Isbn),FOREIGN KEY(card_id) references BORROWER(Card_id));
 
CREATE TABLE FINES(Loan_id INT unsigned primary key , Fine_amt DOUBLE, Paid boolean,FOREIGN KEY(Loan_id) references BOOK_LOANS(Loan_id));

CREATE TABLE COUNTRY(Id INT primary key, Name VARCHAR(1000) not null);

CREATE UNIQUE INDEX idx_isbn ON BOOK (Isbn);
CREATE UNIQUE INDEX idx_cardid ON BORROWER (Card_id);

CREATE VIEW fine_view AS SELECT b.Bname AS bname, SUM(f.Fine_amt) AS fines, f.Paid AS paid, bl.Card_id AS card_id FROM ((LMS.FINES f JOIN BOOK_LOANS bl ON ((f.Loan_id = bl.Loan_id))) JOIN BORROWER b ON ((bl.Card_id = b.Card_id)));

DELIMITER $
CREATE PROCEDURE calculate_fine(IN loan_id int(10))
BEGIN
  declare today datetime;
  declare fine double;
  SELECT NOW() into today;
  select Due_date from BOOK_LOANS where Loan_id=loan_id;
  SELECT TIMESTAMPDIFF(DAY,today,Due_date)*5 into fine;
  insert into FINES values(loan_id,fine,0);
END $
DELIMITER ;




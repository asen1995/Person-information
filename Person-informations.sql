DROP DATABASE IF EXISTS PersonInformation;

CREATE DATABASE PersonInformation;

Drop table if exists Person,Phone_Numbers,Cars,Hobbies,Person_cars,Person_hobbies,Hobies;

CREATE TABLE Person(id INT AUTO_INCREMENT,Full_Name Varchar(50) NOT NULL,years TinyINT NOT NULL, 
gender ENUM('MALE','FEMALE'),primary key(id));


/* relation 1 to 1 - 1 phone number  **/
Create TABLE Phone_Numbers(Id int,phone Varchar(10) not null UNIQUE,person_id int unique,
constraint foreign key(person_id) references Person(id) ON Delete cascade) ;


CREATE TABLE Cars(id int auto_increment PRIMARY KEY,brand Varchar(255)Not NULL,year_registered YEAR,registerNumber Varchar(15) NOT NULL UNIQUE,
owner_id INT,
constraint foreign key(owner_id) references Person(id) ON Delete cascade);

/* this table will be referenced by other table to create relations many-to-many**/
Create TABLE Hobbies(Id int AUTO_INCREMENT PRIMARY KEY,hobbie Varchar(50) not null) ;


Create TABLE Person_hobbies(id Int AUTO_INCREMENT PRIMARY KEY,person_id INT Not null,hobbies_id INT Not null,
constraint foreign key(person_id) references Person(id) ON Delete cascade,
constraint foreign key(hobbies_id) references Hobbies(id) ON Delete cascade
);

/****/
insert into Person(Full_name,years,gender)VALUES('Asen Nikolaev',21,'MALE'),
('Lilqna Petrova',21,'FEMALE'),
('Georgi Borisov',21,'MALE'),
('Svetlin Georgiev',21,'MALE');


insert into phone_numbers(phone,person_id)VALUES('0875369785',3),('0885369735',2),('0885369235',4),
('0887369785',1);
/**create a  VIEW**/





Insert into Cars(brand,year_registered,registerNumber,owner_id)VALUES('AUDI',2004,'BG G4235 AG',3),
('RENAULT',1997,'BG G4225 AG',3),
('RENAULT Clio',1987,'BG G4232 AG',2),
('RENAULT Megan',2010,'BG M4232 AG',1);


Insert into Hobbies(hobbie)VALUES('Sport'),('Swimming'),('Running'),('Computer games');





Insert into Person_hobbies(person_id,hobbies_id)VALUES(1,3),(2,1),(3,4),(3,1),(1,4),(4,4);





DROP VIEW   if exists Person_and_their_phones;
Create VIEW  Person_and_their_phones as
SELECT p.Full_Name as Person, p.years , p.gender ,phone.phone
from Person as p join phone_numbers as phone
on p.id = phone.person_id;



DROP VIEW   if exists Person_cars;
Create VIEW  Person_cars as
SELECT p.Full_Name as Person, p.years , p.gender ,c.brand as Car_Brand , c.year_registered ,c.registerNumber
from Person as p join Cars as c
on p.id = c.owner_id;


DROP VIEW   if exists Person_and_their_hobbies;
Create VIEW  Person_and_their_hobbies as
SELECT p.Full_Name as Person, p.years , p.gender , h.hobbie
from Person as p join hobbies as h
on p.id IN(Select person_id from Person_hobbies where
person_hobbies.hobbies_id = h.id);



SELECT * FROM Person_and_their_phones;
SELECT * FROM Person_cars;
Select * FROM Person_and_their_hobbies;


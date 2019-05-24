

-- Task 4

drop table Staff;
drop table OtherStaff;
drop table FlightAttendants;
drop table Pilot;
drop table Training;
drop table EmergencyContact;
drop table Plane;
drop table Trains;
drop table Flight;
drop table Works;
drop table Fly;
drop table Ticket;
drop table Passenger;
drop table Membership;

create table Staff(
	StaffNo char(8),
	HomeAddress varchar2(50),
	StaffName varchar2(50) not null,
	DateJoined date not null,
	DOB date not null,
CONSTRAINT PK_Staff primary key (StaffNo));
	
create table OtherStaff(
	StaffNo char(8),
	HomeAddress varchar2(50),
	StaffName varchar2(50) not null,
	DateJoined date not null,
	DOB date not null,
	JobType varchar2(30),
CONSTRAINT PK_OtherStaff primary key (StaffNo),
CONSTRAINT FK_OtherStaff foreign key (StaffNo) references Staff(StaffNo));

create table FlightAttendants(
	StaffNo char(8),
	HomeAddress varchar2(50),
	StaffName varchar2(50) not null,
	DateJoined date not null,
	DOB date not null,
CONSTRAINT PK_FlightAttendants primary key (StaffNo),
CONSTRAINT FK_FlightAttendants foreign key (StaffNo) references staff(StaffNo));

create table Pilot(
	StaffNo char(8),
	CertificationNo char(10),
	CertificationDate date not null,
	HomeAddress varchar2(50),
	StaffName varchar2(50) not null,
	DateJoined date not null,
	DOB date not null,
CONSTRAINT PK_Pilot primary key (StaffNo, CertificationNo),
CONSTRAINT FK_Pilot foreign key (staffNo) references Staff(StaffNo));

create table Training(
	StaffNo char(8),
	ProgramName varchar2(30),
	StartDate date,
	FinishDate date,
	ProgramDescription varchar2(200),
	HomeAddress varchar2(50),
	StaffName varchar2(50) not null,
	DateJoined date not null,
	DOB date not null,
CONSTRAINT PK_Training primary key (StaffNo, ProgramName, StartDate),
CONSTRAINT FK_Training foreign key (StaffNo) references FlightAttendants(StaffNo),
CONSTRAINT check_date check (StartDate<=FinishDate));

create table EmergencyContact(
	StaffNo char(8),
	Name varchar2(50) not null,
	Email varchar2(30) not null, 
	Relationship char(15),
	PostalAddress varchar2(50) not null,
	Phone char(10) not null,
CONSTRAINT PK_EmergencyContact primary key (StaffNo, Name),
CONSTRAINT FK_EmergencyContact foreign key (StaffNo) references Staff(StaffNo));

create table Plane(
	SerialNo char(8),
	Capacity char(4) not null,
	Range char(10) not null,
	Type varchar2(20) not null,
	ManufactureDate date not null,
	ServiceDate date,
	ServicePlace varchar2(30) not null,
	ServiceDescription varchar2(200) not null,
CONSTRAINT PK_Plane primary key (SerialNo));

create table Trains(
	StaffNo char(8),
	ProgramName varchar2(30),
	StartDate date,
CONSTRAINT PK_Trains primary key (StaffNo, ProgramName, StartDate),
CONSTRAINT FK1_Trains foreign key (StaffNo) references FlightAttendants (StaffNo),
CONSTRAINT FK2_Trains foreign key (ProgramName, StartDate) references Training (ProgramName, StartDate));

create table Flight(
	FlightNo char(10),
	FlightDate date,
	OriginCity varchar2(50) not null,
	DestCity varchar2(50) not null,
	SchedDep varchar2(20) not null,
	SchedArrival varchar2(20) not null,
	FlightDescription varchar2(50),
	ActualDeparture varchar2(20) not null,
	ActualArrival varchar2(20) not null,
	CertificationNo char(10) not null,
	SerialNo char(8) not null,
	StaffNo char(8) not null,
CONSTRAINT PK_Flight primary key (FlightNo, FlightDate),
CONSTRAINT FK1_Flight foreign key (SerialNo) references Plane (SerialNo),
CONSTRAINT FK2_Flight foreign key (CertificationNo, StaffNo) references Pilot (CertificationNo, StaffNo),
CONSTRAINT FK3_Flight foreign key (StaffNo) references FlightAttendants (StaffNo));

create table Works(
	StaffNo char(8),
	FlightNo char(10),
	FlightDate date,
CONSTRAINT PK_Works primary key (StaffNo, FlightNo, FlightDate),
CONSTRAINT FK1_Works foreign key (StaffNo) references FlightAttendants (StaffNo),
CONSTRAINT FK2_Works foreign key (FlightNo, FlightDate) references Flight (FlightNo, FlightDate));

create table Fly(
	StaffNo char(8),
	CertificationNo char(10),
	FlightNo char(10),
	FlightDate date,
CONSTRAINT PK_Fly primary key (StaffNo, CertificationNo, FlightNo, FlightDate),
CONSTRAINT FK1_Fly foreign key (StaffNo, CertificationNo) references Pilot (StaffNo, CertificationNo),
CONSTRAINT FK2_Fly foreign key (FlightNo, FlightDate) references Flight (FlightNo, FlightDate));

create table Ticket(
	TicketNo char(50),
	PurchaseDate date not null,
	PaymentType varchar2(50) not null,
	FlightNo char(10) not null,
	FlightDate date not null,
	TicketType varchar2(20) not null,
	Price char(100) not null,
	IDNumber char(8) not null,
	IDType varchar2(20) not null,
CONSTRAINT PK_Ticket primary key (TicketNo),
CONSTRAINT FK1_Ticket foreign key (FlightNo, FlightDate) references Flight (FlightNo, FlightDate),
CONSTRAINT FK2_Ticket foreign key (IDNumber, IDType) references Passenger (IDNumber, IDType),
CONSTRAINT purchase_date check (PurchaseDate<=FlightDate));
UNIQUE (IDNumber));

create table Passenger(
	IDNumber char(8),
	IDType varchar2(20),
	ContactPhone char(20) not null,
	DateOfBirth date not null,
	FirstnName varchar2(50) not null,
	LastName varchar2(50) not null,
	Address varchar2(100) not null, 
	Sex char(1) not null,
	EmailAddress varchar2(100) not null,
CONSTRAINT PK_Passenger primary key (IDNumber, IDType),
CONSTRAINT check_sex check (sex in ('M','F')));

create table Membership(
	MembershipNo char(8),
	IDNumber char(8) not null,
	IDType varchar2(20) not null,
	Points char(100),
	Levels varchar2(50),
	JoinDate date not null,
CONSTRAINT PK_Membership primary key (MembershipNo),
CONSTRAINT FK_Membership foreign key (IDNumber, IDType) references Passenger (IDNumber, IDType));


-- Data inputs

Insert into Staff values ('00000001', '12 Fake Street', 'Bob Smith', '18-Jan-2017', '14-Jan-1967');
Insert into Staff values ('00000002', '13 Far Lane', 'Alex Turner', '13-Jun-2015', '23-Feb-1980');
Insert into Staff values ('00000003', '16 Close Street', 'Dave Kelly', '23-Mar-2013', '30-Mar-1990');
Insert into Staff values ('00000004', '8 Surfers Parade', 'Janet Jackson', '10-Apr-2016', '14-Jan-1990');
Insert into Staff values ('00000005', '19 Airport Lane', 'Chris Johnson', '05-Dec-2015', '30-Jan-1975');
Insert into Staff values ('00000006', '11 Main Road', 'Rick Morgan', '24-Dec-1999', '14-Sep-1954');
Insert into Staff values ('00000007', '4 Long Road', 'Connor Halbert', '2-Mar-2000', '30-May-1966');
Insert into Staff values ('00000008', '113 Rich Avenue', 'Dallas Moore', '23-Aug-2003', '14-Jul-1973');
Insert into Staff values ('00000009', '1 Real Road', 'Dick Earl', '3-Nov-1991', '14-Aug-1967');

Insert into OtherStaff values ('00000004', '8 Surfers Parade', 'Janet Jackson', '10-Apr-2016', '14-Jan-1990','Receptionist');
Insert into OtherStaff values ('00000005', '19 Airport Lane', 'Chris Johnson', '05-Dec-2015', '30-Jan-1975','Maintanance');
Insert into OtherStaff values ('00000006', '11 Main Road', 'Rick Morgan', '24-Dec-1999', '14-Sep-1954','Janitor');

Insert into FlightAttendants values ('00000001', '12 Fake Street', 'Bob Smith', '18-Jan-2017', '14-Jan-1967');
Insert into FlightAttendants values ('00000002', '13 Far Lane', 'Alex Turner', '13-Jun-2015', '23-Feb-1980');
Insert into FlightAttendants values ('00000003', '16 Close Street', 'Dave Kelly', '23-Mar-2013', '30-Mar-1990');

Insert into Pilot values ('00000007', '10000', '23-Feb-2015', '4 Long Road', 'Connor Halbert', '2-Mar-2000', '30-May-1966');
Insert into Pilot values ('00000008', '20000', '12-May-2014', '113 Rich Avenue', 'Dallas Moore', '23-Aug-2003', '14-Jul-1973');
Insert into Pilot values ('00000009', '30000', '30-Nov-2016', '1 Real Road', 'Dick Earl', '3-Nov-1991', '14-Aug-1967');

Insert into Training values ('00000001', 'Customer Service', '12-Jul-2017', '13-Jul-2017', 'Learn how to treat customers.', '12 Fake Street', 'Bob Smith', '18-Jan-2017', '14-Jan-1967');	
Insert into Training values	('00000002', 'Customer Service', '12-Jul-2017', '13-Jul-2017', 'Learn how to treat customers.', '13 Far Lane', 'Alex Turner', '13-Jun-2015', '23-Feb-1980');
Insert into Training values	('00000003', 'Customer Service', '12-Jul-2017', '13-Jul-2017', 'Learn how to treat customers.', '16 Close Street', 'Dave Kelly', '23-Mar-2013', '30-Mar-1990');

Insert into EmergencyContact values ('00000001', 'Mary Smith', 'marysmith@hotmail.com', 'Wife', '12 Fake Street', '55675375');
Insert into EmergencyContact values ('00000002', 'Lisa Earlington', 'lisaturner@live.com', 'Girlfriend', '13 Far Lane', '44567533');
Insert into EmergencyContact values ('00000003', 'Reece Kelly', 'reecekelly@gmail.com', 'Brother', '123 Here Avenue', '45432467');

Insert into Plane values ('OPG-123', '500', '20,000 km', 'Airbus 1234', '12-Nov-2009', '12-Nov-2011', 'Gold Coast', 'Broken wing.');
Insert into Plane values ('PAN-789', '300', '15,000 km', 'Boeng 4321', '13-Aug-2004', '13-Aug-2006', 'Brisbane', 'Maintanance.');
Insert into Plane values ('QRT-554', '350', '18,000 km', 'Boeng 555', '01-Oct-2013', '01-Oct-2013', 'Brisbane', 'Oil check.');

Insert into Trains values ('00000001', 'Customer Service', '12-Jul-2017');
Insert into Trains values ('00000002', 'Customer Service', '12-Jul-2017');
Insert into Trains values ('00000003', 'Customer Service', '12-Jul-2017');

Insert into Flight values ('Q123DS', '23-Aug-2017', 'Gold Coast', 'Sydney', '1800', '1930', 'Clear Weather.', '1800', '1945', '10000', 'OPG-123', '00000007');
Insert into Flight values ('R565WJ', '23-Aug-2017', 'Brisbane', 'Sydney', '0600', '0800', 'Overcast', '0615', '0815', '20000', 'PAN-789', '00000008');
Insert into Flight values ('F573JK', '23-Aug-2017', 'Newcastle', 'Gold Coast', '1000', '1200', 'Storms', '1000', '1205', '30000', 'QRT-554', '00000009');

Insert into Works values ('00000001', 'Q123DS', '23-Aug-2017');
Insert into Works values ('00000002', 'R565WJ', '23-Aug-2017');
Insert into Works values ('00000003', 'F573JK', '23-Aug-2017');

Insert into Fly values ('00000007', '10000', 'Q123DS', '23-Aug-2017');
Insert into Fly values ('00000008', '20000', 'R565WJ', '23-Aug-2017');
Insert into Fly values ('00000009', '30000', 'F573JK', '23-Aug-2017');

Insert into Ticket values ('DE1234', '02-Aug-2017', 'Mastercard', 'Q123DS', '23-Aug-2017', 'First Class', '$300', '55555', 'Passport');
Insert into Ticket values ('DE1235', '05-Aug-2017', 'Mastercard', 'R565WJ', '23-Aug-2017', 'Economy', '$100', '55556', 'License');
Insert into Ticket values ('DE1237', '22-Aug-2017', 'Visa', 'F573JK', '23-Aug-2017', 'First Class', '$450', '55557', 'Passport');

Insert into Passenger values ('55555', 'Passport', '0414295353', '01-Feb-1990', 'Luke', 'Saele', '23 Passport Lane', 'M', 'Luke.Saele@griffithuni.edu.au'); 
Insert into Passenger values ('55556', 'License', '0416213553', '09-Nov-1987', 'Julia', 'Barbs', '1 Broadbeach Street', 'F', 'Julia.Barbs@griffithuni.edu.au'); 
Insert into Passenger values ('55557', 'Passport', '0414295781', '24-Jun-1986', 'Winston', 'Williams', '54 Hamilton Drive', 'M', 'Winston.Williams@griffithuni.edu.au'); 

Insert into Membership values ('61234', '55555', 'Passport', '1000', 'Level 1', '30-Jul-2016');
Insert into Membership values ('61235', '55556', 'License', '4000', 'Level 3', '03-Jun-2014');
Insert into Membership values ('61236', '55557', 'Passport', '10000', 'Level 5', '04-Feb-2012');


-- Queries

--1. For each airplane (given the serial number), list the type code, type description,
-- capacity and flight range, manufacture date, purchase date, and the next service date. 

SELECT SerialNo, Type, Capacity, Range, ManufactureDate, ServiceDate from Plane;

--5. For each city (given the city name), produce a list of the flights scheduled to
-- departure within the next 24 hours. The list should include the flight number, the time
-- of departure in ascending order of departure time. 

SELECT OriginCity, FlightNo, SchedDep from Flight where SchedDep >= SYSDATE - 1 group by OriginCity;

--8. For each scheduled flight (given the flight number and date), prepare a customer
-- call list, which includes the ID type, ID number, full name, date of birth, address and
-- contact phone number of the passengers booked on the flight. 

SELECT SchedDep, p.IDType, p.IDNumber, FirstName, LastName, DateOfBirth, Address, ContactPhone from Passenger p, Ticket t, Flight f, where p.IDNumber=t.IDNumber and p.IDType=t.IDType 
and t.FlightNo=f.FlightNo and t.FlightDate=f.FlightDate group by SchedDep;

--12. List all airplanes by the serial number and type code, and if an airplane is
-- scheduled to fly today, also list the flight number. 

SELECT p.SerialNo, Type, FlightNo from Plane p, (Select FlightNo from Flight where SchedDep=SYSDATE) f where p.SerialNo=f.SerialNo(+);





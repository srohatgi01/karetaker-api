-- The ratings are directly been taken from the user and assigned to hospital or doctor. The rating is not associated to any particular appointment yet which needs to be looked into.

CREATE TABLE users (
    email_address VARCHAR(255) PRIMARY KEY NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    uuid VARCHAR(255) UNIQUE,
    phone_number CHAR(10),
    gender ENUM('MALE', 'FEMALE', 'OTHERS'),
    photo_url VARCHAR(255),
    blood_group ENUM('A_POS','A_NEG','B_POS','B_NEG','O_POS','O_NEG','AB_POS','AB_NEG'),
    age INTEGER,
    body_height FLOAT,
    body_weight FLOAT 
);

CREATE TABLE specialities (
    speciality_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    speciality_name VARCHAR(255)
);

CREATE TABLE doctors (
    doctor_id VARCHAR(255) PRIMARY KEY NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    speciality_id INTEGER,
    phone_number CHAR(10) NOT NULL,
    practicing_years INTEGER(2) NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    FOREIGN KEY (speciality_id) REFERENCES specialities(speciality_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hospitals (
    hospital_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    hospital_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255),
    phone_number CHAR(10),
    hospital_address VARCHAR(255) NOT NULL
);

-- Create hostpitals has doctors  
CREATE TABLE hospitals_has_doctors (
    doctor_id VARCHAR(255),
    hospital_id INTEGER,
    doctor_status ENUM('FULL TIME', 'PART TIME'),
    fee VARCHAR(5),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (doctor_id, hospital_id)
);

-- Create Pills Table
CREATE TABLE pills (
    pills_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pill_name VARCHAR(255) NOT NULL,
    pill_time TIME,
    user_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(email_address) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Slots Table 
CREATE TABLE slots (
    slot_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    doctor_id VARCHAR(255),
    hospital_id INTEGER NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Appointment Table 
CREATE TABLE appointments (
    appointment_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    appointment_date DATE NOT NULL,
    user_id VARCHAR(255),
    doctor_id VARCHAR(255),
    hospital_id INTEGER NOT NULL,
    slot_id INTEGER,
    remarks TEXT,
    status ENUM('BOOKED', 'CANCELED BY USER', 'CANCELED BY DOCTOR', 'COMPLETED') DEFAULT 'BOOKED',
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(email_address) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (slot_id) REFERENCES slots(slot_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Rating table
CREATE TABLE ratings (
    rating_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    doctor_id VARCHAR(255) NOT NULL,
    hospital_id INTEGER NOT NULL,
    rating_value INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(email_address) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE reviews (
    review_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    review_text VARCHAR(255),
    rating_id INTEGER,
    timestamp timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (rating_id) REFERENCES ratingS(rating_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Reports Table
CREATE TABLE reports (
    report_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    user_id VARCHAR(255),
    name_of_report VARCHAR(255),
    date_of_report VARCHAR(255),
    doctor_who_created_report VARCHAR(255),
    show_status ENUM('SHOW', 'HIDE'),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(email_address) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Reports details Table
CREATE TABLE report_details (
    report_details_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    report_id INTEGER,
    report_image_link varchar(255),
    remark VARCHAR(255),
    FOREIGN KEY (report_id) REFERENCES reports(report_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create QR Code Table
CREATE TABLE qr_code (
    qr_link VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(email_address) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Sugar Reading Table
CREATE TABLE sugar_readings (
    reading_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    user_id VARCHAR(255),
    value VARCHAR(4),
    type ENUM('TYPE 1', 'TYPE 2', 'TYPE 3'),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(email_address) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Heart Rate Table
CREATE TABLE heart_rate_readings (
    reading_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    user_id VARCHAR(255),
    reading_value VARCHAR(4),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(email_address) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE blood_pressure_readings (
    reading_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    user_id VARCHAR(255),
    reading_value VARCHAR(7),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(email_address) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE blogs (
    blog_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    body TEXT,
    written_by VARCHAR(255)
);

CREATE TABLE keywords (
    keyword VARCHAR(255) PRIMARY KEY NOT NULL
);

CREATE TABLE blogs_has_keywords (
    blogs_has_keywords_id INT PRIMARY KEY AUTO_INCREMENT,
    blog_id INTEGER,
    keyword_name VARCHAR(255),
    FOREIGN KEY (blog_id) REFERENCES blogs(blog_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (keyword_name) REFERENCES keywords(keyword) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Insertion Commands

-- Insert values for users Table

INSERT INTO users VALUES ('sarthak@mail.com', 'Sarthak', 'Rohatgi', '12456789078', '968599277', 'MALE'), 
('salik@mail.com', 'Salik', 'Uddin', '1245674078', '7894561230', 'MALE'),
('ssalik@mail.com', 'Salik', 'Uddin', '1245674079', '7894561230', 'MALE'), 
('umair@mail.com', 'Umair', '', '1246674076', '9894561230', 'MALE'),  
('Oshi@mail.com', 'Osasma', 'Binladen', '15645675078', '7894561440', 'MALE'),  
('eeshastyles@mail.com', 'Eesha', 'Khan', '19945674078', '7944561230', 'FEMALE'), 
('Hussaina@mail.com', 'Hussaina', 'Hssain', '240004078', '7894000230', 'FEMALE'),  
('bathak@mail.com', 'Bathak', 'Guleryuz', '4246664078', '7869691230', 'OTHERS'),  
('Xediii@mail.com', 'Xedi', 'Gamer', '62565674078', '7894929230', 'MALE'),  
('bsdk@mail.com', 'Laura', 'Lassun', '7969696969696', '0000690000', 'OTHERS');


-- Insert values for speciality table
INSERT INTO specialities(speciality_name) VALUES
('Gynecologist'),
('oncologist'),
('dermatologist'),
('cardiologist'),
('neurologist'),
('General Surgeon'),
('Urologist'),
('endocrynologist'),
('Pediatrist'),
('Pschiatrist');

-- Insert values for doctors table
INSERT INTO doctors VALUES('654687486','Sandeep','Maheshwari',2,'9595956666',100,'sandeep@mail.com'),
('654687442','Match','Udaipuri',2,'9595156666',15,'Match_udaipuri@mail.com'),
('654687482','Mukul','Gulati',2,'9515956666',6,'Mukul@mail.com'),
('654687483','Aman','Soni',2,'9595956166',2,'aman@mail.com'),
('654687484','Khamosh','Singh',2,'9512956666',10,'khamosh@mail.com'),
('654687485','Sarfarosh','Chacha',2,'95959666',16,'sarfarosh@mail.com'),
('654687487','Milee','Maheshwari',2,'9445956666',20,'Milee@mail.com'),
('654687488','Emma','Watson',2,'9595556666',50,'Emma@mail.com'),
('654687489','Johnny','Sins',2,'9575956666',11,'18+@mail.com'),
('654687490','Tayyaba','Hassan',2,'9598856666',6,'Tayyaba@mail.com');


-- Insert values for HOSPITALS table
INSERT INTO hospitals(hospital_name,email_address,phone_number,hospital_address) VALUES('Bansal Hospital','bansal@mail.com','9494945555','kolar road, Bhopal, India'),
('Hamidia Hospital','hamidia@mail.com','9494745555','idgah road, Bhopal, India'),
('Aastha Hospital','aastha@mail.com','9494945455','jhawar road, Bhopal, India'),
('City Hospital','city@mail.com','9494945550','mp nagar, Bhopal, India'),
('Bhopal Hospital','bhopal@mail.com','9494945505','kolar road, Bhopal, India'),
('Chirayu Hospital','chirayu@mail.com','9494940555','city area, Bhopal, India'),
('Global','global@mail.com','9494945598','Bittan Market, Bhopal, India'),
('Eye Care','eyecare@mail.com','9404945555','MP Nagar, Bhopal, India'),
('Iris','iris@mail.com','0494945555','E-6 road, Bhopal, India'),
('National Hospital','national@mail.com','1494945555','somewhere road, Bhopal, India');

-- Insert values for Hospitals_has_doctors table

INSERT INTO hospitals_has_doctors VALUES('654687442' , 1,'FULL TIME',500),
('654687483' , 1,'FULL TIME',500),
('654687482' , 1,'PART TIME',250),
('654687482' , 2,'PART TIME',300),
('654687484' , 2,'FULL TIME',600),
('654687485' , 3,'PART TIME',300),
('654687485' , 4,'PART TIME',2000),
('654687486' , 5,'FULL TIME',5000),
('654687487' , 5,'PART TIME',400),
('654687488' , 6,'FULL TIME',550);

-- Insert values into pills
INSERT INTO pills(pill_name,pill_time,user_id) VALUES('Limcee','13:30','bathak@mail.com'),
('azithromycin','14:00','bathak@mail.com'),
('Zincovate','14:00','bathak@mail.com'),
('Combiflam','13:00','umair@mail.com'),
('D-Aspartic acid','13:00','umair@mail.com'),
('Viagra','02:00','umair@mail.com'),
('Norflox TZ','05:00','Oshi@mail.com'),
('Unienzyme','05:00','Oshi@mail.com'),
('Digene','04:00','Oshi@mail.com');


-- Insert into Slots Table
INSERT INTO slots(doctor_id, hospital_id, start_time, end_time) VALUES 
('654687486', 1, '10:00', '10:20'),
('654687486', 1, '10:20', '10:40'),
('654687486', 1, '10:40', '11:00'),
('654687486', 1, '11:00', '11:20'),
('654687486', 1, '11:20', '11:40'),
('654687442', 2, '10:00', '10:20'),
('654687442', 2, '10:20', '10:40'),
('654687442', 2, '10:40', '11:00'),
('654687442', 2, '11:00', '11:20'),
('654687442', 2, '11:20', '11:40'),
('654687482', 3, '10:00', '10:20'),
('654687482', 3, '10:20', '10:40'),
('654687482', 3, '10:40', '11:00'),
('654687482', 3, '11:00', '11:20'),
('654687482', 3, '11:20', '11:40'),
('654687483', 4, '10:00', '10:20'),
('654687483', 4, '10:20', '10:40'),
('654687483', 4, '10:40', '11:00'),
('654687483', 4, '11:00', '11:20'),
('654687483', 4, '11:20', '11:40'),
('654687484', 5, '10:00', '10:20'),
('654687484', 5, '10:20', '10:40'),
('654687484', 5, '10:40', '11:00'),
('654687484', 5, '11:00', '11:20'),
('654687484', 5, '11:20', '11:40'),
('654687485', 6, '10:00', '10:20'),
('654687485', 6, '10:20', '10:40'),
('654687485', 6, '10:40', '11:00'),
('654687485', 6, '11:00', '11:20'),
('654687485', 6, '11:20', '11:40');


-- Insert into appointments table
INSERT INTO appointments(appointment_date, user_id, doctor_id, hospital_id, slot_id, remarks) VALUES 
('2021-05-13', 'sarthak@mail.com', '654687486', 5, 2, 'Sir I have contipation problem.'),
('2021-05-14', 'salik@mail.com', '654687442', 1, 2, 'Sir I have loose motion problem.'),
('2021-05-15', 'bathak@mail.com', '654687482', 2, 4, 'Sir I have fever .'),
('2021-05-14', 'bsdk@mail.com', '654687486', 1, 7, 'Sir I have piles.');

-- Insert values into Rating table
INSERT INTO ratings(user_id, doctor_id, hospital_id, rating_value) VALUES 
('sarthak@mail.com', '654687486', 1, 4),
('salik@mail.com', '654687442', 2, 1),
('bsdk@mail.com', '654687482', 4, 3),
('bathak@mail.com', '654687483', 4, 4);

-- Insert values into Reviews table
INSERT INTO reviews(review_text, rating_id) VALUES ('Good', 1),
('Decent Doctor', 1),
('Clean Hospital and Doctor', 1);

-- Insert into reports table
INSERT INTO reports(user_id, name_of_report, date_of_report, doctor_who_created_report, show_status) VALUES 
('sarthak@mail.com', 'Blood Report', '2020-08-15', 'Dr. Osama Bin Laltein', 'SHOW'),
('sarthak@mail.com', 'Sugar Report', '2020-03-15', 'Dr. Osama Bin Laltein', 'HIDE'),
('sarthak@mail.com', 'BP Report', '2020-07-12', 'Dr. Sandeep', 'HIDE'),
('salik@mail.com', 'Blood Report', '2020-04-15', 'Guru', 'HIDE'),
('salik@mail.com', 'Constipation Report', '2020-12-15', 'Dr. Guru', 'SHOW'),
('salik@mail.com', 'Loose MotionReport', '2020-09-12', 'Dr. Kalle', 'HIDE'),
('umair@mail.com', 'Loose Motion Report', '2012-07-15', 'Dr. Meow', 'SHOW'),
('umair@mail.com', 'Blood Report', '2020-07-15', 'Dr. Meow', 'HIDE'),
('umair@mail.com', 'Sugar Report', '2013-07-15', 'Dr. Showsome', 'SHOW'),
('Oshi@mail.com', 'Blood Report', '2021-01-15', 'Dr. Osama Bin Laltein', 'HIDE');

-- insert into report_details
INSERT INTO report_details(report_id, report_image_link, report_page_number, remark) VALUES
(1, "Some url01", '1', 'Some Remark 1'),
(1, "Some url01", '2', 'Some Remark2'),
(1, "Some url01", '3', 'Some Remark3'),
(2, "Some url01", '1', 'Some Remark1'),
(2, "Some url01", '2', 'Some Remark2'),
(2, "Some url01", '3', 'Some Remark3'),
(3, "Some url01", '1', 'Some Remark1'),
(3, "Some url01", '2', 'Some Remark2'),
(3, "Some url01", '3', 'Some Remark3'),
(3, "Some url01", '4', 'Some Remark4'),
(4, "Some url01", '1', 'Some Remark1'),
(4, "Some url01", '2', 'Some Remark2'),
(4, "Some url01", '3', 'Some Remark3'),
(5, "Some url01", '1', 'Some Remark1'),
(5, "Some url01", '2', 'Some Remark2'),
(6, "Some url01", '1', 'Some Remark1'),
(7, "Some url01", '1', 'Some Remark1'),
(8, "Some url01", '1', 'Some Remark1'),
(9, "Some url01", '1', 'Some Remark1'),
(10, "Some url01", '1', 'Some Remark1'),
(10, "Some url01", '2', 'Some Remark2'),
(10, "Some url01", '3', 'Some Remark3');

-- Insert into qr code table
INSERT INTO qr_code VALUES
('sOMEsqlink.com/fjdlkfj', 'sarthak@mail.com'),
('sOMEsqlsnk.com/fjdlkfj', 'salik@mail.com'),
('sOMEsqldnk.com/fjdlkfj', 'ssalik@mail.com'),
('sOMEsqlsfnk.com/fjdlkfj', 'umair@mail.com'),
('sOMEsqlidgsnk.com/fjdlkfj', 'Oshi@mail.com'),
('sOMEsqlindsvsk.com/fjdlkfj', 'eeshastyles@mail.com'),
('sOMEsqldshink.com/fjdlkfj', 'Hussaina@mail.com'),
('sOMEsqlnfink.com/fjdlkfj', 'bathak@mail.com'),

('sOMEsqlink.com/sbfjdlkfj', 'bsdk@mail.com'),
('sOMEsqlink.com/fbfdfbdjdlkfj', 'Xediii@mail.com');

-- Insert values into blogs
INSERT INTO blogs(title,body,written_by) VALUES('Pregnanacy','Get early prenatal care. ...
Maintain a healthy diet
Take prenatal vitamins
Exercise regularly
Listen to your body
Eliminate alcohol and limit caffeine
Limit your exposure
Visit your dentist','salik Uddin'),
('cancer','Feeling low or depressed after treatment ends is common. Cancer survivors often experience worry, fear of recurrence, 
or periods of feeling down, for months or even years after treatment. Some people feel sad or depressed because of the changes that 
cancer has caused, or because they are frightened about the future.','bathak'),
('blood pressure','Odds are you know that your blood pressure is important and that you should be keeping it within a healthy range.
But beyond that, what do you really know about your blood pressure? It can be hard to know what questions to ask, especially when you’re
just learning about managing your own blood pressure. Here are the answers to the questions you forgot to ask, were afraid to ask, or 
didn’t know to ask.','umair'),
('Diabetes','Managing diabetes doesn’t mean never indulging in foods you enjoy, which is why you’ll find over 900 diabetes-friendly
recipes on this blog. Diabetes Self-Management also posts about product reviews, nutrition, meal planning, and exercise, plus tools for
 counting carbs, planning workouts , and much more.','Oshi'),
('Covid','India is a country of countries. Don’t get surprised. It is made of 28 States and 8 Union Territories, a total of 6 entities.
Each of these are different in culture, culinary, language, outfit, style of living, weather and health systems. Each one of these are
like different countries. However, each one is tightly bonded with each other for several reasons. We truly represent ‘unity within 
diversity’. COVID-19 has perhaps further brought all of them together to fight with this deadly disease.','Oshi');


-- Insert into keywords
INSERT INTO keywords VALUES('cancer'),
('pregnancy'),
('blood pressure'),
('diabetes'),
('thyroid'),
('covid 19'),
('malaria'),
('desentry'),
('diarrheoa'),
('migrane'),
('liprosy'),
('hypochonriac'),
('remdesivir'),
('Azithromycin'),
('ayurveda'),
('homeopathic'),
('periods'),
('viagra');

-- Insert into Blog has Keywords Table
INSERT INTO blogs_has_keywords VALUES
(001,'cancer'),
(002,'cancer'),
(003,'cancer'),
(004,'cancer'),
(005,'cancer'),
(001,'pregnancy'),
(002,'pregnancy'),
(003,'pregnancy'),
(004,'pregnancy'),
(005,'pregnancy'),
(001,'diabetes'),
(002,'diabetes'),
(003,'diabetes'),
(004,'diabetes'),
(005,'diabetes'),
(001,'blood pressure'),
(002,'blood pressure'),
(003,'blood pressure'),
(004,'blood pressure'),
(005,'blood pressure'),
(001,'thyroid'),
(002,'thyroid'),
(003,'thyroid'),
(004,'thyroid'),
(005,'thyroid'),
(001,'Azithromycin'),
(002,'Azithromycin'),
(003,'Azithromycin'),
(004,'Azithromycin'),
(005,'Azithromycin');


-- Insert into Sugar Reading Table
INSERT INTO sugar_readings(user_id,value,type) VALUES
('salik@mail.com','210','TYPE 1'),
('ssalik@mail.com','140','TYPE 1'),
('umair@mail.com','120','TYPE 1'),
('Oshi@mail.com','125','TYPE 1'),
('eeshastyles@mail.com','142','TYPE 1'),
('Hussaina@mail.com','250','TYPE 3'),
('bathak@mail.com','123','TYPE 1'),
('Xediii@mail.com','149','TYPE 2'),
('bsdk@mail.com','300','TYPE 1');


-- Insert into heart rate table
INSERT INTO heart_rate_readings(user_id,reading_value) VALUES
('salik@mail.com','70'),
('ssalik@mail.com','74'),
('umair@mail.com','80'),
('Oshi@mail.com','50'),
('eeshastyles@mail.com','76'),
('Hussaina@mail.com','89'),
('bathak@mail.com','75'),
('Xediii@mail.com','84'),
('bsdk@mail.com','58');


-- Insert into blood pressure table
INSERT INTO blood_pressure_readings (user_id,reading_value) VALUES
('salik@mail.com','120/78'),
('ssalik@mail.com','140/90'),
('umair@mail.com','143/85'),
('Oshi@mail.com','13/78'),
('eeshastyles@mail.com','130/84'),
('Hussaina@mail.com','180/50'),
('bathak@mail.com','95/55'),
('Xediii@mail.com','140/98'),
('bsdk@mail.com','122/78');
CREATE TABLE users (
    email_address VARCHAR(255) PRIMARY KEY NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    uuid VARCHAR(255),
    phone_number CHAR(10),
    gender ENUM('MALE', 'FEMALE', 'OTHERS')
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
    FOREIGN KEY (speciality_id) REFERENCES speciality(speciality_id) ON DELETE CASCADE ON UPDATE CASCADE
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
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id) ON DELETE CASCADE ON UPDATE CASCADE,
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
    review_id INTEGER PRIMARY KEY NOT NULL,
    review_text VARCHAR(255),
    rating_id INTEGER,
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
    report_page_number ENUM('1', '2', '3', '4', '5', '6'),
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
    reading_value VARCHAR(4),
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
    blog_id INTEGER,
    keyword_name VARCHAR(255),
    FOREIGN KEY (blog_id) REFERENCES blogs(blog_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (keyword_name) REFERENCES keywords(keyword) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Query all the particular user information
select * from users where email_address  = 'umair@mail.com';

-- Query all the pills for the particular user
select * from pills where user_id = 'umair@mail.com';

-- Query to get the lastest inputted reading of blood pressure
select * from blood_pressure_readings where reading_id = (SELECT MAX(reading_id) FROM blood_pressure_readings where user_id = 'umair@mail.com');

-- Query to get the lastest inputted reading of sugar_readings
select * from sugar_readings where reading_id = (SELECT MAX(reading_id) FROM sugar_readings where user_id = 'umair@mail.com');

-- Query to get the lastest inputted reading of heart rate
select * from heart_rate_readings where reading_id = (SELECT MAX(reading_id) FROM heart_rate_readings where user_id = 'umair@mail.com');

-- Query to make an appointment and to view that appointment
SELECT * from appointments WHERE user_id = 'bsdk@mail.com' ORDER BY appointment_date DESC;

-- Query to list all the doctors according to specialities
SELECT * FROM doctors WHERE speciality_id = (SELECT speciality_id FROM specialities WHERE speciality_name = 'oncologist');

-- Query to get all available time slots for a particular doctor at a particular hospital
select slot_id from slots where doctor_id=654687486 and not exists (select slot_id from appointments where appointments.slot_id=slots.slot_id and appointments.doctor_id=slots.doctor_id and appointment_date='2021-05-20' and slots.hospital_id = appointments.hospital_id); --for most part it is working well and good but need to test some more.

-- Query to make a docotor's appointment
INSERT INTO appointments(appointment_date, user_id, doctor_id, hospital_id, slot_id, remarks) VALUES 
('2021-05-20', 'salik@mail.com', '654687486', 1, 1, 'Sir I have piles.');

-- Query to see all previous appointments
SELECT * FROM appointments WHERE user_id = 'salik@mail.com' ORDER BY appointment_date DESC;

-- Query to see the appointment made (active ones)
SELECT * FROM appointments WHERE user_id = 'salik@mail.com' AND status = 'BOOKED' ORDER BY appointment_date DESC;

-- Query to see the appointment made (user canceled ones)
SELECT * FROM appointments WHERE user_id = 'salik@mail.com' AND status = 'CANCELED BY USER' ORDER BY appointment_date DESC;

-- Query to see the appointment made (doctor cancelled ones)
SELECT * FROM appointments WHERE user_id = 'salik@mail.com' AND status = 'CANCELED BY DOCTOR' ORDER BY appointment_date DESC;

-- Query to see the appointment made (completed ones ones)
SELECT * FROM appointments WHERE user_id = 'salik@mail.com' AND status = 'COMPLETED' ORDER BY appointment_date DESC;

-- Query to let doctor see all the appoointments which have status booked
SELECT * FROM appointments WHERE doctor_id = "" AND status = 'BOOKED' ORDER BY appointment_date;

-- Query to cancel the apponitment by user AND\OR mark completed by doctor
-- Query to let user change the appointment status
-- Query to let doctor change the appoointment status to be completed or canceled
UPDATE appointments SET status = '' WHERE appointment_id = 1;

-- Query for after the appointment is done, the user can give a simple rating or wrtie a review
INSERT INTO ratings(user_id, doctor_id, hospital_id, rating_value) VALUES 
('salik@mail.com', '654687483', 4, 4);

-- Query to get a average of the ratings for doctor at a hospital
SELECT AVG(rating_value) WHERE doctor_id = "" AND hospital_id = "";

-- Query to list out all the reviews for a doctor order by lastest first.
SELECT review_text, rating_id FROM reviews WHERE rating_id = (SELECT rating_id FROM ratings WHERE doctor_id = "654687486") ORDER BY timestamp DESC;
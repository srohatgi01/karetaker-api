-- CreateTable
CREATE TABLE `appointments` (
    `appointment_id` INTEGER NOT NULL AUTO_INCREMENT,
    `appointment_date` DATE NOT NULL,
    `user_id` VARCHAR(255),
    `doctor_id` VARCHAR(255),
    `hospital_id` INTEGER NOT NULL,
    `slot_id` INTEGER,
    `remarks` TEXT,
    `status` ENUM('BOOKED', 'CANCELED BY USER', 'CANCELED BY DOCTOR', 'COMPLETED') DEFAULT 'BOOKED',
    `timestamp` TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `doctor_id`(`doctor_id`),
    INDEX `hospital_id`(`hospital_id`),
    INDEX `slot_id`(`slot_id`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`appointment_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blogs` (
    `blog_id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255),
    `body` TEXT,
    `written_by` VARCHAR(255),

    PRIMARY KEY (`blog_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blogs_has_keywords` (
    `blog_id` INTEGER,
    `keyword_name` VARCHAR(255),

    INDEX `blog_id`(`blog_id`),
    INDEX `keyword_name`(`keyword_name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blood_pressure_readings` (
    `reading_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(255),
    `reading_value` VARCHAR(7),
    `timestamp` TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`reading_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `doctors` (
    `doctor_id` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `speciality_id` INTEGER,
    `phone_number` CHAR(10) NOT NULL,
    `practicing_years` INTEGER NOT NULL,
    `email_address` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`doctor_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `heart_rate_readings` (
    `reading_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(255),
    `reading_value` VARCHAR(4),
    `timestamp` TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`reading_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hospitals` (
    `hospital_id` INTEGER NOT NULL AUTO_INCREMENT,
    `hospital_name` VARCHAR(255) NOT NULL,
    `email_address` VARCHAR(255),
    `phone_number` CHAR(10),
    `hospital_address` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`hospital_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hospitals_has_doctors` (
    `doctor_id` VARCHAR(255) NOT NULL,
    `hospital_id` INTEGER NOT NULL,
    `doctor_status` ENUM('FULL TIME', 'PART TIME'),
    `fee` VARCHAR(5),

    INDEX `hospital_id`(`hospital_id`),
    PRIMARY KEY (`doctor_id`, `hospital_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `keywords` (
    `keyword` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`keyword`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pills` (
    `pills_id` INTEGER NOT NULL AUTO_INCREMENT,
    `pill_name` VARCHAR(255) NOT NULL,
    `pill_time` TIME(0),
    `user_id` VARCHAR(255) NOT NULL,

    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`pills_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `qr_code` (
    `qr_link` VARCHAR(255) NOT NULL,
    `user_id` VARCHAR(255),

    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`qr_link`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ratings` (
    `rating_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(255) NOT NULL,
    `doctor_id` VARCHAR(255) NOT NULL,
    `hospital_id` INTEGER NOT NULL,
    `rating_value` INTEGER,

    INDEX `doctor_id`(`doctor_id`),
    INDEX `hospital_id`(`hospital_id`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`rating_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `report_details` (
    `report_details_id` INTEGER NOT NULL AUTO_INCREMENT,
    `report_id` INTEGER,
    `report_image_link` VARCHAR(255),
    `report_page_number` ENUM('one', 'two', 'three', 'four', 'five', 'six'),
    `remark` VARCHAR(255),

    INDEX `report_id`(`report_id`),
    PRIMARY KEY (`report_details_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reports` (
    `report_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(255),
    `name_of_report` VARCHAR(255),
    `date_of_report` VARCHAR(255),
    `doctor_who_created_report` VARCHAR(255),
    `show_status` ENUM('SHOW', 'HIDE'),
    `timestamp` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`report_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reviews` (
    `review_id` INTEGER NOT NULL AUTO_INCREMENT,
    `review_text` VARCHAR(255),
    `rating_id` INTEGER,
    `timestamp` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `rating_id`(`rating_id`),
    PRIMARY KEY (`review_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `slots` (
    `slot_id` INTEGER NOT NULL AUTO_INCREMENT,
    `doctor_id` VARCHAR(255),
    `hospital_id` INTEGER NOT NULL,
    `start_time` TIME(0) NOT NULL,
    `end_time` TIME(0) NOT NULL,

    INDEX `doctor_id`(`doctor_id`),
    INDEX `hospital_id`(`hospital_id`),
    PRIMARY KEY (`slot_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `specialities` (
    `speciality_id` INTEGER NOT NULL AUTO_INCREMENT,
    `speciality_name` VARCHAR(255),

    PRIMARY KEY (`speciality_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sugar_readings` (
    `reading_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(255),
    `value` VARCHAR(4),
    `type` ENUM('TYPE 1', 'TYPE 2', 'TYPE 3'),
    `timestamp` TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`reading_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `email_address` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `uuid` VARCHAR(255),
    `phone_number` CHAR(10),
    `gender` ENUM('MALE', 'FEMALE', 'OTHERS'),

    UNIQUE INDEX `users.uuid_unique`(`uuid`),
    PRIMARY KEY (`email_address`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `appointments` ADD FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `appointments` ADD FOREIGN KEY (`hospital_id`) REFERENCES `hospitals`(`hospital_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `appointments` ADD FOREIGN KEY (`slot_id`) REFERENCES `slots`(`slot_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `appointments` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`email_address`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blogs_has_keywords` ADD FOREIGN KEY (`blog_id`) REFERENCES `blogs`(`blog_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blogs_has_keywords` ADD FOREIGN KEY (`keyword_name`) REFERENCES `keywords`(`keyword`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blood_pressure_readings` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`email_address`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `doctors` ADD FOREIGN KEY (`speciality_id`) REFERENCES `specialities`(`speciality_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `heart_rate_readings` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`email_address`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `hospitals_has_doctors` ADD FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `hospitals_has_doctors` ADD FOREIGN KEY (`hospital_id`) REFERENCES `hospitals`(`hospital_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pills` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`email_address`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `qr_code` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`email_address`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ratings` ADD FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ratings` ADD FOREIGN KEY (`hospital_id`) REFERENCES `hospitals`(`hospital_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ratings` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`email_address`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `report_details` ADD FOREIGN KEY (`report_id`) REFERENCES `reports`(`report_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reports` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`email_address`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reviews` ADD FOREIGN KEY (`rating_id`) REFERENCES `ratings`(`rating_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `slots` ADD FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `slots` ADD FOREIGN KEY (`hospital_id`) REFERENCES `hospitals`(`hospital_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sugar_readings` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`email_address`) ON DELETE SET NULL ON UPDATE CASCADE;

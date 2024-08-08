CREATE TABLE `CalendarIntegration` (
    `id` text PRIMARY KEY NOT NULL,
    `user_id` text NOT NULL,
    `provider` text NOT NULL,
    `access_token` text,
    `refresh_token` text,
    `expires_at` integer,
    FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `Event` (
    `id` text PRIMARY KEY NOT NULL,
    `trip_id` text,
    `user_id` text NOT NULL,
    `title` text NOT NULL,
    `description` text,
    `start_date` integer NOT NULL,
    `end_date` integer,
    `latitude` real,
    `longitude` real,
    `category` text,
    FOREIGN KEY (`trip_id`) REFERENCES `Trip`(`id`) ON UPDATE no action ON DELETE no action,
    FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `Expense` (
    `id` text PRIMARY KEY NOT NULL,
    `trip_id` text,
    `user_id` text NOT NULL,
    `amount` real NOT NULL,
    `currency` text NOT NULL,
    `date` integer NOT NULL,
    `category` text,
    `description` text,
    FOREIGN KEY (`trip_id`) REFERENCES `Trip`(`id`) ON UPDATE no action ON DELETE no action,
    FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `Trip` (
    `id` text PRIMARY KEY NOT NULL,
    `user_id` text NOT NULL,
    `name` text NOT NULL,
    `purpose` text,
    `start_date` integer NOT NULL,
    `end_date` integer,
    `start_odometer` real,
    `end_odometer` real,
    FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `Vehicle` (
    `id` text PRIMARY KEY NOT NULL,
    `user_id` text NOT NULL,
    `make` text NOT NULL,
    `model` text NOT NULL,
    `year` integer NOT NULL,
    `license_plate` text,
    `fuel_type` text,
    FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
ALTER TABLE `Car` RENAME TO `Attachment`;--> statement-breakpoint
ALTER TABLE `Attachment` RENAME COLUMN `make` TO `event_id`;--> statement-breakpoint
ALTER TABLE `Attachment` RENAME COLUMN `model` TO `expense_id`;--> statement-breakpoint
ALTER TABLE `Attachment` RENAME COLUMN `year` TO `user_id`;--> statement-breakpoint
ALTER TABLE `Attachment` RENAME COLUMN `color` TO `type`;--> statement-breakpoint
ALTER TABLE `Attachment` RENAME COLUMN `price` TO `url`;--> statement-breakpoint
ALTER TABLE `Attachment` RENAME COLUMN `mileage` TO `created_at`;--> statement-breakpoint
/*
 SQLite does not support "Drop not null from column" out of the box, we do not generate automatic migration for that, so it has to be done manually
 Please refer to: https://www.techonthenet.com/sqlite/tables/alter_table.php
                  https://www.sqlite.org/lang_altertable.html
                  https://stackoverflow.com/questions/2083543/modify-a-columns-type-in-sqlite3

 Due to that we don't generate migration automatically and it has to be done manually
*/--> statement-breakpoint
/*
 SQLite does not support "Changing existing column type" out of the box, we do not generate automatic migration for that, so it has to be done manually
 Please refer to: https://www.techonthenet.com/sqlite/tables/alter_table.php
                  https://www.sqlite.org/lang_altertable.html
                  https://stackoverflow.com/questions/2083543/modify-a-columns-type-in-sqlite3

 Due to that we don't generate migration automatically and it has to be done manually
*/--> statement-breakpoint
/*
 SQLite does not support "Set default to column" out of the box, we do not generate automatic migration for that, so it has to be done manually
 Please refer to: https://www.techonthenet.com/sqlite/tables/alter_table.php
                  https://www.sqlite.org/lang_altertable.html
                  https://stackoverflow.com/questions/2083543/modify-a-columns-type-in-sqlite3

 Due to that we don't generate migration automatically and it has to be done manually
*/--> statement-breakpoint
ALTER TABLE User ADD `name` text;--> statement-breakpoint
ALTER TABLE User ADD `created_at` integer DEFAULT (cast((julianday('now') - 2440587.5)*86400000 as integer)) NOT NULL;--> statement-breakpoint
CREATE UNIQUE INDEX `User_email_unique` ON `User` (`email`);--> statement-breakpoint
/*
 SQLite does not support "Creating foreign key on existing column" out of the box, we do not generate automatic migration for that, so it has to be done manually
 Please refer to: https://www.techonthenet.com/sqlite/tables/alter_table.php
                  https://www.sqlite.org/lang_altertable.html

 Due to that we don't generate migration automatically and it has to be done manually
*/--> statement-breakpoint
ALTER TABLE `Attachment` DROP COLUMN `fuelType`;--> statement-breakpoint
ALTER TABLE `Attachment` DROP COLUMN `transmission`;

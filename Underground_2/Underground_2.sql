DROP DATABASE IF EXISTS underground_2;

CREATE DATABASE IF NOT EXISTS underground_2;

USE underground_2;

DROP TABLE IF EXISTS type_of_race;
-- типы гонок
CREATE TABLE type_of_race(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	type_race VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS career;
-- количество гонок и этапов в карьере
CREATE TABLE career(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	race INT UNSIGNED NOT NULL,
	stage_of_race INT UNSIGNED NOT NULL,
	type_of_race INT UNSIGNED NOT NULL,
	monetary_reward DECIMAL(8,0) UNSIGNED NOT NULL,
	FOREIGN KEY (type_of_race) REFERENCES type_of_race(id)
);

DROP TABLE IF EXISTS profiles;
-- профиль пользователя
CREATE TABLE profiles(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	race_complete BIGINT UNSIGNED,
	cash DECIMAL(8,0) UNSIGNED NOT NULL,
	FOREIGN KEY (race_complete) REFERENCES career(id)
);

DROP TABLE IF EXISTS cars;
-- автомобили
CREATE TABLE cars(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	make VARCHAR(50) NOT NULL,
	model VARCHAR(100) UNIQUE NOT NULL,
	year_of_release YEAR NOT NULL,
	type_auto VARCHAR(50) NOT NULL,
	receiving VARCHAR(100) NOT NULL,
	need_to_complete_races BIGINT UNSIGNED,
	drive ENUM('FWD', 'AWD', 'RWD') NOT NULL,
	rating_accel FLOAT(2,1) NOT NULL,
	rating_top_speed FLOAT(2,1) NOT NULL,
	rating_handling FLOAT(2,1) NOT NULL,
	overclocking_0_60 FLOAT UNSIGNED NOT NULL,
	max_speed_mph FLOAT UNSIGNED NOT NULL,
	max_speed_kmh FLOAT UNSIGNED NOT NULL,
	FOREIGN KEY (need_to_complete_races) REFERENCES career(id)
);

DROP TABLE IF EXISTS shop;
-- магазины
CREATE TABLE shop(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	store_name VARCHAR(50) NOT NULL,
	store_color VARCHAR(50) UNIQUE NOT NULL,
	number_of_stores INT UNSIGNED NOT NULL
);

DROP TABLE IF EXISTS upgrades;
-- улучшения
CREATE TABLE upgrades(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	upgrade_name VARCHAR(50) NOT NULL,
	upgrade_type INT UNSIGNED NOT NULL,
	upgrade_cost DECIMAL(8,0) UNSIGNED NOT NULL,
	FOREIGN KEY (upgrade_type) REFERENCES shop(id)
);

DROP TABLE IF EXISTS technical_upgrade;
-- улучшения технической части
CREATE TABLE technical_upgrade(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	upgrade_name VARCHAR(50) NOT NULL,
	upgrade_type INT UNSIGNED NOT NULL DEFAULT 5,
	FOREIGN KEY (upgrade_type) REFERENCES shop(id)
);

DROP TABLE IF EXISTS technical_upgrade_level;
-- уровни улучшения технической части
CREATE TABLE technical_upgrade_level(
	id BIGINT UNSIGNED PRIMARY KEY,
	level_name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS technical_upgrade_cost;
-- цены улучшений технической части
CREATE TABLE technical_upgrade_cost(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	upgrade_type BIGINT UNSIGNED NOT NULL,
	upgrade_level BIGINT UNSIGNED NOT NULL,
	upgrade_cost DECIMAL(8,0) UNSIGNED NOT NULL,
	FOREIGN KEY (upgrade_type) REFERENCES technical_upgrade(id),
	FOREIGN KEY (upgrade_level) REFERENCES technical_upgrade_level(id)
);

DROP TABLE IF EXISTS profiles_cars;
-- машины пользователя
CREATE TABLE profiles_cars(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	profile_id BIGINT UNSIGNED NOT NULL,
	purchased_cars BIGINT UNSIGNED,
	FOREIGN KEY (profile_id) REFERENCES profiles(id),
	FOREIGN KEY (purchased_cars) REFERENCES cars(id)
);
	
DROP TABLE IF EXISTS purchased_upgrades;
-- купленные улучшения
CREATE TABLE purchased_upgrades(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	installed_on_the_car BIGINT UNSIGNED NOT NULL,
	upgrade BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (installed_on_the_car) REFERENCES profiles_cars(id),
	FOREIGN KEY (upgrade) REFERENCES upgrades(id)
);

DROP TABLE IF EXISTS purchased_technical_upgrades;
-- купленные технические улучшения
CREATE TABLE purchased_technical_upgrades(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	installed_on_the_car BIGINT UNSIGNED NOT NULL,
	upgrade BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (installed_on_the_car) REFERENCES profiles_cars(id),
	FOREIGN KEY (upgrade) REFERENCES technical_upgrade_cost(id)
);

DROP TABLE IF EXISTS cheats;
-- чит коды
CREATE TABLE cheats(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	сheat_code VARCHAR(50) NOT NULL,
	open_car BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (open_car) REFERENCES cars(id)
);


INSERT INTO type_of_race (type_race) VALUES 
	('Circuit race'),
	('Sprint race'),
	('Drifting'),
	('Drag racing'),
	('Street X'),
	('Underground Racing League (URL)'),
	('Special events'),
	('Outruns');

INSERT INTO career (race, stage_of_race, type_of_race, monetary_reward) VALUES 
(1, 1, 4, 300), (1, 2, 6, 300), (1, 3, 5, 300), (1, 4, 3, 300), (1, 5, 2, 1000), 
(2, 1, 7, 350), (2, 2, 6, 350), (2, 3, 3, 350), (2, 4, 8, 350), (2, 5, 8, 1000), 
(3, 1, 7, 400), (3, 2, 2, 400), (3, 3, 4, 400), (3, 4, 5, 400), (3, 5, 5, 1000), 
(4, 1, 5, 450), (4, 2, 8, 450), (4, 3, 7, 450), (4, 4, 5, 450), (4, 5, 8, 2000), 
(5, 1, 2, 500), (5, 2, 6, 500), (5, 3, 4, 500), (5, 4, 8, 500), (5, 5, 5, 2000), 
(6, 1, 7, 550), (6, 2, 1, 550), (6, 3, 3, 550), (6, 4, 6, 550), (6, 5, 1, 2000), 
(7, 1, 6, 600), (7, 2, 8, 600), (7, 3, 6, 600), (7, 4, 7, 600), (7, 5, 3, 3000), 
(8, 1, 6, 650), (8, 2, 2, 650), (8, 3, 5, 650), (8, 4, 1, 650), (8, 5, 3, 3000), 
(9, 1, 3, 700), (9, 2, 1, 700), (9, 3, 4, 700), (9, 4, 8, 700), (9, 5, 7, 3000), 
(10, 1, 7, 750), (10, 2, 6, 750), (10, 3, 2, 750), (10, 4, 4, 750), (10, 5, 5, 4000), 
(11, 1, 7, 800), (11, 2, 4, 800), (11, 3, 4, 800), (11, 4, 5, 800), (11, 5, 1, 4000), 
(12, 1, 8, 850), (12, 2, 2, 850), (12, 3, 6, 850), (12, 4, 6, 850), (12, 5, 3, 4000), 
(13, 1, 8, 900), (13, 2, 1, 900), (13, 3, 3, 900), (13, 4, 1, 900), (13, 5, 8, 5000), 
(14, 1, 2, 950), (14, 2, 2, 950), (14, 3, 8, 950), (14, 4, 1, 950), (14, 5, 4, 5000), 
(15, 1, 8, 1000), (15, 2, 5, 1000), (15, 3, 2, 1000), (15, 4, 8, 1000), (15, 5, 3, 5000), 
(16, 1, 4, 1050), (16, 2, 4, 1050), (16, 3, 8, 1050), (16, 4, 8, 1050), (16, 5, 8, 6000), 
(17, 1, 3, 1100), (17, 2, 4, 1100), (17, 3, 6, 1100), (17, 4, 7, 1100), (17, 5, 5, 6000);

INSERT INTO profiles VALUES (DEFAULT, 'Akimushka', 10, 19183);

INSERT INTO cars VALUES  
(DEFAULT, 'Acura', 'RSX Type S', 	2003, 'Stock', 'Complete stage', 28, 'FWD', 1.9, 2.0, 3.7, 6.51, 145, 233.4),
(DEFAULT, 'Audi', 'A3', 			2004, 'Stock', 'Complete stage', 33, 'AWD', 2.9, 3.0, 3.5, 6.32, 155, 249.4),
(DEFAULT, 'Audi', 'TT', 			2004, 'Stock', 'Complete stage', 38, 'AWD', 2.8, 3.0, 4.6, 6.34, 155, 249.4),
(DEFAULT, 'Cadillac', 'Escalade', 	2004, 'Stock', 'Complete stage', 2, 'AWD', 0.8, 0.6, 1.2, 8.58, 125, 201.2),
(DEFAULT, 'Ford', 'Focus ZX3', 		2003, 'Stock', 'Available from the beginning', NULL, 'FWD', 1.1, 0.7, 3.6, 8.71, 125, 201.2),
(DEFAULT, 'Ford', 'Mustang GT', 	2005, 'Stock', 'Complete stage', 69, 'RWD', 3.0, 3.0, 2.4, 4.68, 155, 249.4),
(DEFAULT, 'Honda', 'Civic Coupe Si', 2000, 'Stock', 'Available from the beginning', NULL, 'FWD', 1.2, 0.6, 3.8, 7.24, 127, 204.4),
(DEFAULT, 'Hummer', 'H2', 			2004, 'Stock', 'Complete stage', 7, 'AWD', 0.6, 0.6, 0.7, 10.95, 125, 201.2),
(DEFAULT, 'Hyundai', 'Tiburon GT', 	2003, 'Stock', 'Complete stage', 12, 'FWD', 1.7, 1.4, 3.2, 7.23, 137, 220.5),
(DEFAULT, 'Infiniti', 'G35', 		2004, 'Stock', 'Complete stage', 54, 'RWD', 3.0, 2.6, 3.0, 5.88, 151, 243),
(DEFAULT, 'Lexus', 'iS300', 		2002, 'Stock', 'Complete stage', 23, 'RWD', 2.2, 1.5, 2.8, 7.1, 139, 223.7),
(DEFAULT, 'Lincoln', 'Navigator', 	2004, 'Stock', 'Complete stage', 2, 'RWD', 0.6, 0.6, 0.6, 9.45, 125, 201.2),
(DEFAULT, 'Mazda', 'Miata - MX5', 	1999, 'Stock', 'Available from the beginning', NULL, 'RWD', 1.2, 0.6, 4.3, 7.73, 125, 201.2),
(DEFAULT, 'Mazda', 'RX-7', 			1995, 'Stock', 'Complete stage', 49, 'RWD', 3.3, 3.0, 3.9, 4.9, 155, 249.4),
(DEFAULT, 'Mazda', 'RX-8', 			2004, 'Stock', 'Complete stage', 44, 'RWD', 3.0, 2.4, 4.3, 5.97, 148, 238.2),
(DEFAULT, 'Mitsubishi', '3000 GT', 	1999, 'Stock', 'Complete stage', 59, 'AWD', 3.3, 3.3, 3.6, 5.73, 159, 255.9),
(DEFAULT, 'Mitsubishi', 'Eclipse GSX', 1999, 'Stock', 'Complete stage', 38, 'AWD', 1.9, 1.4, 3.7, 6.6, 137, 220.5),
(DEFAULT, 'Mitsubishi', 'Lancer EVO VIII', 2003, 'Stock', 'Complete stage', 74, 'AWD', 3.4, 3.0, 4.5, 4.06, 155, 249.4),
(DEFAULT, 'Nissan', '240sx', 		1993, 'Stock', 'Available from the beginning', NULL, 'RWD', 1.5, 0.7, 3.7, 8.33, 130, 209.2),
(DEFAULT, 'Nissan', '350Z', 		2003, 'Stock', 'Complete stage', 44, 'RWD', 3.6, 3.0, 3.3, 6.16, 155, 249.4),
(DEFAULT, 'Nissan', 'Sentra SE-R Spec V', 2003, 'Stock', 'Complete stage', 12, 'FWD', 1.6, 1.2, 2.8, 7.33, 135, 217.3),
(DEFAULT, 'Nissan', 'Skyline R34 GTR', 1999, 'Stock', 'Complete stage', 80, 'AWD', 2.8, 3.0, 5.4, 5.22, 155, 249.4),
(DEFAULT, 'Peugeot', '106', 		2004, 'Stock', 'Available from the beginning', NULL, 'FWD', 1.3, 1.6, 4.2, 8.23, 141, 226.9),
(DEFAULT, 'Peugeot', '206 GTI',		2003, 'Stock', 'Available from the beginning', NULL, 'FWD', 1.5, 0.6, 3.5, 8.32, 125, 201.2),
(DEFAULT, 'Pontiac', 'GTO', 		2004, 'Stock', 'Complete stage', 64, 'RWD', 3.2, 3.0, 2.2, 4.97, 155, 249.4),
(DEFAULT, 'Subaru', 'Impreza WRX', 	2004, 'Stock', 'Complete stage', 85, 'AWD', 4.0, 3.3, 3.5, 5.01, 155, 249.4),
(DEFAULT, 'Toyota', 'Celica GT-S', 	2003, 'Stock', 'Complete stage', 17, 'RWD', 2.4, 0.7, 3.6, 8.53, 125, 201.2),
(DEFAULT, 'Toyota', 'Corolla GTS (AE86)', 1986, 'Stock', 'Available from the beginning', NULL, 'RWD', 0.7, 0.7, 3.8, 6.53, 150, 241.4),
(DEFAULT, 'Vauxall', 'Corsa 1.8', 	2005, 'Stock', 'Available from te beginning', NULL, 'FWD', 1.2, 1.4, 4.1, 8.05, 138, 222.1),
(DEFAULT, 'Volkswagen', 'Golf GTI', 2003, 'Stock', 'Available from the beginning', NULL, 'FWD', 1.7, 0.8, 2.8, 6.6, 131, 210.8),
(DEFAULT, 'Cadillac', 'Escalade "Snoop Dogg"', 2005, 'Sponsor', 'Apply a cheat code at the Start Menu', NULL, 'AWD', 0.8, 0.6, 1.2, 8.58, 125, 201.2),
(DEFAULT, 'Hummer', 'H2 "Capone"', 	2005, 'Sponsor', 'Apply a cheat code at the Start Menu', NULL, 'AWD', 0.6, 0.6, 0.7, 10.95, 125, 201.2),
(DEFAULT, 'Infiniti', 'G35 "Japan Tuning"', 2005, 'Sponsor', 'Apply a cheat code at the Start Menu', NULL, 'RWD', 3.0, 2.6, 3.0, 5.88, 151, 243),
(DEFAULT, 'Lexus', 'IS 300 "Shine Street"', 2005, 'Sponsor', 'Apply a cheat code at the Start Menu', NULL, 'RWD', 2.2, 1.5, 2.8, 7.1, 139, 223.7),
(DEFAULT, 'Lincoln', 'Navigator "Chingy"', 2003, 'Sponsor', 'Apply a cheat code at the Start Menu', NULL, 'RWD', 0.6, 0.6, 0.6, 9.45, 125, 201.2),
(DEFAULT, 'Mitsubishi', 'Eclipse "D3"', 1999, 'Sponsor', 'Apply a cheat code at the Start Menu', NULL, 'AWD', 1.9, 1.4, 3.7, 6.6, 137, 220.5),
(DEFAULT, 'Pontiac', 'GTO "Te Doors"', 2004, 'Sponsor', 'Apply a cheat code at the Start Menu', NULL, 'RWD', 3.2, 3.0, 2.2, 4.97, 155, 249.4),
(DEFAULT, 'Toyota', 'Corolla GT-S "David Choe"', 1987, 'Sponsor', 'Apply a cheat code at the Start Menu', NULL, 'RWD', 0.7, 0.7, 3.8, 6.53, 150, 241.4);

INSERT INTO shop VALUES 
	(DEFAULT, 'BODY SHOP', 'Green', 6),
	(DEFAULT, 'GRAPHICS SHOP', 'Red', 4),
	(DEFAULT, 'CARS', 'Сyan', 3),
	(DEFAULT, 'CAR SPECIALTIES SHOP', 'Yellow', 4),
	(DEFAULT, 'PERFORMANCE SHOP', 'Blue', 5),
	(DEFAULT, 'GARAGE', 'Violet', 2);

INSERT INTO upgrades (upgrade_name, upgrade_type, upgrade_cost) VALUES 
	('Carbon Fiber', 1, 1800),
	('Exhaust Tips', 1, 600),
	('Front Bumpers', 1, 1600),
	('Headlights', 1, 600),
	('Hoods', 1, 800),
	('Rear Bumpers', 1, 1600),
	('Rims', 1, 800),
	('Roof Scoops', 1, 1000),
	('Side Mirrors', 1, 400),
	('Side Skirts', 1, 1600),
	('Spoilers', 1, 1200),
	('Taillights', 1, 600),
	('Wide Body Kits', 1, 6000),
	('Decals', 2, 400),
	('Paint', 2, 800),
	('Vinyls', 2, 1200),
	('Custom Gauges', 4, 400),
	('Doors', 4, 1600),
	('Hydraulics', 4, 1600),
	('Lights', 4, 600),
	('Neons', 4, 1000),
	('Nitrous Purge', 4, 600),
	('Spinners', 4, 800),
	('Split Hoods', 4, 800),
	('Trunk Audio', 4, 1200),
	('Window Tint', 4, 400);

INSERT INTO technical_upgrade (upgrade_name) VALUES
	('Brakes'),
	('ECU'),
	('Engine'),
	('Nitrous Oxide'),
	('Suspension'),
	('Transmission'),
	('Turbo'),
	('Tyres'),
	('Weight Reduction');

INSERT INTO technical_upgrade_level VALUES (0, 'Stock'), (1, 'Street'), (2, 'Pro'), (3, 'Extreme');

INSERT INTO technical_upgrade_cost (upgrade_type, upgrade_level, upgrade_cost) VALUES 
(1, 0, 0), (1, 1, 900), (1, 2, 1400), (1, 3, 1900), 
(2, 0, 0), (2, 1, 1150), (2, 2, 1650), (2, 3, 2150), 
(3, 0, 0), (3, 1, 1000), (3, 2, 1500), (3, 3, 2000), 
(4, 0, 0), (4, 1, 900), (4, 2, 1400), (4, 3, 1900), 
(5, 0, 0), (5, 1, 1000), (5, 2, 1500), (5, 3, 2000), 
(6, 0, 0), (6, 1, 1250), (6, 2, 1750), (6, 3, 2250), 
(7, 0, 0), (7, 1, 750), (7, 2, 1250), (7, 3, 1750), 
(8, 0, 0), (8, 1, 750), (8, 2, 1250), (8, 3, 1750);
INSERT INTO profiles_cars VALUES 
	(DEFAULT, 1, 19),
	(DEFAULT, 1, 23);
	
INSERT INTO purchased_upgrades VALUES 
	(DEFAULT, 1, 12),
	(DEFAULT, 1, 10),
	(DEFAULT, 1, 15),
	(DEFAULT, 1, 16),
	(DEFAULT, 1, 3),
	(DEFAULT, 1, 22);

INSERT INTO cheats (сheat_code, open_car) VALUES 
	('opendoors', 37),
	('yodogg', 31),
	('wannacapone', 32),
	('shinestreetbright', 34),
	('gimmechingy', 35),
	('wantmyd3', 36),
	('davidchoeart', 38),
	('tunejapantuning', 33);

-- Триггер на максимальное количество машин в гараже (5)
DROP TRIGGER IF EXISTS count_profiles_cars;
DELIMITER //
CREATE TRIGGER count_profiles_cars
BEFORE INSERT ON profiles_cars
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM profiles_cars) >= 5 THEN
    DELETE FROM profiles_cars WHERE id = (SELECT MIN(id) FROM profiles_cars);
  END IF;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS purchased_technical_upgrades_procedure;
DELIMITER //
CREATE PROCEDURE purchased_technical_upgrades_procedure()
BEGIN
	DECLARE i INT;
	IF (SELECT count(*) FROM profiles_cars) > 0 THEN 
		SET i = 1;
		WHILE i < (SELECT count(*) FROM technical_upgrade_cost) DO
	      	INSERT INTO purchased_technical_upgrades VALUES (DEFAULT, 1, (i));
	    	SET i = i + 4;
	   	END WHILE;
  	END IF;
END//
DELIMITER ;
CALL purchased_technical_upgrades_procedure();


CREATE OR REPLACE VIEW rating_cars AS
SELECT make, model, (rating_accel + rating_top_speed + rating_handling) rating FROM cars ORDER BY rating DESC LIMIT 5;

CREATE OR REPLACE VIEW number_of_races_in_the_game AS
SELECT tor.type_race, count(*) FROM career c 
JOIN type_of_race tor ON c.type_of_race = tor.id 
GROUP BY c.type_of_race;

CREATE OR REPLACE VIEW the_cost_of_the_maximum_car_upgrade AS
SELECT (SELECT SUM(upgrade_cost) FROM technical_upgrade_cost WHERE upgrade_level = 3) + (SELECT SUM(upgrade_cost) FROM upgrades) AS summ;

CREATE OR REPLACE VIEW installed_improvements_on_existing_cars AS
(SELECT c.make, c.model, u.upgrade_name, NULL AS level_name, s.store_name FROM purchased_upgrades pu 
	JOIN upgrades u ON pu.upgrade = u.id
	JOIN shop s ON u.upgrade_type = s.id
	JOIN profiles_cars pc ON pu.installed_on_the_car = pc.id
	JOIN cars c ON pc.purchased_cars = c.id ORDER BY s.store_name)
UNION 
(SELECT c.make, c.model, tu.upgrade_name, tul.level_name, s.store_name FROM purchased_technical_upgrades ptu 
	JOIN profiles_cars pc ON ptu.installed_on_the_car = pc.id
	JOIN cars c ON pc.purchased_cars = c.id
	JOIN technical_upgrade_cost tuc ON ptu.upgrade = tuc.id
	JOIN technical_upgrade tu ON tuc.upgrade_type = tu.id
	JOIN technical_upgrade_level tul ON tuc.upgrade_level = tul.id
	JOIN shop s ON tu.upgrade_type = s.id);
-- ---------------- --
-- DIMENSION TABLES 
-- ---------------- --

CREATE TABLE "AircraftDimension"
(
    "aircraftID" VARCHAR(6),
    aircraft_model VARCHAR(14) NOT NULL,
    manufacturer VARCHAR(6) NOT NULL,
    PRIMARY KEY ("aircraftID")
);

CREATE TABLE "TemporalDimension"
(
    "dateID" VARCHAR(10),
    "month" INT NOT NULL,
    "year" INT NOT NULL,
    PRIMARY KEY ("dateID")
);

CREATE TABLE "AirportDimension"
(
    "reporteurID" INT,
    reporteurclass VARCHAR(5) NOT NULL,
    airport VARCHAR(3) NOT NULL,
    PRIMARY KEY ("reporteurID")
);


-- ---------------- --
-- FACT TABLES
-- ---------------- --

CREATE TABLE "AircraftUtilizationMetrics"
(
    "aircraftID" VARCHAR(6),
    "dateID" VARCHAR(10),
    flight_hours_count FLOAT NOT NULL,
    take_offs_count INT NOT NULL,
    delay_count INT NOT NULL,
    delay_min_count FLOAT NOT NULL,
    cancelled_count INT NOT NULL,
    days_in_service FLOAT NOT NULL,
    days_out_of_service_scheduled FLOAT NOT NULL,
    days_out_of_service_unscheduled FLOAT NOT NULL,
    PRIMARY KEY ("aircraftID", "dateID"),
);

-- ALTER TABLE "AircraftUtilizationMetrics"
-- DROP CONSTRAINT "aircraftID";

-- ALTER TABLE "AircraftUtilizationMetrics"
-- DROP CONSTRAINT "dateID";

ALTER TABLE "AircraftUtilizationMetrics"
ADD CONSTRAINT "aircraftID"
FOREIGN KEY ("aircraftID")
REFERENCES "AircraftDimension"("aircraftID");

ALTER TABLE "AircraftUtilizationMetrics"
ADD CONSTRAINT "dateID"
FOREIGN KEY ("dateID")
REFERENCES "TemporalDimension"("dateID");


CREATE TABLE "LogBookMetrics"
(
    "aircraftID" VARCHAR(6),
    "dateID" VARCHAR(10),
    "reporteurID" INT,
    logbook_count INT NOT NULL,
    PRIMARY KEY ("aircraftID", "dateID", "reporteurID"),
)

-- ALTER TABLE "LogBookMetrics"
-- DROP CONSTRAINT "aircraftID";

-- ALTER TABLE "LogBookMetrics"
-- DROP CONSTRAINT "dateID";

-- ALTER TABLE "LogBookMetrics"
-- DROP CONSTRAINT "reporteurID";

ALTER TABLE "LogBookMetrics"
ADD CONSTRAINT "aircraftID"
FOREIGN KEY ("aircraftID")
REFERENCES "AircraftDimension"("aircraftID");

ALTER TABLE "LogBookMetrics"
ADD CONSTRAINT "dateID"
FOREIGN KEY ("dateID")
REFERENCES "TemporalDimension"("dateID");

ALTER TABLE "LogBookMetrics"
ADD CONSTRAINT "reporteurID"
FOREIGN KEY ("reporteurID")
REFERENCES "AirportDimension"("reporteurID");
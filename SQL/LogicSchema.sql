------------------------------------------------------------------------
-- Logical Schema
------------------------------------------------------------------------

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
    days_out_of_service_scheduled FLOAT NOT NULL,
    days_out_of_service_unscheduled FLOAT NOT NULL,
    PRIMARY KEY ("aircraftID", "dateID"),
    FOREIGN KEY ("aircraftID") REFERENCES "AircraftDimension"("aircraftID"),
    FOREIGN KEY ("dateID") REFERENCES "TemporalDimension"("dateID")
);


CREATE TABLE "LogBookMetrics"
(
    "aircraftID" VARCHAR(6),
    "dateID" VARCHAR(10),
    "reporteurID" INT,
    pilot_logbook_count INT NOT NULL,
    maintenance_logbook_count INT NOT NULL,
    PRIMARY KEY ("aircraftID", "dateID", reporteourID),
    FOREIGN KEY ("aircraftID") REFERENCES "AircraftDimension"(airctaftID),
    FOREIGN KEY ("dateID") REFERENCES "TemporalDimension"("dateID"),
    FOREIGN KEY ("reporteurID") REFERENCES "AirportDimension"("reporteurID")
)
------------------------------------------------------------------------
-- Logical Schema
------------------------------------------------------------------------

-- ---------------- --
-- FACT TABLES
-- ---------------- --

CREATE TABLE AircraftUtilizationMetrics
(
    aircraftID CHAR(6),
    timeID DATE,
    flight_hours INT,
    take_offs INT,
    delay_count INT,
    cancellation_count INT,
    days_out_of_service_schedule INT,
    days_out_of_service_unschedule INT,
    days_in_service INT,
    PRIMARY KEY (aircraftID, timeID),
    FOREIGN KEY (aircraftID) REFERENCES AircraftDimension(ID),
    FOREIGN KEY (timeID) REFERENCES TemporalDimension(ID)
);


CREATE TABLE LogBookMetrics
(
    aircraftID CHAR(6),
    timeID DATE,
    airportID CHAR(3),
    pilot_logbook_count INT,
    manintenance_logbook_count INT,
    PRIMARY KEY (aircraftID, timeID),
    FOREIGN KEY (aircraftID) REFERENCES AircraftDimension(ID),
    FOREIGN KEY (timeID) REFERENCES TemporalDimension(ID),
    FOREIGN KEY (airportID) REFERENCES AirportDimension(ID)
)

-- ---------------- --
-- DIMENSION TABLES 
-- ---------------- --

CREATE TABLE AircraftDimension
(
    ID CHAR(6),
    aircraft_model VARCHAR2(100) NOT NULL,
    manufacturer VARCHAR2(100) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE TemporalDimension
(
    ID DATE,
    month NUMBER(2) NOT NULL,
    year NUMBER(4) NOT NULL,
    PRIMARY KEY (ID),
);

CREATE TABLE AirportDimension
(
    ID CHAR(3),
    airport CHAR(3),
    PRIMARY KEY (ID)
);
CREATE TABLE AircraftUtilization (
    aircraftID CHAR(6),
    timeID DATE,
    flightHours NUMBER(2),  -- FH
    flightCycles NUMBER(2), -- TO
    PRIMARY KEY (aircraftID, timeID),
    FOREIGN KEY (aircraftID) REFERENCES AircraftDimension(ID),
    FOREIGN KEY (timeID) REFERENCES TemporalDimension(ID)
);

CREATE TABLE b (

)


-- ---------------- --
-- DIMENSION TABLES
-- ---------------- --

CREATE TABLE AircraftDimension (
    ID CHAR(6),
    model VARCHAR2(100) NOT NULL,
    manufacturer VARCHAR2(100) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE TemporalDimension (
    ID DATE,
    day NUMBER(2) NOT NULL,
    month CHAR(7) NOT NULL,
    year NUMBER(4) NOT NULL,
    PRIMARY KEY (ID),
);

CREATE TABLE AirportDimension (
    ID CHAR(3),
    airport VARCHAR2(100) NOT NULL,
    PRIMARY KEY (ID)
);
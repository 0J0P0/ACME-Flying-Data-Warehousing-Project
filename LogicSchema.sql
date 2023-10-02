CREATE TABLE AircraftUtilization (
    aircraftID CHAR(6),
    timeID DATE,
    flightHours NUMBER(2),
    flightCycles NUMBER(2),
    PRIMARY KEY (aircraftID, timeID),
    FOREIGN KEY (aircraftID) REFERENCES AircraftDimension(ID),
    FOREIGN KEY (timeID) REFERENCES TemporalDimension(ID)
);

CREATE TABLE AircraftDimension (
    ID CHAR(6),
    model VARCHAR2(100) NOT NULL,
    manufacturer VARCHAR2(100) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE TemporalDimension (
    ID DATE,
    month CHAR(7) NOT NULL,
    year NUMBER(4) NOT NULL,
    PRIMARY KEY (ID),
);
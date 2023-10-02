CREATE TABLE AircraftUtilization (
    aircraftID CHAR(6),
    timeID DATE,
    flightHours NUMBER(2),  -- FH
    flightCycles NUMBER(2), -- TO
    PRIMARY KEY (aircraftID, timeID),
    FOREIGN KEY (aircraftID) REFERENCES AircraftDimension(ID),
    FOREIGN KEY (timeID) REFERENCES TemporalDimension(ID)
);

CREATE TABLE AircraftUtilization2 (
    aircraftID CHAR(6),
    timeID DATE,  -- aqui el timeID solo considera mes y año
    ADIS INTEGER,
    ADOS INTEGER,
    ADOSS INTEGER,
    ADOSU INTEGER,
    DYR INTEGER, -- DY/TO
    CNR INTEGER, -- CN/TO
    TDR INTEGER, -- 100 – ((DY + CN) / TO) x 100
    ADD INTEGER, -- (Sum of delay duration > 15 minutes and < 6 hours / Nbr of delay duration> 15 minutes and < 6 hours) x 100
    PRIMARY KEY (aircraftID, timeID),
    FOREIGN KEY (aircraftID) REFERENCES AircraftDimension(ID),
    FOREIGN KEY (timeID) REFERENCES TemporalDimension(ID)
)

CREATE TABLE LogBook (
    aircraftID CHAR(6),
    timeID DATE,
    RRh INTEGER,   -- 1000 x (logbook count)/(total flight-hours)
    RRc INTEGER,  -- 100 x (logbook count)/(total departures)
    PRRh INTEGER,  -- 1000 x (Pilot logbook count)/(total flight-hours)
    PRRc INTEGER,  -- 100 x (Pilot logbook count)/(total departures)
    MRRh INTEGER,  -- 1000 x (Maintenance logbook count)/(total flight-hours)
    MRRc INTEGER,  -- 100 x (Maintenance logbook count)/(total departures)
    PRIMARY KEY (aircraftID, timeID),
    FOREIGN KEY (aircraftID) REFERENCES AircraftDimension(ID),
    FOREIGN KEY (timeID) REFERENCES TemporalDimension(ID)
)


-- Se podria eliminar y añadir la dimension de aeropuerto a la tabla de logbook y hacer una vista para calcular los MRRR por separado
CREATE TABLE MAREP (
    airportID CHAR(3),
    aircraftID CHAR(6),
    MRRh INTEGER,  -- 1000 x (Maintenance logbook count)/(total flight-hours)
    MRRc INTEGER,  -- 100 x (Maintenance logbook count)/(total departures)
    PRIMARY KEY (airportID, aircraftID),
    FOREIGN KEY (airportID) REFERENCES AirportDimension(ID),
    FOREIGN KEY (aircraftID) REFERENCES AircraftDimension(ID)
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
    day NUMBER(2) NOT NULL,  -- se tiene que añadir o crear otra tabla para el día de la semana
    month CHAR(7) NOT NULL,
    year NUMBER(4) NOT NULL,
    PRIMARY KEY (ID),
);

CREATE TABLE AirportDimension (
    ID CHAR(3),
    airport VARCHAR2(100) NOT NULL,
    PRIMARY KEY (ID)
);
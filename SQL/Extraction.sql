------------------------------------------------------------------------
-- Extraction sql script
------------------------------------------------------------------------

-- ---------------- --
-- FACT TABLES
-- ---------------- --
-- AircraftUtilizationMetrics
SELECT f.aircraftregistration,
        CAST(f.actualdeparture AS DATE) AS timeID,  -- se asume que actualdeparture es el timeID
        f.scheduleddeparture,
        f.scheduledarrival,
        f.actualdeparture,
        f.actualarrival,
        f.delaycode
FROM flights f
-- f.kind, es redundante porque en flights todos son tipo flight
-- f.cancelled, igual es redundante si sabemos que cuando no es null, actualdeparture y actualarrival son null
-- los delaycode que no son null o '', se asumiran como que no hay delay

SELECT m.aircraftregistration,
        CAST(m.actualdeparture AS DATE) AS timeID,  -- se asume que actualdeparture es el timeID
        m.scheduleddeparture AS scheduledmaintenancestart,
        m.scheduledarrival AS scheduledmaintenanceend,
        m.programmed
FROM maintenance m
-- f.kind, es redundante porque en main todos son tipo main
-- f.cancelled, igual es redundante si sabemos que cuando no es null, actualdeparture y actualarrival son null

-- LogBookMetrics
SELECT t.aircraftregistration,
        t.executiondate AS timeID, -- time es cuando se ejecuta o cuando se registra?????
        t.reporteurid,  -- reporteur id para linkar con la tabla de aeropuertos
        t.reporteurclass 
FROM technicallogbookorders t


-- ---------------- --
-- DIMENSION TABLES
-- ---------------- --

-- AircraftDimension
SELECT a.aircraft_reg_code as 
        a.aircraft_model,
        a.manufacturer
FROM aircrafts a

-- TemporalDimension
SELECT  CAST(f.actualdeparture AS DATE) AS ID,  -- se asume que actualdeparture es el timeID
        EXTRACT(DAY FROM f.actualdeparture) AS day,
        EXTRACT(MONTH FROM f.actualdeparture) AS month,
        EXTRACT(YEAR FROM f.actualdeparture) AS year
FROM flights f

SELECT  CAST(m.scheduleddeparture AS DATE) AS ID,  -- se asume que scheduleddeparture es el timeID
        EXTRACT(DAY FROM m.scheduleddeparture) AS day,
        EXTRACT(MONTH FROM m.scheduleddeparture) AS month,
        EXTRACT(YEAR FROM m.scheduleddeparture) AS year
FROM maintenance m

SELECT t.executiondate AS ID, -- time es cuando se ejecuta o cuando se registra?????
        EXTRACT(DAY FROM t.executiondate) AS day,
        EXTRACT(MONTH FROM t.executiondate) AS month,
        EXTRACT(YEAR FROM t.executiondate) AS year
FROM technicallogbookorders t

-- AirportDimension
SELECT a.reporteurid,
        a.airport
FROM airports a

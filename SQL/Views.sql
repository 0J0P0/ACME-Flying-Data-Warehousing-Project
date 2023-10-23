------------------------------------------------------------------------
-- Views
------------------------------------------------------------------------

-- DROP VIEW IF EXISTS "LogBookMetricsView";
CREATE OR REPLACE VIEW "LogBookMetricsView" AS (
    SELECT a."aircraftID",
            a.aircraft_model,
            a.manufacturer,
            t.month,
            t.year,
            ad.airport,
            ad.reporteurclass,
            aum.flight_hours_count,
            aum.take_offs_count,
            aum.cancelled_count,
            lbm.logbook_count
    FROM "AircraftUtilizationMetrics" aum, "LogBookMetrics" lbm, "AircraftDimension" a, "TemporalDimension" t, "AirportDimension" ad
    WHERE a."aircraftID" = aum."aircraftID" AND t."dateID" = aum."dateID" AND ad."reporteurID" = lbm."reporteurID"
);

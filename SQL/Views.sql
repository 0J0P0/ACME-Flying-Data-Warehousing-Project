------------------------------------------------------------------------
-- Views
------------------------------------------------------------------------

CREATE VIEW "LogBookMetricsView" AS (
    SELECT a."aircraftID",
            a."aircraft_model",
            a."manufacturer",
            t.month,
            t.year,
            ad.airport,
            1000 * (lbm.pilot_logbook_count + lbm.maintenance_logbook_count) / aum.flight_hours_count AS "RRh",
            100 * (lbm.pilot_logbook_count + lbm.maintenance_logbook_count) / aum.take_offs_count AS "RRc",
            1000 * (lbm.pilot_logbook_count) / aum.flight_hours_count AS "PRRh",
            100 * (lbm.pilot_logbook_count) / aum.take_offs_count AS "PRRc",
            1000 * (lbm.maintenance_logbook_count) / aum.flight_hours_count AS "MRRh",
            100 * (lbm.maintenance_logbook_count) / aum.take_offs_count AS "MRRc"
    FROM "AircraftUtilizationMetrics" aum, "LogBookMetrics" lbm, "AircraftDimension" a, "TemporalDimension" t, "AirportDimension" ad
    WHERE a."aircraftID" = aum."aircraftID" AND t."dateID" = aum."dateID" AND ad."reporteurID" = lbm."reporteurID"
) WITH CHECK OPTION;

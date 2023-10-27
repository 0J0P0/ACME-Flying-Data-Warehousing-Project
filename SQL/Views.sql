-- DROP MATERIALIZED VIEW IF EXISTS "AircraftUtilizationMetricsView";
CREATE MATERIALIZED VIEW "AircraftUtilizationMetricsView" AS
(
    SELECT a."aircraftID",
    a.aircraft_model,
    a.manufacturer,
    t."dateID",
    t.month,
    t.year,
    aum.flight_hours_count,
    aum.take_offs_count,
    aum.delay_count,
    aum.delay_min_count,
    aum.cancelled_count,
    aum.days_in_service,
    aum.days_out_of_service_scheduled,
    aum.days_out_of_service_unscheduled
FROM "AircraftUtilizationMetrics" aum, "AircraftDimension" a, "TemporalDimension" t
WHERE a."aircraftID" = aum."aircraftID" AND t."dateID" = aum."dateID"
)


-- DROP MATERIALIZED VIEW IF EXISTS "LogBookMetricsView";
CREATE MATERIALIZED VIEW "LogBookMetricsView" AS
(
    SELECT aumv."aircraftID",
    aumv.aircraft_model,
    aumv.manufacturer,
    aumv.month,
    aumv.year,
    ad.airport,
    ad.reporteurclass,
    aumv.flight_hours_count,
    aumv.take_offs_count,
    lbm.logbook_count
FROM "AircraftUtilizationMetricsView" aumv, "LogBookMetrics" lbm, "AirportDimension" ad
WHERE ad."reporteurID" = lbm."reporteurID" AND aumv."dateID" = lbm."dateID" AND aumv."aircraftID" = lbm."aircraftID"
);


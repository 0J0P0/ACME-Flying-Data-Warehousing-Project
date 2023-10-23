------------------------------------------------------------------------
-- Queries
------------------------------------------------------------------------

-- Give me FH and TO per aircraft (also per model) per day (also per month and per year)
SELECT a."aircraftID",
        t."dateID",
        ROUND(SUM(aum.flight_hours_count / 60)::NUMERIC, 4) AS flight_hours,
        SUM(aum.take_offs_count) AS take_offs
FROM "AircraftUtilizationMetrics" aum, "AircraftDimension" a, "TemporalDimension" t
WHERE a."aircraftID" = aum."aircraftID" AND t."dateID" = aum."dateID"
GROUP BY a."aircraftID", t."dateID"
ORDER BY a."aircraftID", t."dateID";



-- Give me ADIS, ADOS, ADOSS, ADOSU, DYR, CNR, TDR, ADD per aircraft (also per model) per month (also per year)
SELECT a."aircraftID",
        t."month",
        ROUND(SUM(aum.days_in_service / 1440)::NUMERIC, 4) AS "ADIS",
        ROUND(SUM(aum.days_out_of_service_scheduled + aum.days_out_of_service_unscheduled)::NUMERIC, 4) AS "ADOS",
        ROUND(SUM(aum.days_out_of_service_scheduled)::NUMERIC, 4) AS "ADOSS",
        ROUND(SUM(aum.days_out_of_service_unscheduled)::NUMERIC, 4) AS "ADOSU",
        CASE
                WHEN SUM(aum.take_offs_count) > 0
                THEN 100 * SUM(aum.delay_count)/SUM(aum.take_offs_count)
                ELSE 0
        END AS "DYR",
        CASE
                WHEN SUM(aum.take_offs_count) > 0
                THEN 100 * SUM(aum.cancelled_count)/SUM(aum.take_offs_count)
                ELSE 0
        END AS "CNR",
        CASE
                WHEN SUM(aum.take_offs_count) > 0
                THEN 100 * (100 - (SUM(aum.delay_count) + SUM(aum.cancelled_count))/SUM(aum.take_offs_count))
                ELSE 0
        END AS "TDR",
        CASE
                WHEN SUM(aum.delay_count) > 0
                THEN ROUND((100 * SUM(aum.delay_min_count)/SUM(aum.delay_count))::NUMERIC, 4)
                ELSE 0
        END AS "ADD"
FROM "AircraftUtilizationMetrics" aum, "AircraftDimension" a, "TemporalDimension" t
WHERE a."aircraftID" = aum."aircraftID" AND t."dateID" = aum."dateID"
GROUP BY a."aircraftID", t."month"
ORDER BY a."aircraftID", t."month";     


-- c) Give me the RRh, RRc, PRRh, PRRc, MRRh and MRRc per aircraft (also per model and manufacturer) per month (also per year)
SELECT lbmv."aircraftID",
        lbmv.month,
        CASE
                WHEN SUM(lbmv.flight_hours_count) > 0
                THEN 1000 * SUM(lbmv.logbook_count)/SUM(lbmv.flight_hours_count)
                ELSE 0
        END AS "RRh",
        CASE
                WHEN SUM(lbmv.take_offs_count) > 0
                THEN 100 * SUM(lbmv.logbook_count)/SUM(lbmv.take_offs_count)
                ELSE 0
        END AS "RRc",
        CASE
                WHEN SUM(lbmv.flight_hours_count) > 0
                THEN 1000 * SUM(lbmv.logbook_count*(lbmv.reporteurclass='PIREP')::INTEGER)/SUM(lbmv.flight_hours_count)
                ELSE 0
        END AS "PRRh",
        CASE
                WHEN SUM(lbmv.take_offs_count) > 0
                THEN 100 * SUM(lbmv.logbook_count*(lbmv.reporteurclass='PIREP')::INTEGER)/SUM(lbmv.take_offs_count)
                ELSE 0
        END AS "PRRc",
        CASE
                WHEN SUM(lbmv.flight_hours_count) > 0
                THEN 1000 * SUM(lbmv.logbook_count*(lbmv.reporteurclass='MAREP')::INTEGER)/SUM(lbmv.flight_hours_count)
                ELSE 0
        END AS "MRRh",
        CASE
                WHEN SUM(lbmv.take_offs_count) > 0
                THEN 100 * SUM(lbmv.logbook_count*(lbmv.reporteurclass='MAREP')::INTEGER)/SUM(lbmv.take_offs_count)
                ELSE 0
        END AS "MRRc"
FROM "LogBookMetricsView" lbmv
GROUP BY lbmv."aircraftID", lbmv.month
ORDER BY lbmv."aircraftID", lbmv.month;


-- Give me the MRRh and MRRc per airport of the reporting person per aircraft (also per model)
SELECT lbmv."aircraftID",
        lbmv.airport,
        CASE
                WHEN SUM(lbmv.flight_hours_count) > 0 AND lbmv.reporteurclass = 'MAREP'
                THEN 1000 * SUM(lbmv.logbook_count)/SUM(lbmv.flight_hours_count)
                ELSE 0
        END AS "MRRh",
        CASE
                WHEN SUM(lbmv.take_offs_count) > 0 AND lbmv.reporteurclass = 'MAREP'
                THEN 100 * SUM(lbmv.logbook_count)/SUM(lbmv.take_offs_count)
                ELSE 0
        END AS "MRRc"
FROM "LogBookMetricsView" lbmv
GROUP BY lbmv."aircraftID", lbmv.airport
ORDER BY lbmv."aircraftID", lbmv.airport;
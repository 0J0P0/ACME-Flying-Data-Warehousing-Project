-- a) Give me FH and TO per aircraft (also per model) per day (also per month and per year)
SELECT aumv."aircraftID",
        aumv."dateID",
        ROUND(SUM(aumv.flight_hours_count / 60)::NUMERIC, 4) AS flight_hours,
        SUM(aumv.take_offs_count) AS take_offs
FROM "AircraftUtilizationMetricsView" aumv
GROUP BY aumv."aircraftID", aumv."dateID"
ORDER BY aumv."aircraftID", aumv."dateID";



-- b) Give me ADIS, ADOS, ADOSS, ADOSU, DYR, CNR, TDR, ADD per aircraft (also per model) per month (also per year)
SELECT aumv."aircraftID",
        aumv."month",
        ROUND(SUM(aumv.days_in_service / (24*60))::NUMERIC, 4) AS "ADIS",
        ROUND(SUM(aumv.days_out_of_service_scheduled + aumv.days_out_of_service_unscheduled)::NUMERIC, 4) AS "ADOS",
        ROUND(SUM(aumv.days_out_of_service_scheduled)::NUMERIC, 4) AS "ADOSS",
        ROUND(SUM(aumv.days_out_of_service_unscheduled)::NUMERIC, 4) AS "ADOSU",
        CASE
                WHEN SUM(aumv.take_offs_count) > 0
                THEN 100 * SUM(aumv.delay_count)/SUM(aumv.take_offs_count)
                ELSE 0
        END AS "DYR",
        CASE
                WHEN SUM(aumv.take_offs_count) > 0
                THEN 100 * SUM(aumv.cancelled_count)/SUM(aumv.take_offs_count)
                ELSE 0
        END AS "CNR",
        CASE
                WHEN SUM(aumv.take_offs_count) > 0
                THEN 100 * (100 - (SUM(aumv.delay_count) + SUM(aumv.cancelled_count))/SUM(aumv.take_offs_count))
                ELSE 0
        END AS "TDR",
        CASE
                WHEN SUM(aumv.delay_count) > 0
                THEN ROUND((100 * SUM(aumv.delay_min_count)/SUM(aumv.delay_count))::NUMERIC, 4)
                ELSE 0
        END AS "ADD"
FROM "AircraftUtilizationMetricsView" aumv
GROUP BY aumv."aircraftID", aumv."month"
ORDER BY aumv."aircraftID", aumv."month";     


-- c) Give me the RRh, RRc, PRRh, PRRc, MRRh and MRRc per aircraft (also per model and manufacturer) per month (also per year)
SELECT lbmv."manufacturer",
        lbmv.month,
        CASE
                WHEN SUM(lbmv.flight_hours_count) > 0
                THEN ROUND((1000 * SUM(lbmv.logbook_count)/SUM(lbmv.flight_hours_count))::NUMERIC, 4)
                ELSE 0
        END AS "RRh",
        CASE
                WHEN SUM(lbmv.take_offs_count) > 0
                THEN 100 * SUM(lbmv.logbook_count)/SUM(lbmv.take_offs_count)
                ELSE 0
        END AS "RRc",
        CASE
                WHEN SUM(lbmv.flight_hours_count) > 0
                THEN  ROUND(((1000 * SUM(lbmv.logbook_count*(lbmv.reporteurclass='PIREP')::INTEGER)/SUM(lbmv.flight_hours_count))::NUMERIC), 4)
                ELSE 0
        END AS "PRRh",
        CASE
                WHEN SUM(lbmv.take_offs_count) > 0
                THEN  100 * SUM(lbmv.logbook_count*(lbmv.reporteurclass='PIREP')::INTEGER)/SUM(lbmv.take_offs_count)
                ELSE 0
        END AS "PRRc",
        CASE
                WHEN SUM(lbmv.flight_hours_count) > 0
                THEN  ROUND(((1000 * SUM(lbmv.logbook_count*(lbmv.reporteurclass='MAREP')::INTEGER)/SUM(lbmv.flight_hours_count))::NUMERIC), 4)
                ELSE 0
        END AS "MRRh",
        CASE
                WHEN SUM(lbmv.take_offs_count) > 0
                THEN 100 * SUM(lbmv.logbook_count*(lbmv.reporteurclass='MAREP')::INTEGER)/SUM(lbmv.take_offs_count)
                ELSE 0
        END AS "MRRc"
FROM "LogBookMetricsView" lbmv
GROUP BY lbmv."manufacturer", lbmv.month
ORDER BY lbmv."manufacturer", lbmv.month;


-- d) Give me the MRRh and MRRc per airport of the reporting person per aircraft (also per model)
SELECT lbmv."aircraftID",
        lbmv.airport,
        CASE
                WHEN SUM(lbmv.flight_hours_count) > 0
                THEN ROUND((1000 * SUM(lbmv.logbook_count)/SUM(lbmv.flight_hours_count))::NUMERIC, 4)
                ELSE 0
        END AS "MRRh",
        CASE
                WHEN SUM(lbmv.take_offs_count) > 0
                THEN 100 * SUM(lbmv.logbook_count)/SUM(lbmv.take_offs_count)
                ELSE 0
        END AS "MRRc"
FROM "LogBookMetricsView" lbmv
WHERE lbmv.reporteurclass = 'MAREP'
GROUP BY lbmv."aircraftID", lbmv.airport
ORDER BY lbmv."aircraftID", lbmv.airport;
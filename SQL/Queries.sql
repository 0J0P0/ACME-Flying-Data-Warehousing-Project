------------------------------------------------------------------------
-- Queries
------------------------------------------------------------------------

-- Give me FH and TO per aircraft (also per model) per day (also per month and per year)
SELECT a."aircraftID",
        t."dateID",
        SUM(aum.flight_hours_count) AS flight_hours,
        SUM(aum.take_offs_count) AS take_offs
FROM "AircraftUtilizationMetrics" aum, "AircraftDimension" a, "TemporalDimension" t
WHERE a."aircraftID" = aum."aircraftID" AND t."dateID" = aum."dateID"
GROUP BY a."aircraftID", t."dateID"
ORDER BY a."aircraftID", t."dateID";



-- Give me ADIS, ADOS, ADOSS, ADOSU, DYR, CNR, TDR, ADD per aircraft (also per model) per month (also per year)
SELECT a."aircraftID",
        t."month",
        SUM(24 - (aum.days_out_of_service_scheduled + aum.days_out_of_service_unscheduled)) AS "ADIS",
        SUM(aum.days_out_of_service_scheduled + aum.days_out_of_service_unscheduled) AS "ADOS",
        SUM(aum.days_out_of_service_scheduled) AS "ADOSS",
        SUM(aum.days_out_of_service_unscheduled) AS "ADOSU",
        AVG((aum.delay_count/aum.take_offs_count)*100) AS "DYR",
        AVG((aum.cancelled_count/aum.take_offs_count)*100) AS "CNR",
        AVG((100 - ((aum.delay_count + aum.cancelled_count)/aum.take_offs_count))*100) AS "TDR",
        AVG((aum.delay_min_count/aum.delay_count)*100) AS "ADD"
FROM "AircraftUtilizationMetrics" aum, "AircraftDimension" a, "TemporalDimension" t
WHERE a."aircraftID" = aum."aircraftID" AND t."dateID" = aum."dateID" AND aum.take_offs_count > 0 AND aum.delay_count > 0
GROUP BY a."aircraftID", t."month"
ORDER BY a."aircraftID", t."month";


-- COMO FUNCIONAN LAS QUERIES SI NO HEMOS DEFINIDO LAS FK?

-- Give me the RRh, RRc, PRRh, PRRc, MRRh and MRRc per aircraft (also per model and manufacturer) per month (also per year)
SELECT lbmv."aircraftID",
        lbmv.month,
        SUM(lbmv."RRh"),
        SUM(lbmv."RRc"),
        SUM(lbmv."PRRh"),
        SUM(lbmv."PRRc"),
        SUM(lbmv."MRRh"),
        SUM(lbmv."MRRc")
FROM "LogBookMetricsView" lbmv
GROUP BY lbmv."aircraftID", lbmv.month
ORDER BY lbmv."aircraftID", lbmv.month;


-- Give me the MRRh and MRRc per airport of the reporting person per aircraft (also per model)
SELECT lbmv."aircraftID",
        lbmv."airport",
        SUM(lbmv."MRRh"),
        SUM(lbmv."MRRc")
FROM "LogBookMetricsView" lbmv
GROUP BY lbmv."aircraftID", lbmv."airport"
ORDER BY lbmv."aircraftID", lbmv."airport";
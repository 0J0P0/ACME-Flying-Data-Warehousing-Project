CREATE VIEW b
AS
  (
  SELECT a.ID, t.ID,
    SUM(aum.days_in_service) AS ADIS,
    SUM(aum.days_out_of_service_schedule+aum.days_out_of_service_unschedule) AS ADOS,
    SUM(aum.days_out_of_service_schedule) as ADOSS,
    SUM(aum.days_out_of_service_unschedule) as ADOSU,
    SUM(aum.delay_count/aum.take_offs_count) * 100 AS DYR,
    SUM(aum.cancellation_count/aum.take_offs_count) * 100 AS CNR,
    SUM(100-((aum.delay_count+aum.cancellation_count)/aum.take_offs_count)*100) AS TDR
  -- SUM(aum.delay_count) AS ADD
  FROM AircraftDimension a, TemporalDimension t, AircraftUtilizationMetrics aum
  WHERE a.ID = aum.aircraftID AND t.ID = aum.timeID
  GROUP BY a.ID, t.ID
  ORDER BY a.ID, t.ID
) WITH CHECK OPTION;
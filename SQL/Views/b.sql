CREATE VIEW b
AS
  (
  SELECT a.ID, t.ID, SUM(m.days_in_service), SUM(m.days_out_of_service_schedule+m.days_out_of_service_unschedule) AS ADOS, SUM(m.days_out_of_service_schedule), SUM(m.days_out_of_service_unschedule), SUM(m.delay_count/m.take_offs_count) * 100 AS DYR, SUM(m.cancellation_count/m.take_offs_count) * 100 AS CNR, SUM(100-((m.delay_count+m.cancellation_count)/m.take_offs_count)*100) AS TDR, 
  -- SUM(m.delay_count) AS ADD
  FROM AircraftDimension a, TemporalDimension t, miketowers m
  WHERE a.ID = m.aircraftID AND t.ID = m.timeID
  GROUP BY a.ID, t.ID
  ORDER BY a.ID, t.ID
) WITH CHECK OPTION;
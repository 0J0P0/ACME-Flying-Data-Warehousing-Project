CREATE VIEW c
AS
  (
  SELECT a.ID, t.ID,
    SUM()*1000 as RRh,
    SUM()*1000 as RRc,
    SUM()*1000 as PRRh,
    SUM()*1000 as PRRc,
    SUM()*1000 as MRRh,
    SUM()*1000 as MRRc
  FROM AircraftDimension a, TemporalDimension t, AircraftUtilizationMetrics aum
  WHERE a.ID = aum.aircraftID AND t.ID = aum.timeID
  GROUP BY a.ID, t.ID
  ORDER BY a.ID, t.ID
) WITH CHECK OPTION;

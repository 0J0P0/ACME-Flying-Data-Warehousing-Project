------------------------------------------------------------------------
-- Give FO and TO per aircraft (also per model) 
-- per day (also per month and per year)
------------------------------------------------------------------------

-- como afinar a cuando se busca por meses, años, etc?
CREATE VIEW a
AS
    (
    SELECT a.ID, t.ID, SUM(aum.flight_hours_count), SUM(aum.take_offs_count)
    FROM AircraftDimension a, TemporalDimension t, AircraftUtilizationMetrics aum
    WHERE a.ID = aum.aircraftID AND t.ID = aum.timeID
    GROUP BY a.ID, t.ID
    ORDER BY a.ID, t.ID
) WITH CHECK OPTION;



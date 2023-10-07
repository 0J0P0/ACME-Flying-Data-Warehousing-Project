------------------------------------------------------------------------
-- Views
------------------------------------------------------------------------

-- como afinar a cuando se busca por meses, años, etc?
CREATE VIEW a
AS
    (
    SELECT a.ID, t.ID, SUM(m.flight_hours_count), SUM(m.take_offs_count)
    FROM AircraftDimension a, TemporalDimension t, AircraftUtilizationMetrics
    WHERE a.ID = m.aircraftID AND t.ID = m.timeID
    GROUP BY a.ID, t.ID
    ORDER BY a.ID, t.ID
) WITH CHECK OPTION;



-- Give me FH and TO per aircraft (also per model) per day (also per month and per year)
SELECT a.ID, t.ID, SUM(table.FH), SUM(table.TO)
FROM AircraftDimension a, TemporalDimension t, Table table
WHERE a.ID = table.aircraftID AND t.ID = table.timeID
GROUP BY a.ID, t.ID
ORDER BY a.ID, t.ID;


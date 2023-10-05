-- FH (flight hours) = flights.actualarrival - flights.actualdeparture

-- TO (take offs) = COUNT(flights.actualdeparture)
-- TO (take offs) = COUNT(flights.cancelled == FALSE)

-- ADOS (aircraft days out of service) = SUM(ADOSS) + SUM(ADOSU)

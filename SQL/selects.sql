  select aircraftregistration,
    scheduleddeparture,
    scheduledarrival,
    kind,
    actualdeparture,
    actualarrival,
    cancelled,
    delaycode
  FROM flights
UNION
  select scheduleddeparture,
    scheduledarrival,
    programmed
  from maintenance 
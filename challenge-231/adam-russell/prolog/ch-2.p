passenger_senior(Passenger, Senior):-
    length(AgeSeat, 4),
    length(Age, 2),
    atom_chars(Passenger, PassengerChars),
    suffix(AgeSeat, PassengerChars),
    prefix(Age, AgeSeat),
    number_chars(A, Age),
    ((A >= 60, Senior = 1); Senior = 0).

count_senior_citizens(Passengers, CountSeniorCitizens):-
    maplist(passenger_senior, Passengers, SeniorCitizens), !,
    sum_list(SeniorCitizens, CountSeniorCitizens).

  
  day_month_year(S, Day, Month, Year):-
      append(Y, [45|T], S),
      append(M, [45|D], T),
      number_codes(Day, D),
      number_codes(Month, M),
      number_codes(Year, Y).

  
  leap_year(Year):-
      M1 is Year mod 4,
      M2 is Year mod 100,
      M3 is Year mod 400,
      ((M1 == 0, \+ M2 == 0);
       (M1 == 0, M2 == 0, M3 == 0)).

  
  february_days(Year, Days):-
      leap_year(Year),
      Days = 29.
  february_days(_, Days):-
      Days = 28.

  
  day_of_year(Date, DayOfYear) :-
      day_month_year(Date, Day, Month, Year),
      february_days(Year, FebruaryDays),
      DaysInMonth = [31, FebruaryDays, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
      succ(M, Month),
      length(Prefix, M),
      prefix(Prefix, DaysInMonth),
      sum_list(Prefix, MonthSum),
      DayOfYear is MonthSum + Day.


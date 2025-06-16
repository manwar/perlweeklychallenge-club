-module(ch1).
-export([day_of_the_year/1]).

-spec day_of_the_year(string()) -> non_neg_integer().
day_of_the_year(DateStr) ->
  {ok,[Year,Month,Day],_} = io_lib:fread("~d-~d-~d",DateStr),
  Date = {Year,Month,Day},
  calendar:date_to_gregorian_days(Date) -
    calendar:date_to_gregorian_days(Year,1,1) + 1.


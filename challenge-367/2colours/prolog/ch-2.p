:- use_module(library(dcg/basics)).

time(Absolute_Minutes) --> integer(Hours), `:`, integer(Minutes), { Absolute_Minutes is Hours * 60 + Minutes }.

within_minutes(Start, End, Value) :- Start < End, Start < Value, Value < End.
within_minutes(Start, End, Value) :- Start > End, \+ between(End, Start, Value).

task(Event1, Event2) :-
        maplist(maplist([Time_String, Time_Minutes]>>(string_codes(Time_String, Time_Codes), phrase(time(Time_Minutes), Time_Codes))), [Event1, Event2], [[SM1, EM1], [SM2, EM2]]),
        once(within_minutes(SM1, EM1, SM2) ; within_minutes(SM1, EM1, EM2) ; within_minutes(SM2, EM2, SM1) ; within_minutes(SM2, EM2, EM1)).

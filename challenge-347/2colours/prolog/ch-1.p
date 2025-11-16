:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).
:- use_module(library(clpfd)).


year(Year) --> { Year in 1900..2100 }, integer(Year).

month(1) --> `Jan`.
month(2) --> `Feb`.
month(3) --> `Mar`.
month(4) --> `Apr`.
month(5) --> `May`.
month(6) --> `Jun`.
month(7) --> `Jul`.
month(8) --> `Aug`.
month(9) --> `Sep`.
month(10) --> `Oct`.
month(11) --> `Nov`.
month(12) --> `Dec`.

sdigit(D) --> { D in 0'1..0'9 }, digit(D).
digit_ending(0'0) --> `0th`.
digit_ending(0'1) --> `1st`.
digit_ending(0'2) --> `2nd`.
digit_ending(0'3) --> `3rd`.
digit_ending(D) --> { D in 0'4..0'9 }, digit(D), `th`.

day_raw([D]) --> digit_ending(D).
day_raw([D1, D2]) --> sdigit(D1), digit_ending(D2).

day(Day) --> day_raw(DR), { number_codes(Day, DR), Day in 1..31 }.

anglo_date(Year, Month, Day) --> day(Day), ` `, month(Month), ` `, year(Year).


task(Str, Result) :-
        string_codes(Str, Str_Codes),
        phrase(anglo_date(Year, Month, Day), Str_Codes),
        format_to_chars('~d-~|~`0t~d~2+-~|~`0t~d~2+', [Year, Month, Day], Result_Chars),
        string_chars(Result, Result_Chars).

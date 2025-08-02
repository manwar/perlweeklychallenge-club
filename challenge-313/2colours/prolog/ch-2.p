:- use_module(library(dcg/high_order)).

repeated_char(Char-Min_Amount) --> { Min_Amount > 0, length(Mandatory, Min_Amount), maplist(=(Char), Mandatory) }, Mandatory, repeated_char(Char-0).
repeated_char(_Char-0) --> [].
repeated_char(Char-0) --> [Char], repeated_char(Char-0).

flip_alpha([Before_Head|Before_Tail], Before_Reversed, [Before_Head|After_Tail], After_Reversed) :-
    \+ is_alpha(Before_Head),
    !,
    flip_alpha(Before_Tail, Before_Reversed, After_Tail, After_Reversed).

flip_alpha(Before, [Before_Reversed_Head|Before_Reversed_Tail], After, [Before_Reversed_Head|After_Reversed_Tail]) :-
    \+ is_alpha(Before_Reversed_Head),
    !,
    flip_alpha(Before, Before_Reversed_Tail, After, After_Reversed_Tail).

flip_alpha([Before_Head|Before_Tail], [Before_Reversed_Head|Before_Reversed_Tail], [Before_Reversed_Head|After_Tail], [Before_Head|After_Reversed_Tail]) :-
    !,
    flip_alpha(Before_Tail, Before_Reversed_Tail, After_Tail, After_Reversed_Tail).

flip_alpha([], [], [], []).

task2(Str, Solution) :-
    string_chars(Str, Str_Chars),
    reverse(Str_Chars, Str_Chars_Rev),
    flip_alpha(Str_Chars, Str_Chars_Rev, Solution_Chars, _),
    string_chars(Solution, Solution_Chars).

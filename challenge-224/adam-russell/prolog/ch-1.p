special_notes(_, []). 
special_notes(Source, Target):-
    [H|S] = Source,
    (select(H, Target, T); T = Target),
    special_notes(S, T), !. 

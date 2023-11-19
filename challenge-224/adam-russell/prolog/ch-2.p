:-dynamic(path/2). 

substrings(S, Substrings):-
    partial_substrings(S, Substrings). 
partial_substrings([], []). 
partial_substrings(S, Substrings):-
    length(S, L), 
    findall(Prefix,(
        between(1, L, K),
        length(Prefix, K),
        prefix(Prefix, S)
    ), PartialSubstrings),
    [_|TS] = S,  
    partial_substrings(TS, NextSubstrings),
    Substrings = [PartialSubstrings|NextSubstrings].   

additive_number(Number):-
    substrings(Number, Substrings),
    nl.  
 

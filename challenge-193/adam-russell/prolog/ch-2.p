string_differences(String, Differences):-
    atom_codes(String, Codes),
    string_differences(Codes, [], Differences).
string_differences([_|[]], Differences, Differences).   
string_differences([C0, C1|T], DifferenceAccum, Differences):-
    Difference is C1 - C0,
    string_differences([C1|T], [Difference|DifferenceAccum], Differences).

odd_string(Strings, OddString):-
    maplist(string_differences, Strings, Differences),
    member(Difference, Differences),
    delete(Differences, Difference, UpdatedDifferences),
    length(UpdatedDifferences, UpdatedDifferencesLength),
    UpdatedDifferencesLength > 1,
    nth(N, Differences, Difference),
    nth(N, Strings, OddString).
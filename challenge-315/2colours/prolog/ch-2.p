task2(Sentence, First, Second, Output) :-
    split_string(Sentence, " ", " ", Words),
    findall(Third, append([_Beginning, [First, Second, Third], _End], Words), Output).

build_uniq_assoc(Value, Assoc_Before, Assoc_After) :- 
        put_assoc(Value, Assoc_Before, Valid_After, Assoc_After),
        (get_assoc(Value, Assoc_Before, _Valid_Before) ->
                Valid_After = false ;
                Valid_After = true).

task1(Words1, Words2, Nr_Common_Once) :-
        empty_assoc(E),
        maplist([Words, Result_Assoc]>>foldl(build_uniq_assoc, Words, E, Result_Assoc), [Words1, Words2], [Unique_Assoc1, Unique_Assoc2]),
        findall([Word], (
                gen_assoc(Word, Unique_Assoc1, Valid1),
                get_assoc(Word, Unique_Assoc2, Valid2),
                Valid1 == true,
                Valid2 == true
                ),
                Good_Words),
        length(Good_Words, Nr_Common_Once).

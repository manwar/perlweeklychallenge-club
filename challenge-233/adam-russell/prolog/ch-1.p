similar(A, B, Similar):-
    atom_codes(A, ACodes),
    sort(ACodes, ASorted),
    atom_codes(B, BCodes),
    sort(BCodes, BSorted),
    (ASorted = BSorted, Similar = 1);
    Similar = 0.

count_similar_pairs([], 0).
count_similar_pairs([Word|Words], PairsSimilar):-
    count_similar_pairs(Words, P), 
    maplist(similar(Word), Words, Similar), !,
    sum_list(Similar, SimilarCount),
    PairsSimilar is P + SimilarCount.
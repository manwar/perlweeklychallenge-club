make_pairs(K, V, K-V).

sort_language(Languages, Popularity, SortedLanguages):-
    maplist(make_pairs, Popularity, Languages, PopularityLanguages),
    keysort(PopularityLanguages, SortedPopularityLanguages),
    findall(Language,  member(_-Language, SortedPopularityLanguages), SortedLanguages).
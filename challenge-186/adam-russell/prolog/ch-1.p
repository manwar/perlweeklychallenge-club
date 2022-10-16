zip([], [], []).
zip([Ha|Ta], [Hb|Tb], [Ha, Hb|Tc]):-
    zip(Ta, Tb, Tc).
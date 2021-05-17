:-initialization(main).

steps --> [].
steps --> step, steps.
step  --> [0]; [1]; [2].

sum_steps(Steps, Goal):-
    length(Steps, Goal),
    phrase(steps, Steps),
    sum_list(Steps, Goal).

zero_remove([], []).
zero_remove([H|T], [ZR_H|ZR_T]):-
    delete(H, 0, ZR_H),
    zero_remove(T, ZR_T).

main:-
    findall(Steps, sum_steps(Steps, 4), S),
    zero_remove(S, SZR),
    sort(SZR, SZR_Unique),
    write(SZR_Unique), nl,
    halt.

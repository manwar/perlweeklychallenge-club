/*
* Demonstrate Stack operations.
*/
:-initialization(main).

new_stack([]).

push(Stack, Value, [Value|Stack]).

pop([H|T], H, T).

top([H|_], H).

min(Stack, Min):-
    min_list(Stack, Min).

main:-
    new_stack(Stack),
    push(Stack, 2, NewStack0),
    push(NewStack0, -1, NewStack1),
    push(NewStack1, 0, NewStack2),
    pop(NewStack2, Top0, NewStack3),
    write(Top0), nl,
    top(NewStack3, Top1),
    write(Top1), nl,
    push(NewStack3, 0, NewStack4),
    min(NewStack4, Min),
    write(Min), nl,
    halt.
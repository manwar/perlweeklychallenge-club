%%
% Part 1 
%%
minimum_time(S, MinimumTime):-
    append([97], S, S0),
    phrase(minimum_time(S0), Times),
    sum_list(Times, MinimumTime), !.

compute_moves(Current, Next, Moves):-
    X is Current - 96,
    Y is Next - 96,
    XH is X + 13,
    YH is Y + 13,
    ((Y >= XH, Moves is X + 26 - Y);
     (Y >= X, Y =< XH, Moves is Y - X);
     (X >= YH, Moves is Y + 26 - X);
     (X >= Y, X =< YH, Moves is X - Y)).

minimum_time([Current, Next|Letters]) --> [Time], {
    compute_moves(Current, Next, Moves),
    succ(Moves, Time)}, minimum_time([Next|Letters]).
minimum_time([_]) --> [].

%%
% Part 2
%%
full_boxes(BallsBoxes, CountFullBoxes):-
    phrase(box_record(BallsBoxes), [_], [Boxes]),
    maplist(full_box, Boxes, Full), 
    delete(Full, false, FullBoxes),
    length(FullBoxes, CountFullBoxes), !.
    
full_box(_-Colors, Full):-
    sort(Colors, ColorsSorted),
    length(ColorsSorted, NumberColors),
    ((NumberColors == 3, Full = true);
     (Full = false)).

boxes(Boxes), [Boxes] --> [Boxes].
boxes(Box, Boxes), [Boxes] --> [Box].

box_record([]) --> [].
box_record(Record) --> boxes(B, Boxes), {[Color, Box|T] = Record, 
    var(B), B = Box-[Color], append([], [B], Boxes)},
    box_record(T).
box_record(Record) --> boxes(B, Boxes), {[Color, Box|T] = Record, 
    nonvar(B), member(Box-Colors, B), delete(B, Box-Colors, B0),
    append([Color], Colors, Colors0), append([Box-Colors0], B0, Boxes)},
    box_record(T).
box_record(Record) --> boxes(B, Boxes), {[Color, Box|T] = Record, 
    nonvar(B), \+ member(Box-_, B), append([Box-[Color]], B, Boxes)},
    box_record(T).
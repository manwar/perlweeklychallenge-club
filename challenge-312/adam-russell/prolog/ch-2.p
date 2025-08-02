
  
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

  
  full_box(_-Colors, Full):-
      sort(Colors, ColorsSorted),
      length(ColorsSorted, NumberColors),
      ((NumberColors == 3, Full = true);
       (Full = false)).

  full_boxes(BallsBoxes, CountFullBoxes):-
      phrase(box_record(BallsBoxes), [_], [Boxes]),
      maplist(full_box, Boxes, Full), 
      delete(Full, false, FullBoxes),
      length(FullBoxes, CountFullBoxes), !.

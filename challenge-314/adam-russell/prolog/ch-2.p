
  
  column(I, L, Column):-
      maplist(nth(I), L, Column).

  
  sort_column(Strings, Removals):-
      last(Strings, S),
      length(S, L),
      findall(R, (
          between(1, L, I),
          column(I, Strings, Column),
          msort(Column, ColumnSorted),
          \+ Column == ColumnSorted,
          R = Column
      ), Rs),
      length(Rs, Removals).


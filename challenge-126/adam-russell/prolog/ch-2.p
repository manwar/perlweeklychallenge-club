:-initialization(main).

rows(5).
columns(10).
grid([x, '*', '*', '*', x, '*', x, x, x, x, 
      '*', '*', '*', '*', '*', '*', '*', '*', '*', x,  
      '*', '*', '*', '*', x, '*', x, '*', x, '*',   
      '*', '*', '*', x, x, '*', '*', '*', '*', '*',
       x, '*', '*', '*', x, '*', '*', '*', '*', x]).

write_grid([H|T]):-
    write('\t'),
    write_grid([H|T], 0).
write_grid([], _).    
write_grid([H|T], Counter):-
    columns(Columns),
    succ(Counter, C),
    M is C mod Columns,
    M \== 0,
    write(H),
    write(' '),
    write_grid(T, C).
write_grid([H|T], Counter):-
    columns(Columns),
    C is Counter + 1,
    M is C mod Columns,
    M == 0,
    write(H),
    ((rows(Rows),
      columns(Columns),
      Cells is Rows * Columns,
      C \== Cells,
      nl,
      write('\t'),
      write_grid(T, C)
     );
     (
      write_grid(T, C)
    )).

minecount(List, MineCount):-
    minecount(List, 0, MineCount).
minecount([], MineCount, MineCount).
minecount([H|T], MineCountPartial, MineCount):-  
    H == x,
    MCP is MineCountPartial + 1,
    minecount(T, MCP, MineCount).
minecount([H|T], MineCountPartial, MineCount):-  
    H \== x,
    minecount(T, MineCountPartial, MineCount).

adjacent_bottomleft(Cell, Grid, AdjacentCell):-
    columns(Columns),
    Columns1 is Columns - 1,
    C is Cell + Columns1,
    C > 0,
    M0 is Cell mod Columns,
    M1 is C mod Columns,
    ((M0 \== 0, M0 \==1, M1 < M0);
     (M0 == 0, M1 == Columns1)),
    nth(C, Grid, AdjacentCell).
adjacent_bottomleft(_, _, AdjacentCell):-
    AdjacentCell = null.
    
adjacent_left(Cell, Grid, AdjacentCell):-
    columns(Columns),
    Columns1 is Columns - 1,
    C is Cell - 1,
    C > 0,
    M0 is Cell mod Columns,
    M1 is C mod Columns,
    ((M0 \== 0, M0 \==1, M1 < M0);
     (M0 == 0, M1 == Columns1)),
    nth(C, Grid, AdjacentCell).
adjacent_left(_, _, AdjacentCell):-
    AdjacentCell = null.   
    
adjacent_topleft(Cell, Grid, AdjacentCell):-
    columns(Columns),
    Columns1 is Columns - 1,
    C is Cell - (Columns + 1),
    C > 0,
    M0 is Cell mod Columns,
    M1 is C mod Columns,
    ((M0 \== 0, M0 \==1, M1 < M0);
     (M0 == 0, M1 == Columns1)),
    nth(C, Grid, AdjacentCell).
adjacent_topleft(_, _, AdjacentCell):-
    AdjacentCell = null.  
    
adjacent_bottomright(Cell, Grid, AdjacentCell):-
    columns(Columns),
    Columns1 is Columns - 1,
    C is Cell + (Columns + 1),
    C > 0,
    M0 is Cell mod Columns,
    M1 is C mod Columns,
    ((M1 > M0, M0 \== 0);
     (M1 == 0, M0 == Columns1)),
    nth(C, Grid, AdjacentCell).
adjacent_bottomright(_, _, AdjacentCell):-
    AdjacentCell = null.          
       
adjacent_right(Cell, Grid, AdjacentCell):-
    columns(Columns),
    Columns1 is Columns - 1,
    C is Cell + 1,
    C > 0,
    M0 is Cell mod Columns,
    M1 is C mod Columns,
    ((M1 > M0, M0 \== 0);
     (M1 == 0, M0 == Columns1)),
    nth(C, Grid, AdjacentCell).
adjacent_right(_, _, AdjacentCell):-
    AdjacentCell = null.
    
adjacent_topright(Cell, Grid, AdjacentCell):-
    columns(Columns),
    Columns1 is Columns - 1,
    C is Cell - Columns1,
    M0 is Cell mod Columns,
    M1 is C mod Columns,
    ((M1 > M0, M0 \== 0);
     (M1 == 0, M0 == Columns1)),
    nth(C, Grid, AdjacentCell).
adjacent_topright(_, _, AdjacentCell):-
    AdjacentCell = null.    
    
adjacent_up(Cell, Grid, AdjacentCell):-
    columns(Columns),
    C is Cell - Columns,
    C > 0,
    nth(C, Grid, AdjacentCell).
adjacent_up(_, _, AdjacentCell):-
    AdjacentCell = null.    
    
adjacent_down(Cell, Grid, AdjacentCell):-
    columns(Columns),
    C is Cell + Columns,
    C > 0,
    nth(C, Grid, AdjacentCell).
adjacent_down(_, _, AdjacentCell):-
    AdjacentCell = null. 
    
adjacent(Cell, Grid, AdjacentCells):-
    adjacent_left(Cell, Grid, AdjacentCellLeft),
    adjacent_right(Cell, Grid, AdjacentCellRight),
    adjacent_up(Cell, Grid, AdjacentCellUp),
    adjacent_down(Cell, Grid, AdjacentCellDown),
    adjacent_topleft(Cell, Grid, AdjacentCellTopLeft),
    adjacent_topright(Cell, Grid, AdjacentCellTopRight),
    adjacent_bottomleft(Cell, Grid, AdjacentCellBottomLeft),
    adjacent_bottomright(Cell, Grid, AdjacentCellBottomRight),
    AdjacentCells = [AdjacentCellLeft, AdjacentCellRight, AdjacentCellUp, AdjacentCellDown,
                     AdjacentCellTopLeft, AdjacentCellTopRight, AdjacentCellBottomLeft, 
                     AdjacentCellBottomRight],!.

make_grid(Grid, NewGrid):-
    make_grid(Grid, 1, [], NewGrid). 
make_grid(Grid, Counter, NewGridPartial, NewGrid):-
    nth(Counter, Grid, CurrentCell),
    CurrentCell \== x,
    adjacent(Counter, Grid, AdjacentCells),
    minecount(AdjacentCells, MineCount),
    append(NewGridPartial, [MineCount], NGP),
    ((rows(Rows),
      columns(Columns),
      Cells is Rows * Columns,
      Counter == Cells, 
      !,
      NewGrid = NGP
    );
     (succ(Counter, C),
      make_grid(Grid, C, NGP, NewGrid))).
make_grid(Grid, Counter, NewGridPartial, NewGrid):-
    nth(Counter, Grid, CurrentCell),
    CurrentCell == x,
    append(NewGridPartial, [CurrentCell], NGP),
    ((rows(Rows),
      columns(Columns),
      Cells is Rows * Columns,
      Counter == Cells, 
      !,
      NewGrid = NGP
    );
     (succ(Counter, C),
      make_grid(Grid, C, NGP, NewGrid))).   

main:-
    grid(Grid),
    write('Input:'), nl,
    write_grid(Grid), nl,
    make_grid(Grid, NewGrid),
    write('Output:'), nl,
    write_grid(NewGrid), nl,
    halt.
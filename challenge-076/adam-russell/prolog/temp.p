word_grid([
	["B","I","D","E","M"],
	["L","D","E","G","G"],
	["U","S","E","I","R"],
	["N","G","N","I","Z"],
	["T","G","M","I","D"],
	["S","R","E","N","M"],
	["S","C","S","H","A"],
	["H","W","O","V","L"]
]).
 
read_word(InStream,W):- 
    get_code(InStream,Char), 
	check_char_read(Char,Chars,InStream), 
	atom_codes(W,Chars). 
    
check_char_read(10,[],_):-  !. 

check_char_read(32,[],_):-  !. 

check_char_read(-1,[],_):-  !. 

check_char_read(end_of_file,[],_):-  !. 

check_char_read(Char,[Char|Chars],InStream):- 
	 get_code(InStream,NextChar), 
	 check_char_read(NextChar,Chars,InStream).
         
read_file(S, []):-
    at_end_of_stream(S).
read_file(S, end_of_stream):-
    at_end_of_stream(S).
read_file(S, [H|T]):-
    \+ at_end_of_stream(S),
    read_word(S, H),
    read_file(S, T).    

row_length([H|_], Columns):-
    length(H, Columns).
    %Columns is 19.
    
column([H|T], Counter, C, Value):-
    C0 is Counter + 1,
    C0 == C,
    Value is H;
    C0 is Counter + 1,
    column(T, C0, C, Value).

column_values([], _, _, Values, Values).    
column_values([L|T], C, Columns, ValAccum, Values):-
    C0 is C + 1,
    C0 =< Columns,
    column(L, 0, C0, Value),
    column_values(T, C0, Columns, [Value | ValAccum], Values);
    C0 is C + 1, C0 > Columns, column_values([], C0, Columns, ValAccum, Values).  
    
diagonals([H|T], SubDiagonals):-
    row_length([H|T], Columns),
    diagonals([H|T], 0, Columns, [], SubDiagonals).

diagonals([], _, _, Diagonals, Diagonals).
diagonals([H|T], C, Columns, DiagAccum, SubDiagonals):-
    column_values([H|T], C, Columns, [], D),
    C0 is C + 1,
    C0 =< Columns,
    diagonals([H|T], C0, Columns, [D|DiagAccum], SubDiagonals);
    diagonals(T, 0, Columns, DiagAccum, SubDiagonals).

print_diagonals([]).
print_diagonals([H|T]):-
    string_codes(S, H),
    writeln(S),
    print_diagonals(T).

main:-
    %word_grid(WG),
    %writeln(WG),
    %diagonals(WG, Diagonals),
    %print_diagonals(Diagonals),
    open("/usr/share/dict/words", read, S),
    read_file(S, Lines),
    close(S),
    writeln(Lines),
    halt.
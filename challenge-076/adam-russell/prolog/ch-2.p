word_grid([
	["B","I","D","E","M","I","A","T","S","U","C","C","O","R","S","T"],
	["L","D","E","G","G","I","W","Q","H","O","D","E","E","H","D","P"],
	["U","S","E","I","R","U","B","U","T","E","A","S","L","A","G","U"],
	["N","G","N","I","Z","I","L","A","I","C","O","S","C","N","U","D"],
	["T","G","M","I","D","S","T","S","A","R","A","R","E","I","F","G"],
	["S","R","E","N","M","D","C","H","A","S","I","V","E","E","L","I"],
	["S","C","S","H","A","E","U","E","B","R","O","A","D","M","T","E"],
	["H","W","O","V","L","P","E","D","D","L","A","I","U","L","S","S"],
	["R","Y","O","N","L","A","S","F","C","S","T","A","O","G","O","T"],
	["I","G","U","S","S","R","R","U","G","O","V","A","R","Y","O","C"],
	["N","R","G","P","A","T","N","A","N","G","I","L","A","M","O","O"],
	["E","I","H","A","C","E","I","V","I","R","U","S","E","S","E","D"],
	["S","E","T","S","U","D","T","T","G","A","R","L","I","C","N","H"],
	["H","V","R","M","X","L","W","I","U","M","S","N","S","O","T","B"],
	["A","E","A","O","F","I","L","C","H","T","O","D","C","A","E","U"],
	["Z","S","C","D","F","E","C","A","A","I","I","R","L","N","R","F"],
	["A","R","I","I","A","N","Y","U","T","O","O","O","U","T","P","F"],
	["R","S","E","C","I","S","N","A","B","O","S","C","N","E","R","A"],
	["D","R","S","M","P","C","U","U","N","E","L","T","E","S","I","L"]
]).

grid_strings(Grid, Strings):-
    grid_strings(Grid, [], Strings).
grid_strings([], Strings, Strings).
grid_strings([H|T], StringAccum, Strings):-
    atomics_to_string(H, S),
    grid_strings(T, [S|StringAccum], Strings).        

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
    string_codes(S, D),
    diagonals([H|T], C0, Columns, [S|DiagAccum], SubDiagonals);
    diagonals(T, 0, Columns, DiagAccum, SubDiagonals).

word_found(_, []):-
    fail.
word_found(Word, [H|T]):-
    sub_string(H, _, _, _, Word);
    word_found(Word, T).

word_search(Dictionary, Grid, Words):-
    word_search(Dictionary, Grid, [], Words).
word_search([], _, Words, Words).    
word_search([H|T], Grid, WordAccum, Words):- 
    string_upper(H, W), 
    word_found(W, Grid),
    word_search(T, Grid, [W|WordAccum], Words);
    word_search(T, Grid, WordAccum, Words).

main:-
    open("words", read, S), %http://www-personal.umich.edu/~jlawler/wordlist.html
    read_file(S, Lines),
    close(S),
    word_grid(WG),
    diagonals(WG, Diagonals0),
    reverse(WG, GW),
    diagonals(GW, Diagonals1),
    grid_strings(WG, Strings),
    flatten([Strings, Diagonals0, Diagonals1], Grid),
    word_search(Lines, Grid, Words),
    writeln(Words),
    halt.
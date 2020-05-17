number_column-label(X, L):-
    number_column-label(X, "", L).
number_column-label(0, L, L).    
number_column-label(X, C, L):-
    (X > 26) ->
        string_concat(C, "A", CAlpha),
        number_column-label(X - 26, CAlpha, L);
    N is X + 64,
    char_code(Alpha, N),
    string_concat(C, Alpha, CAlpha),
    number_column-label(0, CAlpha, L).
    
column-label_number(X, L):-
    string_chars(L, Chars),
    column-label_number(X, 0, Chars).
column-label_number(X, X, []).    
    column-label_number(X, C, [A | T]):-
    (A = 'A', C = 0, length(T,0)) ->
        column-label_number(X, 1, T);     
    (A = 'A') ->
        C0 is C + 26,
        column-label_number(X, C0, T);
    char_code(A, Alpha),    
    C0 is Alpha - 64,
    C1 is C + C0,
    column-label_number(X, C1, T).    

main:-
    number_column-label(5, S0),
    writeln(S0),
    number_column-label(28, S1),
    writeln(S1),
    number_column-label(80, S2),
    writeln(S2),
    number_column-label(30, S3),
    writeln(S3),
    column-label_number(X0, 'A'),
    writeln(X0),
    column-label_number(X1, S3),
    writeln(X1),
    column-label_number(X2, 'AAAZ'),
    writeln(X2),
    halt.

:- use_module(library(dcg/high_order)).
:- use_module(library(dcg/basics)).

joiner --> `` ; `+` ; `-`.

operation(Infix_Op-Right_Operand) --> oper(Infix_Op), integer(Right_Operand).
oper(+) --> `+`.
oper(-) --> `-`.

task1(Exp_Str) :-
        Codes = `123456789`,
        Target_Value = 100,
        phrase(sequence(digit, joiner, Codes), Exp),
        string_codes(Exp_Str, Exp),
        phrase((integer(First), sequence(operation, Operations)), Exp),
        foldl([Current_Op-Rhs, Lhs, Imm_Result]>>(Current_Exp =.. [Current_Op, Lhs, Rhs], Imm_Result is Current_Exp), Operations, First, Target_Value).

plus_one(X, X1) :- plus(X, 1, X1).
double(X, X2) :- X2 is X * 2.

operation2(plus_one).
operation2(double).

task2(Moves_Needed) :-
        length(Operations, Moves_Needed), % IDDFS
        maplist(operation2, Operations),
        foldl([Operation, Before, After]>>call(Operation, Before, After), Operations, 1, 200),
        !. % first solution wins - we don't need to know more

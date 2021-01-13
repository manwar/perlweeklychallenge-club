/*
* You are given two positive numbers A and B.
* Write a script to demonstrate Ethiopian Multiplication 
* using the given numberss
*/ 

:- initialization(main).

ethiopean_multiplication(Operands, Product):-
    ethiopean_multiplication(Operands, [], Product).
ethiopean_multiplication([1, _], IntermediateTerms, Product):-
    sum_list(IntermediateTerms, Product).
ethiopean_multiplication(Operands, IntermediateTerms, Product):-
    [A0, B0] = Operands,
    A is A0 div 2,
    B is B0 * 2,
    M is A mod 2,
    M == 1,
    ethiopean_multiplication([A, B], [B|IntermediateTerms], Product).
ethiopean_multiplication(Operands, IntermediateTerms, Product):-
    [A0, B0] = Operands,
    A is A0 div 2,
    B is B0 * 2,
    M is A mod 2,
    M == 0,
    ethiopean_multiplication([A, B], IntermediateTerms, Product).

main:-
    [A, B] = [14, 12],
    ethiopean_multiplication([A, B], Product),
    format("Product of ~d x ~d (via Ethiopean Multiplication) is ~d.~n", [A, B, Product]),
    halt. 

:-initialization(main). 

expression(Answer) --> term(Answer).
expression(Answer) --> term(Answer0), [(+)], expression(Answer1), {Answer is Answer0 + Answer1}.
expression(Answer) --> term(Answer0), [(-)], expression(Answer1), {Answer is Answer0 - Answer1}.

term(Answer) --> operand(Answer).
term(Answer) --> operand(Answer0), [(*)], term(Answer1), {Answer is Answer0 * Answer1}.
term(Answer) --> operand(Answer0), [(/)], term(Answer1), {Answer is Answer0 / Answer1}.

operand(X) --> [X], {number(X)}.
operand(Answer) --> ['('],  expression(Answer), [')'].

calculator(Expression, Answer):-
    phrase(expression(Answer), Expression). 

main:-
    calculator([10, (+), 20, (-), 5], AnswerA),
    write(AnswerA), nl,
    calculator(['(', 10, (+), 20, (-), 5, ')', (*), 2], AnswerB),
    write(AnswerB), nl,
    halt. 

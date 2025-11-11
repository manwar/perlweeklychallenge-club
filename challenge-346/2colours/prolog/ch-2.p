:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).


operator --> `*`.
operator --> `+`.
operator --> `-`.
operator --> ``.

good_expression(Str, Target, Expression) :-
	string_codes(Str, Str_Codes),
	phrase(sequence(digit, operator, Str_Codes), Expression_Codes),
	string_codes(Expression, Expression_Codes),
	read_term_from_atom(Expression, Term, []),
	Term =:= Target.


task(Str, Target, Expressions) :- findall(Expression, good_expression(Str, Target, Expression), Expressions).

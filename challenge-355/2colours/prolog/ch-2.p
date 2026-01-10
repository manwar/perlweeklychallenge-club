:- use_module(library(dcg/high_order)).

increase(_), [B] --> [A, B], { A < B }.
decrease(_), [B] --> [A, B], { A > B }.

task2(Int) :-
        once(phrase((increase(_), sequence(increase, _), decrease(_), sequence(decrease, _), [_]), Int)).

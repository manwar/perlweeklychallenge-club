/*
* You are given rankings of N candidates.
* Write a script to find out the total candies needed for all candidates. 
* You are asked to follow the rules below:
*     a) You must given at least one candy to each candidate.
*     b) Candidate with higher ranking get more candies than their immediate
*        neighbors on either side.
*/
n([1, 2, 2]).
%n([1, 4, 3, 2]).

candies(N, Candies):-
    length(N, CandiesAccum),
    candies(N, CandiesAccum, Candies).
candies([], Candies, Candies).
candies([H0, H1|[]], CandiesAccum, Candies):-
    H0 > H1,
    C is CandiesAccum + 1,
    candies([], C, Candies).
candies([_, _|[]], CandiesAccum, Candies):-
    candies([], CandiesAccum, Candies).    
candies([H0, H1|T], CandiesAccum, Candies):-
    H0 > H1,
    C is CandiesAccum + 1,
    candies([H1|T], C, Candies).           
candies([H0, H1|T], CandiesAccum, Candies):-
    H1 > H0,
    C is CandiesAccum + 1,
    candies([H1|T], C, Candies).  

main:-
    n(N),
    candies(N, C),
    writeln(C),
    halt.
    
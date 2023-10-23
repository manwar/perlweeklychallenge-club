:- use_module(library(lists)).
:- use_module(library(reif)).
:- use_module(library(ordsets)).
:- use_module(library(clpz)).

ss_reif(A,B,true):-ord_subset(A,B).
ss_reif(_,_,false).

ch2_([],_,0).
ch2_([X|S],A,R):-if_(ss_reif(X,A),(R#=Q+1,ch2_(S,A,Q)),ch2_(S,A,R)).

ch2(S,A,R):-maplist(sort,S,T),sort(A,B),ch2_(T,B,R).

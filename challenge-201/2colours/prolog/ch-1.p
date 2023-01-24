:- use_module(library(lists)).
missing(ARRAY, MISSED) :- length(ARRAY, N), numlist(0, N, RANGE), subtract(RANGE, ARRAY, MISSED).
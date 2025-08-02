:- use_module(library(clpfd)).
task1(Hours, Nr_Complete_Day_Pairs) :- findall([V, W], (nth0(I, Hours, V), J #> I, nth0(J, Hours, W), (V - W) mod 24 =:= 0), Res), length(Res, Nr_Complete_Day_Pairs).

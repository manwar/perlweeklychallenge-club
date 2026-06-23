-module(ch2).
-export([is_armstrong/2]).
-include_lib("eunit/include/eunit.hrl").

digit_value(C) when C >= $0, C =< $9 -> C - $0;
digit_value(C) when C >= $A, C =< $Z -> C - $A + 10;
digit_value(C) when C >= $a, C =< $z -> C - $a + 10.

pow_int(_, 0) -> 1;
pow_int(Base, Exp) -> pow_int(Base, Exp, 1).

pow_int(_, 0, Acc) -> Acc;
pow_int(Base, Exp, Acc) -> pow_int(Base, Exp - 1, Acc * Base).

is_armstrong(Base, Limit) ->
  lists:filter(
    fun(N) ->
	Digits = [digit_value(C) || C <- integer_to_list(N, Base)],
	SumPower = lists:sum([pow_int(D, length(Digits)) 
			      || D <- Digits]),
	SumPower =:= N
    end,
    lists:seq(0, Limit)
   ).

-ifdef(TEST).
is_armstrong_test_() ->
  [
   {"Example 1",
    ?_assertEqual([0,1,2,3,4,5,6,7,8,9,153,370,371,407],
		  is_armstrong(10,1000))},
   {"Example 2",
    ?_assertEqual([0,1,2,3,4,5,6,10,25,32,45,133,134,152,250],
		  is_armstrong(7,1000))},
   {"Example 3",
    ?_assertEqual([0,1,2,3,4,5,6,7,8,9,10,11,12,
		   13,14,15,342,371,520,584,645],
		  is_armstrong(16,1000))}
  ].
-endif.


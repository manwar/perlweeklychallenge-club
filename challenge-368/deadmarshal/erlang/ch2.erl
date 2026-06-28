-module(ch2).
-export([big_and_little_omega/2]).
-include_lib("eunit/include/eunit.hrl").

-spec big_and_little_omega(integer(),integer()) -> integer().
big_and_little_omega(Number,Mode) ->
  Factors = prime_factors(Number,2,[]),
  case Mode of
    0 -> length(lists:usort(Factors));
    1 -> length(Factors)
  end.

-spec prime_factors(integer(),integer(),[integer()]) -> [integer()].
prime_factors(1,_D,Acc) -> Acc;
prime_factors(N,D,Acc) when D * D > N -> [N|Acc];
prime_factors(N,D,Acc) when N rem D =:= 0 -> 
  prime_factors(N div D,D,[D|Acc]);
prime_factors(N,D,Acc) -> 
  prime_factors(N,D+1,Acc).

-ifdef(TEST).
big_and_little_omega_test_() ->
  [
   {"Example 1",
    ?_assertEqual(3,big_and_little_omega(100061,0))},
   {"Example 2",
    ?_assertEqual(3,big_and_little_omega(971088,0))},
   {"Example 3",
    ?_assertEqual(6,big_and_little_omega(63640,1))},
   {"Example 4",
    ?_assertEqual(2,big_and_little_omega(988841,1))},
   {"Example 5",
    ?_assertEqual(2,big_and_little_omega(211529,0))}
  ].
-endif.


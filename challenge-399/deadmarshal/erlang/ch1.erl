-module(ch1).
-export([longest_repeating_character/2]).
-include_lib("eunit/include/eunit.hrl").

-spec longest_repeating_character(S,K) -> R when
    S :: string(),
    K :: non_neg_integer(),
    R :: non_neg_integer().
longest_repeating_character(S,K) -> helper(S,S,0,0,0,#{},K,length(S)).

helper([],_L,Left,_R,_Max,_Counts,_K,N) -> N - Left;
helper([C|Rest],L,Left,R,Max0,Counts0,K,N) ->
  Cnt = maps:get(C,Counts0,0) + 1,
  Counts1 = Counts0#{C => Cnt},
  Max = max(Max0,Cnt),
  case (R - Left + 1) - Max > K of
    true ->
      [LC|LRest] = L,
      Counts2 = maps:update_with(LC,fun(V) -> V - 1 end,Counts1),
      helper(Rest,LRest,Left+1,R+1,Max,Counts2,K,N);
    false ->
      helper(Rest,L,Left,R+1,Max,Counts1,K,N)
  end.

-ifdef(TEST).
longest_repeating_character_test_() ->
  [
   {"Example 1",
    ?_assertEqual(5,longest_repeating_character("AAAAA",2))},
   {"Example 2",
    ?_assertEqual(5,longest_repeating_character("ABCDE",4))},
   {"Example 3",
    ?_assertEqual(5,longest_repeating_character("AAABBBBAA",1))},
   {"Example 4",
    ?_assertEqual(5,longest_repeating_character("ABACADA",2))},
   {"Example 5",
    ?_assertEqual(8,longest_repeating_character("BAAABAAAA",1))}
  ].
-endif.


-module(ch2).
-export([trionic_list/1]).
-include_lib("eunit/include/eunit.hrl").

-spec sign(X) -> R when 
    X :: integer(), 
    R :: integer().
sign(X) when X < 0 -> -1;
sign(X) when X > 0 -> 1;
sign(_) -> 0.

-spec trionic_list(L) -> R when 
    L :: [term()], 
    R :: boolean().
trionic_list([]) -> false;
trionic_list(L) ->
  Pairs = lists:zip(lists:droplast(L), tl(L)),
  Signs = [sign(B - A) || {A, B} <- Pairs],
  dedup(Signs) =:= [1,-1,1].

-spec dedup(L) -> R when
    L :: [term()],
    R :: [term()].
dedup([]) -> [];
dedup([H|T]) -> [H|dedup(drop_while(H,T))].

-spec drop_while(X,L) -> R when
    X :: term(),
    L :: [term()],
    R :: [term()].
drop_while(X,[X|T]) -> drop_while(X,T);
drop_while(_,L) -> L.

-ifdef(TEST).
trionic_list_test_() ->
  [
   {"Example 1",?_assertEqual(true,
			      trionic_list([1,3,5,4,2,6,8]))},
   {"Example 2",?_assertEqual(false,
			      trionic_list([1,4,4,2,1,3,5]))},
   {"Example 3",?_assertEqual(true,
			      trionic_list([2,10,3,1,9]))},
   {"Example 4",?_assertEqual(false,
			      trionic_list([1,2,3,4,3,2,1]))},
   {"Example 5",?_assertEqual(false,
			      trionic_list([1,3,6,4,2,7,8,4]))}
  ].
-endif.


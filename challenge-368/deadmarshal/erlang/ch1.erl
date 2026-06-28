-module(ch1).
-export([make_it_bigger/2]).
-include_lib("eunit/include/eunit.hrl").

-spec make_it_bigger(string(),char()) -> string().
make_it_bigger(Number,Digit) ->
  Idx = find_index(Number,Digit,0,-1),
  case Idx of 
    -1 -> Number;
    _ ->
      {Before,Rest} = lists:split(Idx,Number),
      Before ++ tl(Rest)
  end.

-spec find_index(string(),integer(),integer(),integer()) -> integer().
find_index([],_Digit,_I,LastIdx) -> LastIdx;
find_index([H|T],Digit,I,LastIdx) -> 
  case H =:= Digit of
    false -> find_index(T,Digit,I+1,LastIdx);
    true ->
      NextGtCurrent = case T of 
			[Next|_] -> H < Next;
			[] -> false
		      end,
      if 
	NextGtCurrent -> I;
	true -> find_index(T,Digit,I+1,I)
      end
  end.

-ifdef(TEST).
make_it_bigger_test_() ->
  [
   {"Example 1",
    ?_assertEqual("1546",make_it_bigger("15456",$5))},
   {"Example 2",
    ?_assertEqual("732",make_it_bigger("7332",$3))},
   {"Example 3",
    ?_assertEqual("231",make_it_bigger("2231",$2))},
   {"Example 4",
    ?_assertEqual("54321",make_it_bigger("543251",$5))},
   {"Example 5",
    ?_assertEqual("921",make_it_bigger("1921",$1))}
  ].
-endif.


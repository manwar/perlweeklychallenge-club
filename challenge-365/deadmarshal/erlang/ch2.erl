-module(ch2).
-export([valid_token_counter/1]).
-include_lib("eunit/include/eunit.hrl").

-spec valid_token_counter(string()) -> integer().
valid_token_counter(S) ->
  P = "^(?:[a-z]+-)?[a-z]+[?!.,]?$",
  Tokens = string:lexemes(S," \t\n\r\v\f"),
  lists:foldl(fun(Token,Acc) ->
		  case re:run(Token,P,[{capture,none}]) of
		    match -> Acc + 1;
		    nomatch -> Acc
		  end
	      end,0,Tokens).

-ifdef(TEST).
valid_token_counter_test_() ->
  [
   {"Example 1",
    ?_assertEqual(3,
		  valid_token_counter("cat and dog"))},
   {"Example 2",
    ?_assertEqual(2,
		  valid_token_counter("a-b c! d,e"))},
   {"Example 3",
    ?_assertEqual(4,
		  valid_token_counter("hello-world! this is fun"))},
   {"Example 4",
    ?_assertEqual(2,
		  valid_token_counter("ab- cd-ef gh- ij!"))},
   {"Example 5",
    ?_assertEqual(2,
		  valid_token_counter("wow! a-b-c nice."))}
  ].
-endif.


-module(ch2).
-export([word_sorter/1,main/0]).

-spec word_sorter(string()) -> string().
word_sorter(S) ->
  Words = string:tokens(S," \t\n\r"),
  Sorted = lists:sort(
	     fun(A,B) -> 
		 string:casefold(A) =< string:casefold(B) 
	     end,
	     Words),
  string:join(Sorted," ").

main() ->
  io:format("~s~n~s~n~s~n~s~n~s~n",
	    [word_sorter("The quick brown fox"),
	     word_sorter("Hello    World!   How   are you?"),
	     word_sorter("Hello"),
	     word_sorter("Hello, World! How are you?"),
	     word_sorter("I have 2 apples and 3 bananas!")]).


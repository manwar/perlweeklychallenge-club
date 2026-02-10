-module(ch1).
-export([text_justifier/2,main/0]).

-spec text_justifier(string(),non_neg_integer()) -> string().
text_justifier(S,Width) ->
  case string:length(S) > Width of
    true ->
      erlang:error("Length too short!");
    false -> string:pad(S,Width,both,$*)
  end.

main() ->
  io:format("~s~n~s~n~s~n~s~n~s~n~s~n",
	    [text_justifier("Hi",5),
	     text_justifier("Code",10),
	     text_justifier("Hello",9),
	     text_justifier("Perl",4),
	     text_justifier("A",7),
	     text_justifier("",5)]).


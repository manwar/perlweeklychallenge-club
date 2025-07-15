-module(ch1).
-export([clear_digits/1]).

clear_digits(S) ->
  Regex = "\\D\\d",
  case re:run(S,Regex) of 
    {match,_} -> case re:replace(S,Regex,"",[{return,list}]) of
		   "" -> "";
		   NewString -> clear_digits(NewString)
		 end;
    nomatch -> S
  end.


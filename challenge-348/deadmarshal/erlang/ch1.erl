-module(ch1).
-export([string_alike/1,main/0]).

-spec string_alike(string()) -> boolean().
string_alike(S) ->
  Vowels = sets:from_list("aeiouAEIOU"),
  H = string:length(S) div 2,
  {First,Second} = lists:split(H,S),
  C1 = count_vowels(First,Vowels),
  C2 = count_vowels(Second,Vowels),
  C1 =:= C2 andalso C1 =/= 0.

-spec count_vowels(string(),sets:set(char())) -> non_neg_integer().
count_vowels(S,Vowels) ->
  lists:foldl(fun(C,Acc) ->
		  case sets:is_element(C,Vowels) of 
		    true -> Acc + 1;
		    false -> Acc 
		  end
	      end,0,S).

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [string_alike("textbook"),
	     string_alike("book"),
	     string_alike("AbCdEfGh"),
	     string_alike("rhythmmyth"),
	     string_alike("UmpireeAudio")]).


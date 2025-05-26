-module(ch1).
-export([increment_decrement/1]).

increment_decrement(L) -> 
  lists:foldl(fun(E,Acc) -> 
		  case string:find(E,"++",leading) of 
		    nomatch -> Acc-1;
		    _ -> Acc+1
		  end
	      end,0,L).


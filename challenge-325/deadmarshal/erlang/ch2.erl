-module(ch2).
-export([final_price/1]).

-spec final_price(L) -> R when 
    L :: [T],
    R :: [T],    
    T :: integer().
final_price(Prices) -> 
  T = lists:foldr(fun do_fold/2,{[],[0]},Prices),
  element(1,T).

do_fold(X,{Ans,[Y|Stack]}) when Y > X ->
  do_fold(X,{Ans,Stack});
do_fold(X,{Ans,[Y|Stack]}) ->
  {[X-Y|Ans],[X,Y|Stack]}.


-module(ch2).
-export([tax_amount/2]).

tax_amount(Income,Taxes) ->
  tax_amount(Income,Taxes,0,0).

tax_amount(Income,[[Upper,Percent]|T],Prev,Tax) when Income > 0 ->
  Curr = Upper - Prev,
  Tax2 = Tax + min(Income,Curr) * Percent / 100,
  tax_amount(Income - Curr, T, Upper, Tax2);
tax_amount(_,_,_,Tax) -> Tax.


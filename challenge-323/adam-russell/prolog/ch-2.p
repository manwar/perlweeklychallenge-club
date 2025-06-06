
  
  compute_taxes(Income, TaxBrackets, Tax):-
      compute_taxes(Income, TaxBrackets, 0, 0, Tax).
  compute_taxes(0, _, 0, 0, 0).
  compute_taxes(Income, [[Limit, Rate]|TaxBrackets], Taxable, Taxed, Tax):-
      Limit =< Income,
      Taxable1 is Limit - Taxable,
      Taxed1 is Taxed + Taxable1,
      compute_taxes(Income, TaxBrackets, Taxable1, Taxed1, Tax1),
      Tax is Tax1 + (Taxable1 * (Rate/100)).
  compute_taxes(Income, [[Limit, Rate]|_], _, Taxed, Tax):-
      Limit > Income,
      Tax is ((Income - Taxed) * (Rate/100)).


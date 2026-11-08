#!/usr/local/bin/jconsole

NB. use a:,a: as argument to find the first pair
pentagon_pair =: _(adverb define)
  NB. pentagon number and its inverse
  pn =. ([: -: ] * <: @ (3&*)) :. (%&6 @ >: @ %: @ >: @(24&*))

  NB. pentagon numbers have an integer inverse,
  NB. check if all are pentaton numbers
  all_p =. *./ @: (] = <.) @: (pn inv)

  NB. incremented input list's size is the next
  NB. numbers index
  next =. pn @ >: @ # @ (0&{::)

  NB. check if last element is an empty box
  empty_tail =. a: = {:

  NB. find an element y1 of y such that x + y1 and x - y1 are
  NB. pentagon numbers
  find_other =. ] #~ all_p @ (-`+`:0)

  NB. - find the next number for the given list
  NB. - find the "other" part for "next" in the list
  NB. - return the list, extended by "next" and
  NB.   "other" in a separate box
  list =. 0&{::
  step =. next (,~ ; find_other) list

  NB. repeat "step" until it returns a matching "other",
  NB. pick the last element of the list and the "other" as result
  while =. ^:^:_.
  {: S:0 @ (step while empty_tail) f.
)

3 : 0 (2}. ARGV)
try.
    echo 0": pentagon_pair a:,a:
catch.
    echo 'execution failed:', LF, 13!:12 ''
end.
)

exit ''

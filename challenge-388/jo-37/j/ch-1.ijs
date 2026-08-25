#!/usr/local/bin/jconsole

dyck_words =: _(adverb define)
  NB. check if the number of 'U's equals the number of 'D's
  eq_ud =. =/@:(+/"1)@:((e."1 0)&'UD')

  NB. "u`v if_zero y" applies "u y" if y is zero and "v y" otherwise
  if_zero =. @. *

  NB. recursive call with decremented argument
  NB. Must be fixed using "f." to widen scope!
  self_1 =. $: @ <:

  NB. - depending on the number of 'U's vs. 'D's:
  NB.   - drop zero or one leading characters from 'DU'
  NB. - singly append characters to input
  NB. - box result
  extend =. ([: < ] ,"1 0 'DU' }.~ eq_ud) rows

  NB. remove boxing
  raze =. ;

  NB. generate a list of one empty string
  empty =. (1 0$'')"_

  NB. create Dyck Prefixes:
  NB. provide an empty string for y = 0
  NB. otherwise:
  NB. - recurse into call for y - 1
  NB. - append appropriate characters
  NB. - join results
  NB. - fix temporary verbs
  NB. - memoize results
  dp =. empty ` (raze @ (extend @ (self_1 f.))) if_zero f. M.

  NB. generate list of Dyck Words of order y from
  NB. Dyck Prefixes of length 2 * y
  NB. by selecting words having an equal count of 'U's and 'D's
  (] #~ eq_ud rows) @ dp @ +: f.
)

Examples =: 1;2;3;0;4

Expected =: > L:1 <;. _2 L:0 cutopen 0 : 0
UD 
UDUD UUDD 
UDUDUD UDUUDD UUDDUD UUDUDD UUUDDD 
 
UDUDUDUD UDUDUUDD UDUUDDUD UDUUDUDD UDUUUDDD UUDDUDUD UUDDUUDD UUDUDDUD UUDUDUDD UUDUUDDD UUUDDDUD UUUDDUDD UUUDUDDD UUUUDDDD 
)

3 : 0 (> ".&.> 2}. ARGV)
if.
    1 = # y
do.
    echo dyck_words {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: dyck_words&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs N" to process number'
    echo 'or   "./ch-1.ijs"   to run the examples'
end.
)

exit ''
#!/usr/local/bin/jconsole

require 'regex'

to_base =: _(adverb define)
  NB. select first 128 characters from alphabet, i.e ASCII chars,
  NB. restrict to alphanumeric and punctuation,
  NB. box by punctuation / others,
  NB. sort the boxes by their keys and
  NB. raze boxes
  p =. '[[:punct:]]'
  all =. '[[:alnum:][:punct:]]+'
  digits =. ;@:(/:~/)@:|:@(p&rxE ;/.. ])@(all&rxfirst)@(128&{.) a.

  NB. convert integer y to digits in base x (default: 2)
  todigits =. {&digits @ (#. inv)

  NB. convert base-x digits (default: 2) in y to integer
  fromdigits =. 2&$: : (#. digits&i.)

  NB. convert in either direction
  (todigits :. fromdigits) f.
) 

Examples =: ". L:0 cutopen 0 : 0
42 2
15642094 16
493 8
2228519 36
123456789 64
)

Expected =: cutopen 0 : 0
101010
EEADEE
755
1BRJB
7MyqL
)

3 : 0 (> ".&.> 2}. ARGV)
if.
    2 = # y
do.
    echo ({: y) to_base {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: to_base~/ &.> Examples
        assert. '_`{|}~' -: 94 to_base (94 #. 88 89 90 91 92 93)
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs N B" to process number and base'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''
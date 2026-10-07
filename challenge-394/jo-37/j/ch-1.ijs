#!/usr/local/bin/jconsole

require 'regex'

alternate_case =: _(adverb define)
  uc =. a. {~ 65+i.26
  fail =. '01' {~ 1 (1 b.)`(6 b.)"0 uc e.~ ]
  flip =. '10' {~ '01' i. ]
  step =. {{
    'cnt str' =. y
    match =. '0(?:11)*0' rxmatch str
    if. 0 > (<0 0) { match do. y return. end.
    len =. (<0 1) { match
    ones =. < len # '1'
    swaps =. <: len
    (cnt + swaps) ; (ones match rxmerge str)
  }}
  alt =. 0 {:: [: (step^:_) 0 ; ]
  ([: <./ [: alt"1 flip ,: ]) @ fail f. : [:
)
  
Examples =: ;:'aAbB AAbb AAAbbb aABb bBBAaa'
Expected =: 0; 1; 3; 1; 2

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo alternate_case 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: alternate_case&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR" to process string'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''
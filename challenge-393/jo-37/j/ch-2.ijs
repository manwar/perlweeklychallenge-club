#!/usr/local/bin/jconsole

prime_step =: _(adverb define)
  char_sum =. +/ @: (a.&i.)
  is_prime =. 1&p:
  prev_prime =. _4&p:
  next_prime =. 4&p:
  abs_min =. <./ @: |
  (([: abs_min ] - prev_prime , next_prime)`0:@.is_prime @ char_sum) f. : [:
)

Examples =: ;:'hello football a challenge perl'
Expected =: 9; 2; 0; 2; 2

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo prime_step 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: prime_step&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR" to process string'
    echo 'or   "./ch-2.ijs"     to run the examples'
end.
)

exit ''
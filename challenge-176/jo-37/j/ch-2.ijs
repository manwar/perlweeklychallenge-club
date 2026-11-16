#!/usr/local/bin/jconsole

NB. Implementation

NB. check if y is a reversible number
reversible_number =: _(adverb define)
  NB. convert y to decimal digits
  to_digits =. 10&#.inv
  NB. reverse the digits
  reverse =. |.
  NB. Use "u under v" to perform "(v inv) u v y"
  under =. &.
  NB. check if y is odd
  odd =. 2&#:
  NB. "and" over all items of y
  all =. *./
  NB. Add y and its reverse, check if all digits are odd
  ([: all @: odd @ to_digits ] + reverse under to_digits) f. : [:
)

NB. Command line processing and tests
3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    try.
        echo (reversible_number"0 # ]) >: i. 0". 0{:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        assert. 1 -: reversible_number 36
        assert. 0 -: reversible_number 17
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-2.ijs N" to print reversible number up to N'
    echo 'or   "./ch-2.ijs"   to run the examples'
end.
)

exit ''

#!/usr/local/bin/jconsole

NB. find the "home prime" for y
home_prime =: _(adverb define)
  NB. factors of y
  factors =. q:

  NB. convert numbers to boxed strings
  to_boxed_str =. <@(0&":"0)

  NB. remove outer boxes
  raze =. ;

  NB. convert (numeric) string to number
  to_num =. 0&".

  NB. apply left operand repeatedly to previous result
  NB. while the result changes
  while_changes =. ^:_

  NB. find factors, convert to strings, join and convert
  NB. to integer
  NB. repeat while the result changes
  to_num @ raze @: to_boxed_str @ factors while_changes f.
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    try.
        echo home_prime 0". 0 {:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        echo (] ,. home_prime"0) 2&+ i.19
        assert. 773 -: home_prime 10
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-2.ijs N" to process number'
    echo 'or   "./ch-2.ijs"   to run some examples'
end.
)

exit ''

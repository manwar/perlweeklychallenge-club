#!/usr/local/bin/jconsole

sbs =: _(adverb define)
  find =. {{
    NB. prepend/append the first/last character of y to itself, 
    NB. unless it is the first loop cycle
    next =. ({. , ] , {:)^:(* Z: 1) y

    NB. terminate the loop if next is not found as a substring in x
    next _2&Z: @ -. @ (+./) @: E. x

    NB. provide y for the next cycle
    next
  }}

  NB. search for special binary strings starting with zero or one
  NB. in increasing length
  NB. produce an empty list in case of an error
  ;@:((< F: find :: (0$0))&.(a:`>))&('01';'10') f.
)

Examples =: cutopen 0 : 0
0101
000111
000011
10011100
00000
)

Expected =: cutopen L:0 cutopen 0 : 0
01 10
01 0011 000111
01 0011
01 0011 10 1100
 
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo sbs 0 {:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: sbs&.> Examples
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
#!/usr/local/bin/jconsole

NB. (adverb) create a tacit verb that converts boxed strings to integers and
NB. checks if the sum of the leading items equals the last
sum_of_words =: adverb define
   NB. (adverb) apply left operand to leaves of y and unbox the result
   spread =. S:0

   NB. (monad) find character offsets from 'a'
   as_digits =. 97 -~ a. i. ]

   NB. (dyad) convert base x digits to an integer
   from_digits =. #.

   NB. (monad) sum over all items but the last
   curtailed_sum =. +/ @: }:

   NB. (monad) pick the last item
   tail =. {:

   NB. convert characters to digits, convert digits from base m to integer,
   NB. sum over all items but the last and compare it with the last
   (tail = curtailed_sum) @: ((m from_digits as_digits) spread) f. : [:
)

Examples =: cutopen L:0 cutopen 0 : 0
acb cba cdb
aab aac ad
bc je jg
a aaaa aa
c d h
gfi hbf bdhd
)

Expected =: 1;1;0;1;0;1

3 : 0 (2}. ARGV)
sum_of_dec_words =: 10 sum_of_words
if.
    1 <: # y
do.
    echo sum_of_dec_words y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: sum_of_dec_words&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs WORD..." to process words'
    echo 'or   "./ch-2.ijs"         to run the examples'
end.
)

exit ''
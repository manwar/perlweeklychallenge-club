#!/usr/local/bin/jconsole

smaller_greater =: _(adverb define)
   min =. <./
   max =. >./

   NB. test if elements of left arg
   NB. are elements of right arg
   in =. e.

   not =. -.
   sum =. +/

   NB. find items that are neither min
   NB. nor max and count these
   ([: sum [: not ] in min , max) f. : [:
)

Examples =: ". L:0 cutopen 0 : 0
2 4
1 1 1 1
1 1 4 8 12 12
3 6 6 9
0 _5 10 _2 4
)

Expected =: 0; 0; 2; 2; 3

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo smaller_greater ". S:0 y
elseif.
    0 = # y
do.
    try.
        assert Expected -: smaller_greater&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs N..." to process numbers'
    echo 'or   "./ch-2.ijs"      to run the examples'
end.
)

exit ''
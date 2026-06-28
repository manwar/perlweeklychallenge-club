#!/usr/local/bin/jconsole

armstrong =: adverb define
   dps =. ([: +/ ] ^ #) @ (m&#.inv)
   ((] #~ ] = dps"0) @: i. @ >:) f. : [:
)

Examples =: > L:1 ". L:0 cutopen L:0 cutopen 0 : 0
10 1000
7 1000
16 1000
)

Expected =: > L:1 ". L:0 cutopen L:0 cutopen 0 : 0
0 1 2 3 4 5 6 7 8 9 153 370 371 407
0 1 2 3 4 5 6 10 25 32 45 133 134 152 250
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 342 371 520 584 645
)

3 : 0 (". > 2}. ARGV)
if.
    2 = # y
do.
    echo (0{y) armstrong 1{y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: {{x armstrong y}}/&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs BASE LIMIT" to process BASE and LIMIT'
    echo 'or   "./ch-2.ijs"            to run the examples'
end.
)

exit ''
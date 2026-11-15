#!/usr/local/bin/jconsole

NB. Implementation

damm =: _(adverb define)
  mx =. 0 ". S:0 cutopen {{)n
    0 3 1 7 5 9 8 6 4 2
    7 0 9 2 1 5 4 8 6 3
    4 2 0 6 8 7 1 3 5 9
    1 7 5 0 9 8 3 4 2 6
    6 1 2 3 0 4 5 9 7 8
    3 6 7 4 2 0 9 5 8 1
    5 8 6 9 7 2 0 1 3 4
    8 9 4 5 3 6 2 0 1 7
    9 4 3 8 6 1 7 2 0 5
    2 5 8 1 4 3 6 7 9 0
}}
  0&$: : ([ -.@* F.. (mx {::~  ,~ ) 10&#.inv@])
)

NB. Command line processing and tests
3 : 0 (2}. ARGV)

if.
    1 = # y
do.
    try.
        echo damm 0". 0{:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        Examples =. 5724; 5727
        Expected =. 1; 0

        Result =. damm&.> Examples
        echo Result
        assert. Expected -: Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-1.ijs N" to process number'
    echo 'or   "./ch-1.ijs"   to run the examples'
end.
)

exit ''

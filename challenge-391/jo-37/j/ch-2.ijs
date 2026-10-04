#!/usr/local/bin/jconsole

arrange_box =: _(adverb define)
  fits =. *./@:<"1
  mult =. +/ . *
  #@(mult^:a:~)@(fits/~) f. : [:
)

Examples =: > L:1 ". L:0 '|' cutopen L:0 cutopen 0 : 0
1 3|3 5|6 8|2 4
10 20|15 10|20 30|12 18|16 25
5 5|5 5|5 5
2 100|3 200|4 300|5 50|5 400
10 20|15 10|20 30|12 18|16 25
)

Expected =: 4; 3; 1; 4; 3

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo arrange_box ". S:0 y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: arrange_box&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs ''W B''..." to process boxes'
    echo 'or   "./ch-2.ijs"            to run the examples'
end.
)

exit ''
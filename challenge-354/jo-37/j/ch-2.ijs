#!/usr/local/bin/jconsole

ShiftGrid =: $@] $ -@[ |. ,@]

examples =: ". L:0 > L:1 <;._1 L:1 <;._1 cutopen 0 : 0
§
|
1
|
1 2 3
4 5 6
7 8 9
§
|
1
|
10 20
30 40
§
|
1
|
1 2
3 4
5 6
§
|
5
|
1 2 3
4 5 6
§
|
1
|
1 2 3 4
)

expected =: ".&.> > L:1 <;._1 cutopen 0 : 0
§
9 1 2
3 4 5
6 7 8
§
40 10
20 30
§
6 1
2 3
4 5
§
2 3 4
5 6 1
§
4 1 2 3
)

3 : 0 > ".&.> 2}. ARGV
if.
    4 <: # y
do.
    echo (0{y) ShiftGrid ((1 2){y) $ 3}. y
elseif.
    0 = # y
do.
    try.
        assert. expected -: (>@(0&{) ShiftGrid >@(1&{))&.> examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs K ROWS COLS M..." to process matrix'
    echo 'or   "./ch-1.ijs"                  to run the examples'
end.
)

exit^:(0&>@(4!:0) <'noexit') ''


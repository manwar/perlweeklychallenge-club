#!/usr/local/bin/jconsole

MinDiff =: /:~@({~ ($ #: I.@,)@(= <./@,)@:(_:^:(0&>:)"0)@(-~/~))

examples =: ".&.> cutopen 0 : 0
4 2 1 3
10 100 20 30
_5 _2 0 3
8 1 15 3
12 5 9 1 15
)
expected =: ".&.> > L:1 <;._1 cutopen 0 : 0
§
1 2
2 3
3 4
§
10 20
20 30
§
_2 0
§
1 3
§
9 12
12 15
)


3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo MinDiff ;".&.> y  
elseif.
    0 = # y
do.
    try.
        assert. expected -: MinDiff &.> examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR" to process string'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit^:(0&>@(4!:0) <'noexit') ''


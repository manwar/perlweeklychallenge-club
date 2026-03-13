#!/usr/local/bin/jconsole

diag =: [`(,.~@i.@#@])
FindCelebrity =: (1&$@_1:^:(-.@*@#))@I.@(-.@(+./)@|: *. *./@(1&(diag }))) f.

Examples =: >@(". L:0)@('|'&cutopen)&.> cutopen 0 : 0
0 0 0 0 1 0 | 0 0 0 0 1 0 | 0 0 0 0 1 0 | 0 0 0 0 1 0 | 0 0 0 0 0 0 | 0 0 0 0 1 0 |
0 1 0 0 | 0 0 1 0 | 0 0 0 1 | 1 0 0 0 |
0 0 0 0 0 | 1 0 0 0 0 | 1 0 0 0 0 | 1 0 0 0 0 | 1 0 0 0 0 |
0 1 0 1 0 1 | 1 0 1 1 0 0 | 0 0 0 1 1 0 | 0 0 0 0 0 0 | 0 1 0 1 0 0 | 1 0 1 1 0 0 |
0 1 1 0 | 1 0 1 0 | 0 0 0 0 | 0 0 0 0 |
0 0 1 1 | 1 0 0 0 | 1 1 0 1 | 1 1 0 0 |
)

Expected =:  1&$&.>(4;_1;0;3;_1;_1)

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    try.
         party =. > ".&.> y
		assert. 2 = # $ party
         assert. =/ $ party
         echo FindCelebrity party
    catch.
        echo 'input data invalid'
        echo 13!:12''
    end.
elseif.
    0 = # y
do.
    try.
        assert. Expected -: FindCelebrity&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs ROW..." to process binary matrix'
    echo 'or   "./ch-1.ijs"        to run the examples'
end.
)

exit ''
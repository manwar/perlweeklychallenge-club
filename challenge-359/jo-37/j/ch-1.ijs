#!/usr/local/bin/jconsole

dst =: {{x (([: +/ #.^:_1) [ 1 Z: >) y}}
pr =: {{(Z:2) , y}}
digitroot =: pr F. dst

Examples =: ;/ 38 7 999 1999999999 101010
Expected =: 2 2; 0 7; 2 9; 3 1; 1 3

3 : 0 (". > 2}. ARGV)
if.
    2 = # y
do.
        echo ({: digitroot [: x: {.) y 
elseif.
    1 = # y
do.
    echo (10 digitroot [: x: {.) y 
elseif.
    0 = # y
do.
    try.
        assert. Expected -: 10&digitroot&.> Examples
        assert. (3 1) -:  8 digitroot 127
        assert. (4 1) -: 10 digitroot 19999999999999999999999x
        assert. (5 1) -:  2 digitroot (_1 + 2x^127)
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs N [B]" to process number (in base B)'
    echo 'or   "./ch-1.ijs"       to run the examples'
end.
)

exit ''
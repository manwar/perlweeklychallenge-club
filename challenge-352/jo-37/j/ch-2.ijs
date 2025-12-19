#!/usr/local/bin/jconsole

NB. BinaryPrefix =: {{ 0 = 5 | #.\ y }}
BinaryPrefix =: 0&=@(5&|@#.\)

Examples =: ".&.> cutopen 0 : 0
0 1 1 0 0 1 0 1 1 1
1 0 1 0 1 0
0 0 1 0 1
1 1 1 1 1
1 0 1 1 0 1 0 0 1 1
)

true =: 1
false =: 0

Expected =: ".&.> cutopen 0 : 0
true, false, false, false, false, true, true, false, false, false
false, false, true, true, false, false
true, true, false, false, true
false, false, false, true, false
false, false, true, false, false, true, true, true, false, false
)

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo ('false'; 'true') {~ BinaryPrefix &.> y
elseif.
    0 = # y
do.
    try.
	echo ('false'; 'true') {~ BinaryPrefix 0 1 1 0 0 1 0 1 1 1
        assert. Expected -: BinaryPrefix &.> Examples
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
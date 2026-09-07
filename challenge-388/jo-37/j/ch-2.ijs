#!/usr/local/bin/jconsole

derangements =: <. @ (%&(^1)) @ >: @ !

Examples =: 1;2;3;4;5
Expected =: 0;1;2;9;44

3 : 0 (> ".&.> 2}. ARGV)
if.
    1 = # y
do.
    echo derangements {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: derangements &.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs N" to process number'
    echo 'or   "./ch-2.ijs"   to run the examples'
end.
)

exit ''
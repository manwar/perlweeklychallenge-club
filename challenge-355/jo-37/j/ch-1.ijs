#!/usr/local/bin/jconsole

tsep =: ;@((, (<',')&,)/)@(_3&(<\))&.|.@":

NB. numerize inside boxes
examples =: ".&.> cutopen 0 : 0
123
1234
1000000
1
12345
)

3 : 0 (> ".&.> 2}. ARGV)
if.
    1 = # y
do.
    echo tsep > y
elseif.
    0 = # y
do.
    try.
        assert. ('123'; '1,234'; '1,000,000'; (,'1'); '12,345') -: tsep &.> examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs NUM" to process number'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit^:(0&>@(4!:0) <'noexit') ''


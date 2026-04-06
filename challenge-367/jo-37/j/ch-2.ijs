#!/usr/local/bin/jconsole

NB. convert 'hh:mm hh:mm' to (min min)
event =: >@((24 * 60)&|@((24 60)&#.) L:0)@(> L:1)@(". L:0)@(':'&cutopen L:0)@(' '&cutopen)

NB. x dur y calculates the duration between x and y
dur =: (24*60)"_^:(0&=)@((24*60)&|)@-~

NB. check two events - given as a 2x2 matrix of minutes - for conflicts
conflict =: +/@:(dur/"1) > dur/@((<0 1)&|:)

Examples =: '|' cutopen L:0 cutopen 0 : 0
10:00 12:00|11:00 13:00
09:00 10:30|10:30 12:00
14:00 15:30|14:30 16:00
08:00 09:00|09:01 10:00
23:30 00:30|00:00 01:00
)

Expected =: 1;0;1;0;1

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo conflict event@>"0 y
elseif.
    0 = # y
do.
    try.
        assert Expected -: (conflict@:(event@>"0))&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs EV1 EV2" to process events "HS:MS HE:ME"'
    echo 'or   "./ch-1.ijs"         to run the examples'
end.
)

exit ''
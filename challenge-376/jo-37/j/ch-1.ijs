#!/usr/local/bin/jconsole

same_color =: -. @ (2&|) @ (+/) @: , &: (a.&i.)

Examples =: cutopen L:0 cutopen 0 : 0
a7 f4
c1 e8
b5 h2
f3 h1
a1 g8
)

Expected =: 1;0;0;1;0

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo same_color&>/ y
elseif.
    0 = # y
do.
    try.
        assert Expected -: same_color&>/&.>Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs SQ1 SQ2" to check squares'
    echo 'or   "./ch-1.ijs"         to run the examples'
end.
)

exit ''
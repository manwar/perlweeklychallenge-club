#!/usr/local/bin/jconsole

onIdx =: [.&.:(a:`(].&i.))
digits =: 10 (+ i.)~ onIdx a. '0'

MaxStr =: [: >./ #`".@.([: *./ e.&digits)@>

Examples =: <@cut S:0 cutopen 0 : 0
123 45 6
abc de fghi
0012 99 a1b2c
x 10 xyz 007
123 45 6
)

Expected =: 123;4;99;10;123

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo MaxStr y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: MaxStr&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR..." to process strings'
    echo 'or   "./ch-1.ijs"        to run the examples'
end.
)

exit ''
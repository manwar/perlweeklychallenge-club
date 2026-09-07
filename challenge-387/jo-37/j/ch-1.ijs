#!/usr/local/bin/jconsole

require 'regex'
rearrange =: <: @ # @ (('01';'10')&rxrplc^:a:)

Examples =: cutopen 0 : 0
111000
00011
01011
010101
00001
)

Expected =:  0;4;3;3;4

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo rearrange 0{:: y
elseif.
    0 = # y
do.
    try.
        echo Examples
        echo Expected
        echo rearrange&.> Examples
        assert. Expected -: rearrange&.> Examples
        NB. assert. ((,'a');'aaaa') -: String &.> Strings
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

exit ''
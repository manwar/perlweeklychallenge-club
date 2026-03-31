#!/usr/local/bin/jconsole

count_prefixes =: +/@:({.@:E.~&>)

Examples =: <;._2 L:0 cutopen 0 : 0
apple a ap app apple banana 
bird cat dog fish 
hello hello he hell heaven he 
coding  code coding cod 
program p pr pro prog progr progra program 
)

Expected =: 4;0;4;3;7

3 : 0 (2}. ARGV)
if.
    2 <: # y
do.
    echo ({. count_prefixes }.) y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: ({. count_prefixes }.)&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR WORD..." to process strings'
    echo 'or   "./ch-1.ijs"             to run the examples'
end.
)

exit ''
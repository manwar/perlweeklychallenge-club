#!/usr/local/bin/jconsole

word_length_product =: ([: >./@, */~@(# S:0) * -.@(+./)@:e.&>/~) : [:

Examples =: cutopen L:0 cutopen 0 : 0
a ab abc d de def
a aa aaa aaaa
meet app code sky bold
a ab abc abcd efghi
xyz w abcdefg hij
)

Expected =: 9; 0; 16; 20; 21

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo word_length_product y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: word_length_product&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR..." to process strings'
    echo 'or   "./ch-2.ijs"        to run the examples'
end.
)

exit ''
#!/usr/local/bin/jconsole

MaxWords =: >./ @ (# S:1) @ (cutopen L:0)

examples =: <;._1 cutopen 0 : 0
§
Hello world
This is a test
Perl is great
§
Single
§
Short
This sentence has seven words in total
A B C
Just four words here
§
One
Two parts
Three part phrase
§
The quick brown fox jumps over the lazy dog
A
She sells seashells by the seashore
To be or not to be that is the question
)
 

3 : 0 (2}. ARGV)
if.
    1 < # y
do.
    echo MaxWords y
elseif.
    0 = # y
do.
    try.
        assert. (4; 1; 7; 3; 10) -: MaxWords &.> examples
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

exit^:(0&>@(4!:0) <'noexit') ''
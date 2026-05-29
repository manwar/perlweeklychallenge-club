#!/usr/local/bin/jconsole

single_common_word =: _(adverb define)
   singleton =. (1&=@#)/.~ # ~.@]
   uniq_over_boxes =. ~.@:;
   in_box =. ] e. >@[
   count_all =. +/@:(*./)

   ([: count_all ] in_box"0/ uniq_over_boxes)@:(singleton&.>) f. : [:
)

Examples =: cutopen L:0 '|'&cutopen L:0 cutopen 0 : 0
apple banana cherry|banana cherry date
a ab abc|a a ab abc
orange lemon|grape melon
test test demo|test demo demo
Hello world|hello world
)

Expected =: 2; 2; 0; 0; 1

3 : 0 (2}. ARGV)
if.
    2 <: # y
do.
    echo single_common_word cutopen L:0 y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: single_common_word&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs ARR1 ARR2..." to process string arrays'
    echo 'or   "./ch-1.ijs"              to run the examples'
end.
)

exit ''
#!/usr/local/bin/jconsole

count_pre_suf =: _(adverb define)
   matches =. E.
   from =. {
   idx_ps =. 0 , -@#@[
   all =. *./
   pre_suf =. [: all idx_ps from matches

   sort_by_length =. /: #@>
   over_suffices =. ({.` `}.)`:6 \.
   open =. &>
   flat =. ,
   sum =. +/

   sum @: flat @: (pre_suf open over_suffices) @ sort_by_length f. : [:
)

Examples =: cutopen L:0 cutopen 0 : 0
a aba ababa aa
pa papa ma mama
abao ab
abab abab
ab abab ababab
abc def ghij
)

Expected =: 4;2;0;1;3;0

3 : 0 (2}. ARGV)
if.
    1 < # y
do.
    echo count_pre_suf y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: count_pre_suf&.> Examples
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
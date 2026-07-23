#!/usr/local/bin/jconsole

rqm =: _(adverb define)
   NB. find indices of question marks
   qmi =. I.@('?'&=)

   NB. enumerate binary numbers from 0 to 2^y - 1
   NB. as character arrays or pass a zero atom
   enum_bin_str =. ,"2@:(":"0)@:#:@i.@(2&^)^:*

   NB. specialized version of "amend":
   NB. - use x as the indices
   NB. - use u x as the replacement values
   NB. - operate on rows of u x
   a1_ux =. adverb def '(u x) (x })"1 y'

   NB. find indices of question marks in y and
   NB. replace these positions with all binary
   NB. digits in the respective length
   (qmi (enum_bin_str@# a1_ux) ]) f. : [:
)

Examples =: cutopen 0 : 0
01??0
???
1?10
1?1?0
)

Expected =: > L:1 cutopen L:0 cutopen 0 : 0
01000 01010 01100 01110
000 001 010 011 100 101 110  111
1010 1110
10100 10110 11100 11110
)

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo String &.> y
    echo NumList ;".&.> y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: rqm&.> Examples
        assert. '101' -: rqm '101'
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR" to process string'
    echo 'or   "./ch-2.ijs"     to run the examples'
end.
)

exit ''
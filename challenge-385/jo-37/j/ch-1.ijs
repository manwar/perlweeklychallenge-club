#!/usr/local/bin/jconsole

uncommon_words =: _(adverb define)
  NB. convert a string to a list of boxed words
  words =. ;:

  NB. count the frequencies of unique items and
  NB. restrict to single appearances
  singles =. 1&=@(#/.~) # ~.

  NB. split x and y into words,
  NB. join the two lists and
  NB. restrict to singly appearing words
  [: : (singles @ , & words) f.
)

Examples =: '|' cutopen L:0 cutopen 0 : 0
apple banana apple|banana orange
cat dog|bird fish
the quick brown fox|the quick
hello|hello
blue blue red|red green green yellow
)

Expected =: cutopen L:0 cutopen 0 : 0
orange
cat dog bird fish
brown fox
 
yellow
)
3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo (uncommon_words&>)/ y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: (uncommon_words&>/)&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR1 STR2" to process strings'
    echo 'or   "./ch-1.ijs"           to run the examples'
end.
)

exit ''
#!/usr/local/bin/jconsole

freq_sum =: _(adverb define)
   NB. lower case letters as a character array
   ll =. a. {~ 97 + i.26

   NB. select the lower case letters from a character array
   sel_ll =. #~ e.&ll

   NB. vowels as a character array
   vowels =. 'aeiou'

   NB. apply the left operand to the group of vowels
   NB. and the group of other characters
   by_vo =. (/.~)`(e.&vowels)`:6

   NB. find the frequency of unique items
   freq =. #/.~

   NB. maximum over items
   max =. >./

   NB. sum over items
   sum =. +/

   NB. select lower case letters, find the maximum frequency
   NB. of unique characters over vowels / others
   NB. and take the sum over these
   (sum @: (max @: freq by_vo) @ sel_ll) f. : [:
)

Examples =: cutopen 0 : 0
banana
teestett
aeiouuaa
rhythm
x
)

Expected =: 5; 7; 3; 2; 1

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo freq_sum > {. y
elseif.
    0 = # y
do.
    try.
        assert Expected -: freq_sum&.> Examples
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
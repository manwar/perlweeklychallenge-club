#!/usr/local/bin/jconsole

reverse_degree =: _(adverb define)
   NB. lower case letters as a character array
   ll =: a. {~ 97 + i.26

   NB. the reverse index or zero
   ridx =. 26 - ll&i.

   NB. counting from one upwards
   pos =. >: @ i. @ #

   NB. sum over items
   sum =. +/

   NB. sum over position times reverse index
   ([: sum pos * ridx) f.  : [:
)

Examples =: cutopen 0 : 0 
z
a
bbc
racecar
zyx
)

Expected =: 1; 26; 147; 560; 14

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo reverse_degree > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: reverse_degree&.> Examples
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
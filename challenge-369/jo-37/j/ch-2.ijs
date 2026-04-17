#!/usr/local/bin/jconsole

NB. tacit adverb inserting the fill atom in a verb train
NB. usage: size fill group str
group =: (_&,@[)`(($!.)!.>.)`]`:6

Examples =: ' '&cutopen&.> cutopen 0 : 0
RakuPerl 4 *
Python 5 0
12345 3 x
HelloWorld 3 _
AI 5 !
)

Expected =: ' '&cutopen&.> cutopen 0 : 0
Raku Perl
Pytho n0000
123 45x
Hel loW orl d__
AI!!!
)

3 : 0 (2}. ARGV)

NB. extract args / op from (character) y =: str;size;fill
do_group =. {{
    str =. 0&{::
    size =. ".@(1&{::)
    fill =. (2;0)&{::
    (size (fill y) group str) y
}}

if.
    3 = # y
do.
    echo do_group y
elseif.
    0 = # y
do.
    try.
        assert. (> L:1 Expected) -: do_group&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR SIZE FILL" to process args'
    echo 'or   "./ch-1.ijs"               to run the examples'
end.
)

exit ''
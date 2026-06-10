#!/usr/local/bin/jconsole

reverse_ex =: adverb define
   infix_dyad =. conjunction : 'n&(x&u\) y'
   any =. +./
   substr_in =. any @: E.~
   reverse =. |.

   ([: any reverse substr_in infix_dyad m ]) f. : [:
)

Examples =: 'abcba';'racecar';'abcd';'banana';'hello'
Expected =: 1;1;0;1;1

3 : 0 (2}. ARGV)

reverse_ex2 =. 2 reverse_ex

if.
    1 = # y
do.
    echo reverse_ex2 > {. y
elseif.
    2 = # y
do.
    echo (".@(1&{::) y) reverse_ex > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: reverse_ex2&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR [L]" to process string [and length]'
    echo 'or   "./ch-1.ijs"         to run the examples'
end.
)

exit ''
#!/usr/local/bin/jconsole

EchoChamber =: #~ >:@i.@#

Examples =: cutopen 0 : 0
abca
xyz
code
hello
a
)

Expected =: cutopen 0 : 0
abbcccaaaa
xyyzzz
coodddeeee
heelllllllooooo
a
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo EchoChamber > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: EchoChamber&.> Examples
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
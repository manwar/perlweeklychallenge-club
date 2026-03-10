#!/usr/local/bin/jconsole

GoalParser =: ('(al)';'al';'()';'o')&stringreplace

Examples =: cutopen 0 : 0
G()(al)
G()()()()(al)
(al)G(al)()()
()G()G
(al)(al)G()()
)

Expected =: cutopen 0 : 0
Goal
Gooooal
alGaloo
oGoG
alalGoo
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo GoalParser > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: GoalParser&.> Examples
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
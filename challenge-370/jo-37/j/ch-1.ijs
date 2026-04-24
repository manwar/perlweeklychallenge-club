#!/usr/local/bin/jconsole

require 'regex'

notIn =. ] #~ [: -. e.~
cntUniq =. |:@((>@[ ; #@])/..~)
maxInd =. 1 i.~ ] = >./
popularWord =: [ ([: ([ {::~ maxInd@:>@])/ [: cntUniq notIn) f. '[a-z]+' rxall tolower@]

Examples =: '|'&cutopen&.> cutopen 0 : 0
Bob hit a ball, the hit BALL flew far after it was hit.|hit
Apple? apple! Apple, pear, orange, pear, apple, orange.|apple|pear
A. a, a! A. B. b. b.|b
Ball.ball,ball:apple!apple.banana|ball
The dog chased the cat, but the dog was faster than the cat.|dog|cat
)

Expected =: cutopen 0 : 0
ball
orange
a
apple
the
)

3 : 0 (2}. ARGV)
if.
    2 <: # y
do.
    echo (,&.>@}. popularWord >@{.) y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: ( }. popularWord >@{.)&.>  Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR BAN..." to process string'
    echo 'or   "./ch-1.ijs"            to run the examples'
end.
)

exit ''
#!/usr/local/bin/jconsole

rev_from =: {~ -@>:@i.@# : [:
rev_substr =: (0 ,: __)&(];.0)

Examples =: <;._2 (0 : 0)

reverse the given string
Perl is Awesome
v1.0.0-Beta!
racecar
)

Expected =: <;._2 (0 : 0)

gnirts nevig eht esrever
emosewA si lreP
!ateB-0.0.1v
racecar
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo rev_from > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: rev_from&.> Examples
        assert. Expected -: rev_substr&.> Examples
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
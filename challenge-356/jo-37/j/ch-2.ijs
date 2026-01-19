#!/usr/local/bin/jconsole

require 'format/printf'
WhoWins =: 3 : 0
    result =. 0, y e. 'A'
    week1 =. (1, 1), (2, 7), (3, 6) ,: 4, 5
    iweek2 =. 0 3,: 1 2
    s1 =. ;/ (i.4) ,. (i.4) { result
    s2 =. ;/ (i.2) ,. (4 + i.2) { result
    s3 =. 6 { result
    |.^:s3 /:~ s2 { iweek2 { /:~ s1 { week1
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    'Team %d defeated Team %d' printf WhoWins > 0 { y
elseif.
    0 = # y
do.
    try.
        assert. (2 6; 1 2; 4 2; 4 6; 5 1) -: WhoWins&.> 'HAHAHH'; 'HHHHHH'; 'HHHAHA'; 'HAHAAH'; 'HAAHAA'
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

exit^:(0&>@(4!:0) <'noexit') ''


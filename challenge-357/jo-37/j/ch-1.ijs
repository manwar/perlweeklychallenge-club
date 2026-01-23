#!/usr/local/bin/jconsole

b =: 10
l =: 4
td =: (l $ b)&#:
fd =: b&#.
kap =: (-~&fd |.)@/:~@td

kaplim =: {{
_3 Z: 20
(] [ 1&Z:@=)/@(kap^:(<2)) y
}}

final =: {{_1:^:(0 = y) Z:2}}

kapcount =: final F. kaplim

Examples =: 3524; 6174; 9998; 1001; 9000; 1111
Expected =: 3; 0; 5; 4; 4; _1

3 : 0 (> ".&.> 2}. ARGV)
if.
    1 = # y
do.
    echo kapcount  > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: kapcount&.> Examples
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


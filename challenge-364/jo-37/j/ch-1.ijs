#!/usr/local/bin/jconsole

require 'regex'

onIdx =: [.&.:(a:`(].&i.))
alpha =: 26 (+ i.)~ onIdx a. 'a'
coderx =: '(1[0-9]|2[0-6])#|([1-9])'
decrypt =: {&alpha@<:@".@('#'&delstring)
DecryptString =: coderx&(decrypt rxapply)

Examples =: cutopen 0 : 0
10#11#12
1326#
25#24#123
20#5
1910#26#
)

Expected =: cutopen 0 : 0
jkab
acz
yxabc
te
aijz
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo DecryptString > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: DecryptString&.> Examples
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
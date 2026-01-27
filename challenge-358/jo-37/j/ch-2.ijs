#!/usr/local/bin/jconsole

onIdx =: {{u&.:(a:`(n&i.))}}

alpha =: 26 (+ i.)~ onIdx a. 'a'
encrypt =: (#alpha)&|@:+ onIdx alpha

Examples =: <@cut S:0 cutopen 0 : 0
abc 1
xyz 2
abc 27
hello 5
perl 26
)

Expected =: 'bcd';'zab';'bcd';'mjqqt';'perl'

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo (".@] encrypt [)&>/ y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: (".@] encrypt [)&.>/"1 >Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR N" to encrypt string'
    echo 'or   "./ch-1.ijs"       to run the examples'
end.
)

exit ''
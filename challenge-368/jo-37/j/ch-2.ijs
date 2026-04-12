#!/usr/local/bin/jconsole

omega =: [: +/ [ ^~ [: {: 2&p:@]

Examples =: 0 100061; 0 971088; 1 63640; 1 988841; 0 211529
Expected =: 3; 3; 6; 2; 2

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo omega/ ". > y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: omega/&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs MODE NUM" to process numbers'
    echo 'or   "./ch-1.ijs"          to run the examples'
end.
)

exit ''
#!/usr/local/bin/jconsole

largest_substring =: ] ([: <: [: >./ i: - i.) ~.

Examples =: 'aaaaa';'abcdeba';'abbc';'abcaacbc';'laptop'
Expected =: 3; 5; 0; 4; 2

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo largest_substring > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: largest_substring&.> Examples
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
#!/usr/local/bin/jconsole

convert_palindrome =: (] ,~ [: |. ] }.~ >:@i:&1@((|. -: ])\)) : [:

Examples =: ;:'pinnipeds abcd bananas dissident cailliachs'
Expected =: ;:'sdepinnipeds dcbabcd sananabananas tnedissident shcailliachs'

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo convert_palindrome 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: convert_palindrome&.> Examples
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
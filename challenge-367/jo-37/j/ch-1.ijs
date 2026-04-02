#!/usr/local/bin/jconsole

max_odd_binary =: # ('101' #~ <:@] , - , 1:) +/@('1'&=)

Examples =: '1011'; '100'; '111000'; '0101'; '1111'
Expected =: '1101'; '001'; '110001'; '1001'; '1111'

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo max_odd_binary > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: max_odd_binary&.> Examples
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
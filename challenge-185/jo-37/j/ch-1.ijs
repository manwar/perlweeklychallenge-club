#!/usr/local/bin/jconsole

NB. Implementation
conv_mac =: ':' joinstring [: , [: <"1@((_ 2)&$);._1 ('.' , ]) : [:


NB. Command line processing and tests
3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    try.
        echo conv_mac 0 {:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        Examples =. '1ac2.34f0.b1c2';'abc1.20f1.345a'
        Expected =. '1a:c2:34:f0:b1:c2';'ab:c1:20:f1:34:5a'
        
        echo Examples
        Result =. conv_mac&.> Examples
        echo Result
        assert. Expected -: Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-1.ijs MAC" to convert MAC address'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''

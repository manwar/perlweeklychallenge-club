#!/usr/local/bin/jconsole

maxfib =. {.@(] (({:@] , +/@])^:([ >: {:@])^:_) (1 1)"_)

getnext =. {{
1 Z: 0&=@{. y
{: y
}}

getfib =. (maxfib ([ ,~ -~) ])@{. f.

zr =: getnext F: getfib f.


NB. numerize and listify inside boxes
Examples =: ".&.> cutopen 0 : 0
4
12
20
96
100
)

Expected =: ".&.> cutopen 0 : 0
3 1
8 3 1
13 5 2
89 5 2
89 8 3
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo zr ". > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: zr&.> Examples
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
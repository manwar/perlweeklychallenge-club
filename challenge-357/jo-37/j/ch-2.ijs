#!/usr/local/bin/jconsole

frac =: <@('/'&joinstring)@(8!:0)"1@(2&x:)@/:~@~.@,@(%/~)@(x:@>:@i.)

Examples =: 3; 4; 1; 6; 5
Expected =: (<;._1@(' '&,))&.> cutopen 0 : 0
1/3 1/2 2/3 1/1 3/2 2/1 3/1
1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1
1/1
1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1 6/1
1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1
)

3 : 0 (> ".&.> 2}. ARGV)
if.
    1 = # y
do.
    echo frac {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: frac&.> Examples
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
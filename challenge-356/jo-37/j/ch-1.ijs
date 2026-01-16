#!/usr/local/bin/jconsole

coclass 'Kolakosi'
create =: 3 : 'sequence =: (1, 2); 2'
destroy =: codestroy
run =: ((, {.@]) ; }.@] , {.@] # >:@(2&|)@#@[)&>/
count =: +/@(1&(e.~))@(3&}.)@([ (+/@{. {. ]) ;@])
ones =: 3 : 0
    sequence =: run^:(0&>.@(y&-)@#@>@{.@]) sequence
    y count sequence
)

cocurrent 'base'

K =: 0 conew 'Kolakosi'

3 : 0 (> ".&.> 2}. ARGV)
if.
    1 <: # y
do.
    echo ones__K"0 y
elseif.
    0 = # y
do.
    try.
        assert. (2; 3; 3; 4; 4) -: ones__K&.> (4; 5; 6; 7; 8)
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs N..." to process numbers'
    echo 'or   "./ch-1.ijs"      to run the examples'
end.
)

exit^:(0&>@(4!:0) <'noexit') ''


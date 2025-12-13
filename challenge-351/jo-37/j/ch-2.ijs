#!/usr/local/bin/jconsole

load 'math/mt'

mrankint =: 3 : 0
    rcond =. >0{y
    rank =. >1{y
    a =. >2{y
    result =. rcond gelpf_mt_ a
    (3 4 {result), 2{y
)

mrank =: 3 : 0
    result =. mrankint^:_ FP_EPS_mt_;0;y
    >1{result
)

ArithProg =: {{1 = mrank (}. -"1 {.) |: (,: ((] i.~ /:~) i.@#)) y}}

NB. numerize and listify inside boxes
Examples =: ".&.> cutopen 0 : 0
1 3 5 7 9
9 1 7 5 3
1 2 4 8 16
5 _1 3 1 _3
1.5 3 0 4.5 6
)

3 : 0 ".&> 2}. ARGV
if.
	3 <: # y
do.
    1 = mrank (}. -"1 {.)  |: (,: i.@#)@:/:~ y
	echo ArithProg y
elseif.
	0 = # y
do.
	try.
		assert. (1; 1; 0; 1; 1) -: ArithProg &.> Examples
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

exit ''

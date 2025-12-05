#!/usr/local/bin/jconsole

NumGoodStrings =: {{+/ x(x&=@:#@:~.)\ y}}

Examples =: cutopen 0 : 0
abcaefg
xyzzabc
aababc
qwerty
zzzaaa
)

3 : 0 (2}. ARGV)
if.
	1 = # y
do.
	echo 3 NumGoodStrings ;y
elseif.
	0 = # y
do.
	try.
		assert. (5; 3; 1; 4; 0) -: 3&NumGoodStrings &.> Examples
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

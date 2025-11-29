#!/usr/local/bin/jconsole

PowerString =: 3 : 0
if.
	2 > #y
do.
	#y
else.
	1 + >./ ([*+) /\. 2=/\ y
end.
)

Ex =: cutopen 0 : 0
textbook
aaaaa
hoorayyy
x
aabcccddeeffffghijjk
)

3 : 0 (2}. ARGV)
if.
	1 = # y
do.
	echo PowerString ;> y
elseif.
	0 = # y
do.
	try.
		assert. (2; 5; 3; 1; 4) -:  PowerString &.> Ex
		echo 'tests succeeded'
	catch.
		echo 'tests failed '
	end.
else.
	echo 'Call "./ch-1.ijs STR" to process string'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''

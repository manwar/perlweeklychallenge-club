#!/usr/local/bin/jconsole

Dir =: 'UDRL'
Move =: 5 2 $ 1 0 _1 0 0 1 0 _1 0 0
MeetingPoint =: {{(0 0) e. +/\ (Dir i. y) { Move}}

Ex =: cutopen 0 : 0
ULD
ULDR
UUURRRDDD
UURRRDDLLL
RRUULLDDRRUU
)

3 : 0 (2}. ARGV)
if.
	1 = # y
do.
	echo MeetingPoint ;> y
elseif.
	 0 = # y
do.
	try.
		assert. (0; 1; 0; 1; 1) -:  MeetingPoint &.> Ex
		echo 'tests succeeded'
	catch.
		echo 'tests failed'
	end.
else.
	echo 'Call "./ch-2.ijs STR" to process string'
    echo 'or   "./ch-2.ijs"     to run the examples'
end.
)

exit ''

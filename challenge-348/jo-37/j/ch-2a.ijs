#!/usr/local/bin/jconsole

NB. Play with J

ConvertTime =: {{+/ 24 4 3 5 #: (24 * 60) | -~/ 24 60 #. y}}

Examples =: 5 2 $ ". >cutopen 0 : 0
2 30
2 45

11 55
12 15

9  0
13  0

23 45
0 30

14 20
15 25
)

3 : 0 > 2}. ARGV
if.
	2 = # y
do.
	try.
		Times =. ". > ('([0-9]+):([0-9]+)'; 1 2)(rxmatch rxfrom ]) "1 y
		echo ConvertTime Times
	catch.
		echo 'invalid arguments'
	end.
elseif.
	0 = # y
do.
	try.
		assert (1 2 4 3 2) = ConvertTime "2 Examples
		echo 'tests succeeded'
	catch.
		echo 'tests failed'
	end.
else.
	echo 'Call "./ch-2a.ijs H1:M1 H2:M2" to process times'
    echo 'or   "./ch-2a.ijs"             to run the examples'
end.
)

exit ''

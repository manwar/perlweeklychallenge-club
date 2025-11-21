#!/usr/local/bin/jconsole

ConvertTime =: {{+/ 24 4 3 5 #: (24 * 60) | -~/ 24 60 #. > y}}

3 : 0 > 2}. ARGV
if.
	2 = # y
do.
	TR =: '([0-9]+):([0-9]+)'
	try.
		echo ConvertTime ". > {{((TR; 1 2) rxmatch y) rxfrom y}} "1 y
	catch.
		echo 'invalid arguments'
	end.
elseif.
	0 = # y
do.
	echo ConvertTime 2 30; 2 45
	echo ConvertTime 11 55; 12 15
	echo ConvertTime 9 0; 13 0
	echo ConvertTime 23 45; 0 30
	echo ConvertTime 14 20; 15 25
else.
	echo 'Call "./ch-2.ijs H1:M1 H2:M2" to process times'
    echo 'or   "./ch-2.ijs"             to run the examples'
end.
)

exit ''

#!/usr/local/bin/jconsole

SpecialAvg =: {{(+/ % #) (#~ -.@(e. (<./ , >./))) y}}

NB. numerize and listify inside boxes
Examples =: ".&.> cutopen 0 : 0
8000 5000 6000 2000 3000 7000
100000 80000 110000 90000
2500 2500 2500 2500
2000
1000 2000 3000 4000 5000 6000
)

3 : 0 ".&> 2}. ARGV
if.
	1 <: # y
do.
	
	echo SpecialAvg y
elseif.
	0 = # y
do.
	try.
		assert. (5250; 95000; 0; 0; 3500) -: SpecialAvg&.> Examples
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

#!/usr/local/bin/jconsole

Vows =: 'aeiouAEIOU'
halve =: {{((-.(2|#y))*(<. -: #y))({. ; }.)y}}
countvows =: {{+/ (#Vows) > Vows i. y}}
stringalike =: {{-. 0 = (=/ * */) countvows "1 > halve >y}}

Ex =: cutopen 0 : 0
textbook
book
AbCdEfGh
rhythmmyth
UmpireeAudio
)

3 : 0 > 2}. ARGV
if.
	1 = # y
do.
	echo stringalike 0 { y
elseif.
	0 = # y
do.
	try.
		assert (0 1 1 0 0) =  stringalike "0 Ex
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

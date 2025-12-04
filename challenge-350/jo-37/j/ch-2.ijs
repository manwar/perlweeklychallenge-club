#!/usr/local/bin/jconsole

ShufflePairs =: 3 : 0
    sd =. /:~&:":"0
    mult =. <.&:(] %~ 10&^&:(>:&:(<.&:(10&^.))))
    mlist =. >:&:i.&:mult * ]
    pairs =. ;/&:sd&:mlist
    +/ ({. = }.) boxopen pairs y
)

FromTo =: {{x + i. 1 + y - x}}

3 : 0 (2}. ARGV)
if.
	3 = # y
do.
	'from to count' =. ".&.> y
	echo +/ count&<:&:ShufflePairs"0 from FromTo to
elseif.
	4 = # y
do.
	'from to count verbose' =. ".&.> y
	 echo (count&<:&:ShufflePairs"0 # ]) from FromTo to
elseif.
	0 = # y
do.
	try.
		assert.  0 = +/ 1&<:&:ShufflePairs"0 (1 FromTo 1000)
		assert.  3 = +/ 1&<:&:ShufflePairs"0 (1500 FromTo 2500)
		assert.  2 = +/ 5&<:&:ShufflePairs"0 (1000000 FromTo 1500000)
		assert. 11 = +/ 2&<:&:ShufflePairs"0 (13427000 FromTo 14100000)
		assert.  2 = +/ 1&<:&:ShufflePairs"0 (1030 FromTo 1130)
		echo 'tests succeeded'
	catch.
		echo 'tests failed'
		echo 13!:12''
	end.
else.
	echo 'Call "./ch-2.ijs FROM TO COUNT [1]" to process the arguments'
    echo 'or   "./ch-2.ijs"                   to run the examples'
end.
)

exit ''

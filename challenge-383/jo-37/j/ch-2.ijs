#!/usr/local/bin/jconsole

web_hex =: _(adverb define)
   NB. drop first item from y
   behead =. }.

   NB. convert integer to 2-digit hex string
   NB. (it has a default inverse)
   hex =. '0123456789ABCDEF' {~ ((2 $ 16)&#:)

   NB. floor((y + 25) / 51) * 51
   round_51 =. [: <.&.(%&51) 25 + ]

   NB. flatten to 1-d (monad)
   ravel =. ,

   NB. append (dyad)
   append =. ,
    
   NB. first item from y
   head =. {.

   NB. - drop first character from y
   NB. - apply to groups of 2 characters:
   NB.   - convert from hex string to integer
   NB.   - round to nearest multiple of 51
   NB.   - (implicitely) convert from integer to hex string
   NB. - flatten the result
   NB. - prepend the first character from y
   (head append [: ravel _2 round_51&.:(hex inv)\ behead) f. : [:
)

Examples =: cutopen 0 : 0
#F4B2D1
#15E6E5
#191A65
#2D5A1B
#00FF66
)

Expected =: cutopen 0 : 0
#FF99CC
#00FFCC
#003366
#336633
#00FF66
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo web_hex 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: web_hex&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR" to process string'
    echo 'or   "./ch-2.ijs"     to run the examples'
end.
)

exit ''
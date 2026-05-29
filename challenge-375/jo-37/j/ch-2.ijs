#!/usr/local/bin/jconsole

beauty =: adverb define
   to_digits =. m&#.inv
   from_digits =. m&#.
   divisible =. -.@*@|~
   sum =. +/

   [: : ([: sum ] divisible [ from_digits\ to_digits@]) f.
)

Examples =: ". L:0 cutopen L:0 cutopen 0 : 0
240 2
1020 2
444 2
17 2
123 1
)

Expected =: 2; 3; 0; 1; 2

3 : 0 (2}. ARGV)
beauty_dec =. 10 beauty
if.
    2 = # y
do.
    echo beauty_dec&>/ ". L:0 y
elseif.
    3 = # y
do.
    in =. ". L: 0 y
    base =. 2 {:: in
    beauty_b =. base beauty
    echo beauty_b&>/ 2 {. in
elseif.
    0 = # y
do.
    try.
        beauty_dec =. 10 beauty
        assert. Expected -: beauty_dec~&>/&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs K N [B]" to find K-beauty of N in base B'
    echo 'or   "./ch-2.ijs"         to run the examples'
end.
)

exit ''
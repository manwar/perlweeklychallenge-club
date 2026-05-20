#!/usr/local/bin/jconsole

same_digits =: adverb define
   to_digits =. m&#.^:_1
   from_digits =. m&#.
   with_same =. /.~
   max =. >./

   max @: (from_digits with_same) @ to_digits f. : [:
)

Examples =: 6777133339; 1200034; 44221155; 88888; 11122233
Expected =: 3333; 4; 55; 88888; 222


3 : 0 (". > 2}. ARGV)
same_dec_digits =: 10 same_digits
if.
    1 = # y
do.

    echo same_dec_digits {. y
elseif.
    2 = # y
do.
    echo (1 { y) same_digits (0 { y)
elseif.
    0 = # y
do.
    try.
        assert. Expected -: same_dec_digits&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs NUM [BASE]" to process number [under base]'
    echo 'or   "./ch-1.ijs"            to run the examples'
end.
)

exit ''
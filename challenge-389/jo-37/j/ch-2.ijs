#!/usr/local/bin/jconsole

NB. find the maximum length of a zig-zag subarray
zig_zag =: _(adverb define)
  NB. alternating compare adjacent pairs as "x cmp y" and "y cmp x"
  pair_alt_cmp =. [: * 2 (-/)`(-~/)\ ]

  NB. a "1" followed by "1"s at positions where the value in y changes:
  NB. this marks the frets for intervals of running equal values
  ri =. 1 , 2 ~:/\ ]

  NB. find the lengths of intervals specified by x, for nonzero values only
  rl_nz =. (# * |@{.);.1

  NB. max over a list
  max =. >./

  NB. increment by one
  inc =. >:

  NB. - get steps with alternating signs
  NB. - get run lengths of non-zero values
  NB. - find the maximum
  NB. - increment
  inc @ max @ (rl_nz~ ri) @ pair_alt_cmp f. : [:
)

Examples =: ". L:0 cutopen 0 : 0
9 4 2 10 7 8 8 1 9
1 7 4 9 2 5
1 2 3 4 5
4 4 4
10 20 15 12 18
)

Expected =: <"0 [ 5 6 2 1 3

3 : 0 (2}. ARGV)
if.
    2 <: # y
do.
    echo zig_zag ". S:0 y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: zig_zag&.> Examples
        assert. 4 -: zig_zag 3 5 2 4 4 4 4 4
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs N..." to process numbers '
    echo 'or   "./ch-2.ijs"      to run the examples'
end.
)

exit ''
#!/usr/local/bin/jconsole

pythagoras_multiplied =: verb define
  NB. Taken from Wiki: https://code.jsoftware.com/wiki/Essays/Divisors
  divisors =. /:~ @: , @: > @: (*/&.>/) @: ((^ i.@>:)&.>/) @: (__&q:)
  count =. 0
  for_r. +: >: i. <. -: y % >: %: 2 do.
    q =. -: *: r
    div =. divisors q
    for_s. div do.
      if. y >: r + s + q % s do.
        count =. count + (# div) - +: s_index
        break.
      end.
    end.
  end.

  count
)

Examples =: 20; 7; 1; 15; 30
Expected =: 12; 2; 0; 8; 22

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo pythagoras_multiplied ". 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: pythagoras_multiplied&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR" to process string'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''
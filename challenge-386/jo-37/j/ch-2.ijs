#!/usr/local/bin/jconsole

require 'regex'

to_frac =: verb define
  NB. a temporary verb to pick the parts from y,
  NB. convert the strings to extended integers and
  NB. calculate the decimal powers of their lengths
  rh =. rxcomp '^(\d*)\.(\d*)(?:\((\d+)\))?$'
  parse =. (0&".@(,&'x') , 10x ^ #) S:0 @((rh;1 2 3)&(rxmatch rxfrom ]))

  NB. parse y and assign values
  'i em f en p eq' =. , parse y

  NB. provide a default for an empty periodic part and
  NB. decrement eq
  eqd =. p <:@(2:^:(-.@*@[)) eq

  NB. insert the values into the formula
  (p + eqd * f + en * i) % (eqd * en)
)

Examples =: cutopen L:0 cutopen 0 : 0
0.(12) 0.(121)
0.1(23) 0.12(32)
0.1(234) 0.12(342)
12.99(99) 13.
0.(123) 0.1(231)
)

Expected =: 0;1;1;1;1

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo =/@:(to_frac@>) y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: (=/&:(to_frac@>))&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs R1 R2" to process numbers'
    echo 'or   "./ch-2.ijs"       to run the examples'
end.
)

exit ''
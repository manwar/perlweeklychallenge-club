#!/usr/local/bin/jconsole
require 'convert/pjson'

has_shape =: _(adverb define)
  NB. sign of the difference between adjacent elements
  steps =. 2 (*@(-~)/)\ ]

  NB. indicator where y changes value
  group_equal =. 1 , 2&(~:/\)

  NB. pick first element from groups in y defined by x
  first_from =. {.;.1

  NB. calculate steps, group by equal values,
  NB. pick the first item from each group and
  NB. compare to the target array.
  [: : ([ ([ -: ] first_from~ group_equal@])  steps) f.
)
is_trionic =: (1 _1 1)&has_shape f.

from_ex =: verb define
  :
  get_i =. <@[ i.~ {.@|:@]
  ex_i =. 'examples' get_i y
  ex =. >> {: ex_i { y
  sel_i =. x get_i {. ex
  (<((<a:), (<sel_i), (<1))) { ex
)

3 : 0 (2}. ARGV)
if.
    4 <: # y
do.
    echo is_trionic ". S:0 y
elseif.
    0 = # y
do.
    try.
        Ex =: dec_pjson_ fread ('/../../examples/json/ch-2.json' ,~ ] {.~ '/' i:~ ]) (1 {:: ARGV)
        Examples =: 'in' from_ex Ex
        Expected =: 'out' from_ex Ex

        echo Examples
        Result =: is_trionic&.> Examples
        echo Result

        assert. Expected -: , L:0 Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs I1 I2 I3 I4 ..." to process integers'
    echo 'or   "./ch-2.ijs"                 to run the examples'
end.
)

exit ''

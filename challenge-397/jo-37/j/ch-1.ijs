#!/usr/local/bin/jconsole
require 'convert/pjson'
ARGV =: 397 (setargv :: ]) ARGV

spaaa =: _(adverb define)
  NB. floor of average, zero if negative
  avg_floor_nn =. 0 >. [: <. +/ % #
  NB. return y + 1 as result,
  NB. check if it is contained in x and
  NB. end the loop with the current result if it is not found
  find_missing =. {{ (>: y) ([ [ 1 Z: -.@e.) x }}

  ([ (] F. find_missing) avg_floor_nn) f. : [:
)

from_ex =: verb define
  :
  echo x
  get_i =. <@[ i.~ {.@|:@]
  ex_i =. 'examples' get_i y
  ex =. >> {: ex_i { y
  x_i =. x get_i {. ex
  (<(<x_i),(<1)) { 0 |: ex
)

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    try.
        echo spaaa ". S:0 y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        Ex =: dec_pjson_ fread ('/../../examples/json/ch-1.json' ,~ ] {.~ '/' i:~ ]) (1 {:: ARGV)

        Name =: 'name' from_ex Ex
        Examples =: 'in' from_ex Ex
        Expected =: 'out' from_ex Ex
        echo Name ,. Examples ,. Expected

        Result =: ,@spaaa&.> Examples
        echo Result
        assert. Expected -: Result
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

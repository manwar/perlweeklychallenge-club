#!/usr/local/bin/jconsole
require 'convert/pjson'
ARGV =: 398 (setargv :: ]) ARGV

avg_m6 =: _(adverb define)
  m6 =. ] #~ -. @ * @ (6&|)
  avg =. +/ % #
  round =. <. @ (0.5&+)
  (round @ avg @ m6) f. : [:
)

from_ex =: verb define
  :
  get_i =. <@[ i.~ {.@|:@]
  ex_i =. 'examples' get_i y
  ex =. >> {: ex_i { y
  x_i =. x get_i {. ex
  (<(<x_i),(<1)) { 0 |: ex
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    try.
        echo avg_m6 0{:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        Ex =. dec_pjson_ fread ('/../../examples/json/ch-1.json' ,~ ] {.~ '/' i:~ ]) (1 {:: ARGV)

        Name =. 'name' from_ex Ex
        Examples =. 'in' from_ex Ex
        Expected =. 'out' from_ex Ex
        echo Name ,. Examples ,. Expected

        Result =. , L:0 avg_m6&.> Examples
        echo Result
        assert. Expected -: Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-1.ijs STR" to process string'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''

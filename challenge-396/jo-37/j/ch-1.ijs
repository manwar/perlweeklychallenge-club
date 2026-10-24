#!/usr/local/bin/jconsole
require 'convert/pjson'

NB. select items from 'x' that are contained in 'y'
finishing_order =: [: : e. # [

from_ex =: verb define
  :
  get_i =. <@[ i.~ {.@|:@]
  ex_i =. 'examples' get_i y
  ex =. >> {: ex_i { y
  sel_i =. x get_i {. ex
  (<((<a:), (<sel_i), (<1))) { ex
)

3 : 0 ". L:0 (2}. ARGV)
if.
    2 = # y
do.
    echo (0&{:: finishing_order 1&{::) y
elseif.
    0 = # y
do.
    try.
        Ex =: dec_pjson_ fread ('/../../examples/json/ch-1.json' ,~ ] {.~ '/' i:~ ]) (1 {:: ARGV)
        Examples =: 'in' from_ex Ex
        Expected =: 'out' from_ex Ex

        echo >Examples
        Result =: finishing_order&>/&.> Examples
        echo Result

        assert. Expected -: Result
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
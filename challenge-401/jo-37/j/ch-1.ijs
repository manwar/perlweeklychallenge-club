#!/usr/local/bin/jconsole
require 'convert/pjson'
require 'regex'

ARGV =: 401 (setargv :: ]) ARGV

NB. Implementation

frac_add_sub =: '\d+r\d+'&(('_';'-') stringreplace '/' joinstring 0 (<@":"0) 2 x: [: +/ @: (0&".) @: (;"1) (_ 2) $ ] rxcut~ [ rxmatches ])@(('/';'r';'-';'_';'+';' ')&stringreplace)


NB. Command line processing and tests
3 : 0 (2}. ARGV)
from_ex =. {{
  :
  get_i =. <@[ i.~ {.@|:@]
  ex_i =. 'examples' get_i y
  ex =. >> {: ex_i { y
  x_i =. x get_i {. ex
  (<(<x_i),(<1)) { 0 |: ex
}}

if.
    1 = # y
do.
    try.
        echo frac_add_sub 0{:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        Ex =. dec_pjson_ fread ('/../../examples/json/ch-1.json' ,~ ] {.~ '/' i:~ ]) (1 {:: ARGV)

        Name =. 'name' from_ex Ex
        Examples =: 'in' from_ex Ex
        Expected =. 'out' from_ex Ex
        echo Name ,. Examples ,. Expected

        Result =. frac_add_sub L:0 Examples
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

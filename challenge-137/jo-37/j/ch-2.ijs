#!/usr/local/bin/jconsole
require 'convert/pjson'
ARGV =: 137 (setargv :: ]) ARGV

rev =: [ ` ]: ` (|.&.(10&#.inv)) `: 6

lychrel =: _(adverb define)
  stop =. {{
    _2 Z: 1e7 < y
    (1 Z:~ = rev) y
    0
  }}
  (stop F. (+ rev) :: 1) f. : [:
)

from_ex =: verb define
  :
  get_i =. <@[ i.~ {.@|:@]
  ex_i =. 'examples' get_i y
  ex =. >> {: ex_i { y
  x_i =. x get_i {. ex
  (<(<x_i),(<1)) { 0 |: ex
)

Ex =: dec_pjson_ 0 : 0
{
  "challenge": {
    "week": 137,
    "task": 2,
    "name": "Lychel Number"
  },
  "input_vars": [ "$n" ],
  "examples": [
    {
      "name": "Example 1",
      "in": [56],
      "out": [false]
    },
    {
      "name": "Example 2",
      "in": [57],
      "out": [false]
    },
    {
      "name": "Example 3",
      "in": [59],
      "out": [false]
    },
    {
      "name": "Wiki 1",
      "in": [89],
      "out": [true]
    },
    {
      "name": "Wiki 2",
      "in": [196],
      "out": [true]
    }
  ]
}
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    try.
        echo lychrel 1 ". 0{:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        Name =. 'name' from_ex Ex
        Examples =. 'in' from_ex Ex
        Expected =. 'out' from_ex Ex
        echo Name ,. Examples ,. Expected

        Result =. lychrel"0&.> Examples
        echo Result
        assert. Expected -: Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-2.ijs N" to process number'
    echo 'or   "./ch-2.ijs"   to run the examples'
end.
)

exit ''

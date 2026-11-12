#!/usr/local/bin/jconsole
require 'convert/pjson'
ARGV =: 399 (setargv :: ]) ARGV

NB. Implementation

NB. Create a verb that finds the longest repeated character
NB. reachable with m changes.
lrc =: adverb define
  NB. - Count the frequency of each item in y.
  NB. - Substract the maximum frequency from the length.
  NB.   The result is the number of changes required
  NB.   to make all items equal to the most frequent item.
  NB. - Check if the number from the previous step
  NB.   does not exceed the given x.
  can_eq =. [ >: #@] - [: >./ #/.~@]

  NB. - Apply u to all infixes of y having a size of x.
  NB. - Return x if any call to u returns 1 or
  NB.   x - 1 otherwise.
  try_infix =. [`-`[:`-.`[:`(+./)`(]:\)`:6

  NB. Try infixes of y in decreasing size and
  NB. stop if all items can be made equal
  NB. using the current size.
  ] (m&can_eq try_infix~ f.)^:_  # : [:
)

NB. A verb that uses its x-argument as lrc's m-operand:
lrcv =: dyad def 'x lrc y'


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
    2 = # y
do.
    try.
        echo (0". 1{:: y) lrc 0{:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        Ex =. dec_pjson_ fread ('/../../examples/json/ch-1.json' ,~ ] {.~ '/' i:~ ]) (1 {:: ARGV)

        Name =: 'name' from_ex Ex
        Examples =: 'in' from_ex Ex
        Expected =: 'out' from_ex Ex
        echo Name ,. Examples ,. Expected

        Result =: , L:0 lrcv~&>/ &.> Examples
        echo Result
        assert. Expected -: Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-1.ijs STR N" to process string and number'
    echo 'or   "./ch-1.ijs"       to run the examples'
end.
)

exit ''

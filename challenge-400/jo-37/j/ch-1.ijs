#!/usr/local/bin/jconsole
require 'convert/pjson'
ARGV =: 400 (setargv :: ]) ARGV

NB. Implementation

NB. find the largest interval(s) of numbers having duplicate digits
NB. usage: "limit (mode intervals) start, 0, 0"
NB. where:
NB. - limit is the upper limit for the number
NB. - mode is "_." for the largest interval or "a:" for all (largest) intervals
NB. - start is the starting number
intervals =: adverb define
  NB. argument getter
  '`i run max' =. (0&{@])`(1&{@])`(2&{@])

  NB. inplace value setter
  '`si srun smax' =. (0 })`(1 })`(2 })

  NB. select left operand depending on the
  NB. "uniq" component of "skip":
  if_uniq =. @.({.@[)

  NB. "target" component of "skip"
  targ =. {:@[

  NB. set or increment "i"
  ni =. targ`(targ + i) if_uniq

  NB. reset or increment "run"
  nrun =. (0:)`(targ + run) if_uniq

  NB. set or keep "max"
  nmax =. run`max if_uniq

  NB. integer decadic logarithm
  ldi =. <.@(10&^.)

  NB. find first repeated digit
  frd =. rxcomp '(.)(?<=(?=\1).{2,10})'

  NB. index of first repeated digit
  frdi =. (1 0)&{::

  NB. digits are unique if "frd" did not match
  is_uniq =. 0&> @ ((0 0)&{::) @ ]

  NB. return "(1, skip)" for duplicate digits
  dupl =. 1 , 10 ^  ldi@[ - frdi@]

  NB. the transition points
  tr1 =. 11 * 10 ^ 1 -~ ldi
  tr2 =. 10 ^ 1 + ldi

  NB. smallest next transition point
  ntr =. (] (tr2@[)`]@.(<) tr1)

  NB. number to char array
  to_str =. 0&":@]

  NB. number of trailing zeroes
  ntz =. ((0 1) {:: '0*$' rxmatch to_str)

  NB. step back from transition point to smallest preceding duplicate
  back =. (] [`([ - 10 #. >: @ i. @ <: @ ])@.(1&<@]) ntz)

  NB. digits are always duplicate beyond this value
  stop =. _:^:(9876543210&<)

  NB. return "(0, target)" for unique digits
  uniq =. 0 , stop @ back @ ntr @ [

  NB. distinguish duplicate / unique:
  NB. returns pair "(uniq, target)"
  skip =. (] dupl`uniq@.is_uniq frd rxmatch to_str)@i

  NB. loop over u while x in not less than "i" component of y 
  NB. return final result for n = _. or all for n = a:
  while_ge_i =. conjunction def 'u^:([ >: i)^:n'

  (skip (nmax smax nrun srun ni si ]) ]) while_ge_i m f: 'private' 
)

NB. Find the largest interval starting from 11 up to y and
NB. increment its element count.
largest_interval =: ([: >: 2 { ] (_. intervals) (11 0 0)"_) : [:

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
        echo 0": largest_interval 0". 0{:: y
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
        Expected =: 'out' from_ex Ex
        echo Name ,. Examples ,. Expected

        Result =: ,L:0 largest_interval@{.@:,&.> Examples
        echo Result
        assert. Expected -: Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-1.ijs N" to process number'
    echo 'or   "./ch-1.ijs"   to run the examples'
end.
)

exit ''

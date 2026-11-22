#!/usr/local/bin/jconsole
require 'convert/pjson'
ARGV =: 400 (setargv :: ]) ARGV

NB. Implementation

NB. minimum genetic mutation
NB. usage: "db mgm start, end"
mgm =: _(adverb define)
  NB. argument accessors
  '`start end db' =: (0&{@])`(1&{@])`[

  NB. Create an initial distance matrix for the genes:
  NB. - The distance between two genes is the number of
  NB.   divergent nucleobases for zero or one disagreements.
  NB. - infinity otherwise
  dist =. _:`]@.(1&>:) @ (+/) @: ~:"1 /~

  NB. Create the all pairs shortest path matrix
  NB. using the Floyd-Warshall algorithm.
  NB. See https://code.jsoftware.com/wiki/Essays/Floyd
  floyd =. 3 :('for_j. i.#y';'do. y=. y <. j ({"1 +/ {) y';'end.';'y')

  NB. Accessor for the distance between start and end gene
  NB. from the distance matrix:
  NB. Find the index "ei" of "end" within "(start, db)" and
  NB. select element "(0, ei)".
  NB. Provide infinity on out-of-bound access.
  dist_se =. ] ({::~ :: _) 0 , }:@[ i. {:@[

  NB. transform infinity to minus one
  inf2neg =. (_1:)^:(_&=)

  NB. - Create the distance matrix for the genes except end.
  NB. - Apply Floyd-Warshall to find the shortest paths.
  NB. - Find the distance between start and end gene.
  NB. - Handle infinity.
  [: : ([: ([: inf2neg ] dist_se [: floyd [: dist }:) start , db , end) f.
)

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
    3 <: # y
do.
    try.
        echo (> 2}. y) mgm > 2{. y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
elseif.
    0 = # y
do.
    try.
        Ex =. dec_pjson_ fread ('/../../examples/json/ch-2.json' ,~ ] {.~ '/' i:~ ]) (1 {:: ARGV)

        Name =. 'name' from_ex Ex
        Examples =: 'in' from_ex Ex
        Expected =. 'out' from_ex Ex
        echo Name ,. Examples ,. Expected
        Result =: ,L:0 (>@(2&{::) mgm >@}:)&.> Examples
        echo Result
        assert. Expected -: Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-2.ijs START END BANK..." to process genes'
    echo 'or   "./ch-2.ijs"                   to run the examples'
end.
)

exit ''

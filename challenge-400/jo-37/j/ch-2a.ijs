#!/usr/local/bin/jconsole
require 'convert/pjson'
ARGV =: 400 (setargv :: ]) ARGV

NB. Implementation

require 'dict'

NB. See https://code.jsoftware.com/wiki/Vocabulary/Dictionaries_(addon)#Shortest_paths_Dijkstra's_algorithm
dijkstra =: {{
q =. conew&'jdict' 'tree' ,&< ('keyshape' ; 2) ,: 'valueshape' ; 0
'ds ps' =. ($&_ ; $&_1)@# x  NB. Initialize distances and predecessors.
'' put__q 0 , y [ ds =. 0 y} ds  NB. Distance to source is 0.
while. count__q '' do.
  del__q 'd i' =. min__q ''  NB. Extract the minimum-distance vertex.
  if. d > i { ds do. continue. end.  NB. Skip outdated entry.
  'js ws' =. i { x  NB. Adjacent vertices and edge weights.
  NB. Filter out edges that do not improve shortest paths.
  'js ws' =. (#&js (~.@[ ; <.//.) #&ws) (d + ws) < js { ds
  ds =. ds js}~ d + ws  NB. Update distances.
  ps =. i js} ps  NB. Update predecessors.
  '' put__q js ,.~ d + ws  NB. Insert the updated distance–vertex pairs.
end.
destroy__q ''
ds ; ps
}}"2 0

NB. minimum genetic mutation
NB. usage: "db mgm start, end"
mgm =: _(adverb define)
  NB. argument accessors
  '`start end db' =: (0&{@])`(1&{@])`[

  NB. Create a graph from the genes:
  NB. - The neigbors of a vertex are the genes that disagree in exactly one nucleobase
  NB. - all edges have a weight of 1
  NB. - the graph is terminated with an empty neighbor list
  graph =. (] ,. 1"0 L:0) @ (a: ,~ <@I. @: ((1&=)@ (+/) @: ~:"1 /~))

  NB. Accessor for the distance between start and end gene
  NB. from the distance vector:
  NB. Pick the element at the index of "end" within "(start, db)" and
  NB. provide infinity on out-of-bound access.
  dist_e =. ] ({::~ :: _) 0 ; }:@[ i. {:@[

  NB. transform infinity to minus one
  inf2neg =. (_1:)^:(_&=)

  NB. graph =. ] ,. 1"0 L:0
  NB. - Create the distance matrix for the genes except end.
  NB. - Apply Floyd-Warshall to find the shortest paths.
  NB. - Find the distance between start and end gene.
  NB. - Handle infinity.
  [: : ([: ([: inf2neg ] dist_e 0 dijkstra~ [: graph }:) start, db, end) f.
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
    echo 'Call "./ch-2a.ijs START END BANK..." to process genes'
    echo 'or   "./ch-2a.ijs"                   to run the examples'
end.
)

exit ''

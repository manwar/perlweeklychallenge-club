#!/usr/local/bin/jconsole
require 'convert/pjson'
ARGV =: 399 (setargv :: ]) ARGV

NB. Implementation

NB. Find the longest path in a file system represented by y.
longest_path =: _(adverb define)
  NB. Split y at newlines into boxed items and
  NB. split items at tabs into boxed subitems.
  NB. Produces an empty box for each tab.
  to_boxed =. (<;._1 L:0) @ ((TAB , ]) L:0) @ (<;._2 L:0) @ ((LF ,~ ]) L:0)

  NB. Partition y into intervals with start positions
  NB. defined by 1's in x.
  part =. ;.1

  NB. Check if an entry is a top-level, i.e. if is a singleton
  top =. 1&=@#@>

  NB. Drop the first item from y and the first sub-item from all
  NB. remaining items.
  sub =. }.&.>@}.

  NB. Complete y depending on its size:
  NB. - box y if it is empty
  NB. - pass y if it is a singleton
  NB. - process y recursively if it contains multiple items
  complete =. <`]`$:@.((0 1)&I.@#)

  NB. Join the boxed content of x with the boxed content of each item from y
  NB. and box the result.
  join =. <@:,&.>"_ 0

  NB. Pick the first item from y.
  head =. {.

  NB. Remove outer boxes.
  raze =. ;

  NB. - Partition y into intervals where each interval starts with
  NB.   a top-level element.
  NB. - Build the sub structure for each interval
  NB. - Complete the sub structure
  NB. - Join the first item of y with the results from the previous step.
  NB. - Remove outer boxes.
  get_paths =. ([: raze top (head join complete f. @: sub) part ]) $::

  NB. Select paths having a dot in their trailing sub-item.
  get_files =. ] #~ '.' e. S:0 [: {: L:1 ]

  NB. Path length: Sum over the lengths of all path parts
  NB. plus the number of separators
  length =. ([: <: # S:1 + [: +/ # S:0)"0

  NB. find the maximum over all elements from y and zero.
  max0 =. 0&>. @ (>./)

  NB. All steps like pearls on a string:
  max0 @: length @ get_files @ get_paths @ to_boxed f. : [:
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
    1 <: # y
do.
    try.
        echo longest_path ('\t';TAB;'\n';LF) stringreplace 0 {:: y
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
        Expected =: 'out' from_ex Ex
        echo Name ,. Examples ,. Expected

        Result =: longest_path@>&.> Examples
        echo Result
        assert. Expected -: , L:0 Result
        echo 'tests succeeded'
    catch.
        echo 'tests failed', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-2.ijs STR" to process string'
    echo 'or   "./ch-2.ijs"     to run the examples'
end.
)

exit ''

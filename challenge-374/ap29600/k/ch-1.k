/ O(n^2) short solution
solve: ({~|/(|/^?)/'1|:\(x;"aeiou")}')#,/,\'|',\|:

/ O(m + n * log n) solution (n:input size; m:output size)
solve:{pos:-6+.="aeiou"?"aeiou ",_x
  end:,/1_'-1_pos
  (last;,first):0 5_pos{x@x'y}\:end
  x@{x+!y-x}.'1+,/(first+!'0|(&/last)-first),''end}

solve "aeiou"
solve "aaeeeiioouu"
solve "aeiouuaxaeiou"
solve "uaeiou"
solve "aeioaeioa"



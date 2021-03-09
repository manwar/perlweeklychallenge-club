<?php

foreach( range(1,20) as $_ ) {
  echo hash_count_string($_),"\n";
}

## Like many of these problems - we can work backwards...
## We know the string is going to be just the #
## or the end of the string is going to be nnnn# (where nnnn is the strlen of the string)
## we can repeat this backwards until we reach the start of the string.
## note for the start of the string there are two posibilities
## If you get to "2#" at the start then you have finished
## If you have a single gap just prefix by "#"

function hash_count_string($n) {
  $s = '';
  while($n>1) list($s,$n) = ["$n#$s",$n-1-strlen($n)];
  return ( $n? '#' : '' ).$s;
}


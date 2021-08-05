<?php

echo match_teams([1,2,3,4,5,6,7,8,9,10]);
echo match_teams([1,2,3,4,5,6,7,8,9]);
echo match_teams([1,1,1,1,1,1,3,1,10]);

function match_teams( $teams ) {
  $d = array_shift( $teams );
  $bt =[1e99];
  separate( 1 + floor( sizeof($teams)/2 ), [$d], [], $d, $bt, $teams );
  return sprintf( "T1: [%s]; T2: [%s]; Diff %d\n",
    implode( ' ', $bt[1] ), implode( ' ', $bt[2] ), $bt[0] );
}

function separate( $m, $t1, $t2, $d, &$b, $w ) {
  if(!sizeof($w)) {
    if( $b[0]>abs($d) ) list($b[0],$b[1],$b[2]) = [abs($d),$t1,$t2];
    return;
  }
  $n = array_shift( $w );
  if( sizeof($t1)<$m ) separate( $m, array_merge($t1,[$n]), $t2, $d+$n, $b, $w );
  if( sizeof($t2)<$m ) separate( $m, $t1, array_merge($t2,[$n]), $d-$n, $b, $w );
}

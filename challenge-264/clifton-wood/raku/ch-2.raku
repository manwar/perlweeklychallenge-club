sub target-array ($s, $i) {
  my $t = [];
  for $i.kv -> $k, $v {
    $v == $t.elems ?? $t.push( $s[$k] )
                   !! $t.splice( $v, 0, $s[$k] );
  }
  $t
}

target-array( [0, 1, 2, 3, 4], [0, 1, 2, 2, 1] ).gist.say; # [0 4 1 3 2]
target-array( [1, 2, 3, 4, 0], [0, 1, 2, 3, 0] ).gist.say; # [0 1 2 3 4]



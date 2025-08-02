sub count_equal_divisible {
  ($aref, $k) = @_;
  @array = @{$aref};
  $success = 0;

  for ($i = 0; $i < scalar(@array)-1; $i++) {
    for ($j = $i + 1; $j < scalar(@array); $j++) {
        $success++ if ( $array[$i] == $array[$j] && (($i * $j) % $k == 0) );
    }
  }
  print("The number of equal divisible pairs (i, j): ", $success, "\n");
}

@ints = qw(3 1 2 2 2 1 3);
$k = 2;
count_equal_divisible(\@ints, $k); # 4

@ints = qw(1 2 3);
$k = 1;
count_equal_divisible(\@ints, $k); # 0

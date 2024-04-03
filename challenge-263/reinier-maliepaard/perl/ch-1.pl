sub mc_target_index {
 ($k_, @ints_) = @_;

  @ints_sorted = ();
  @ints_sorted = sort( { $a <=> $b } @ints_ );
  join(", ", grep { $ints_sorted[$_] == $k_ } 0 .. $#ints_sorted);
}

@ints = (1, 5, 3, 2, 4, 2);
$k = 2;
print("\(", mc_target_index($k, @ints), ")\n"); # Output: (1,2)

@ints = (1, 2, 4, 3, 5);
$k = 6;
print("\(", mc_target_index($k, @ints), ")\n"); # Output: ()

@ints = (5, 3, 2, 4, 2, 1);
$k = 4;
print("\(", mc_target_index($k, @ints), ")\n"); # Output: (4)

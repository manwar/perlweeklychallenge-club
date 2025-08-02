sub mc_merge_items {

  ($aref1, $aref2) = @_;
  @combined_arrays = (@$aref1, @$aref2);

  %res = ();
  foreach ( @combined_arrays ) {
    $res{$_->[0]} += $_->[1];
  }

  $output = "";
  foreach $k (sort(keys(%res))) {
    $output .= " [$k,$res{$k}], ";
  }

  substr($output, -2, length($output), ' '); # remove comma at the end of $output in order to produce the requested output
  print("[$output]\n");
}


$items1 = [ [1,1], [2,1], [3,2] ];
$items2 = [ [2,2], [1,3] ];
mc_merge_items($items1, $items2); # Output: [ [1,4], [2,3], [3,2] ]


$items1 = [ [1,2], [2,3], [1,3], [3,2] ];
$items2 = [ [3,1], [1,3] ];
mc_merge_items($items1, $items2); # Output: [ [1,8], [2,3], [3,3] ]


$items1 = [ [1,1], [2,2], [3,3] ];
$items2 = [ [2,3], [2,4] ];
mc_merge_items($items1, $items2); # Output: [ [1,1], [2,9], [3,3] ]

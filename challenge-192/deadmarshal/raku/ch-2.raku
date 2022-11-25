sub equal_distribution(@arr){
  my $sum = @arr.sum;
  if ($sum %% @arr.elems)
  {
    my ($avg,$moves,$sum_part) = ($sum/@arr.elems,0,0);
    for 0..^@arr.elems -> $i
    {
      $sum_part += @arr[$i];
      $moves += abs($sum_part - ($avg * ($i + 1)));
    }
    return $moves;
  }
  -1;
}

say equal_distribution([1,0,5]);
say equal_distribution([0,2,0]);
say equal_distribution([0,3,0]);


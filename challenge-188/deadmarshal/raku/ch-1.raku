sub divisible_pairs(@arr, $k)
{
  my $count = 0;
  for 0..@arr.elems -> $i
  {
    for $i+1..^@arr.elems -> $j
    {
      $count++ if ((@arr[$i] + @arr[$j]) %% $k);
    }
  }
  return $count;
}

say divisible_pairs((4,5,1,6), 2);
say divisible_pairs((1,2,3,4), 2);
say divisible_pairs((1,3,4,5), 3);
say divisible_pairs((5,1,2,3), 4);
say divisible_pairs((7,2,4,5), 4);

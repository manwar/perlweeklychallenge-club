sub good-pairs(@arr)
{
  my $count = 0;
  for 0..@arr.end -> $i
  {
    for $i+1..@arr.end -> $j
    {
      $count++ if (@arr[$i] == @arr[$j]);
    }
  }
  $count;
}

say good-pairs([1,2,3,1,1,3]);
say good-pairs([1,2,3]);
say good-pairs([1,1,1,1]);


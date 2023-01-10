sub good-triplets(@A,$x,$y,$z)
{
  my $count = 0;
  for 0..@A.end -> $i
  {
    for 0..@A.end -> $j
    {
      for 0..@A.end -> $k
      {
	if ((abs(@A[$i] - @A[$j]) <= $x) &&
	    (abs(@A[$j] - @A[$k]) <= $y) &&
	    (abs(@A[$i] - @A[$k]) <= $z) &&
	    (0 <= $i < $j < $k <= @A.elems)) {$count++}
      }
    }  
  }
  $count;
}

say good-triplets([3,0,1,1,9,7],7,2,3);
say good-triplets([1,1,2,2,3],0,0,1);


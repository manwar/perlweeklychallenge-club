sub array-degree(@arr)
{
  my (%left,%count);
  my ($max,$min,$index) = (0) x 3;
  for 0..^@arr.elems -> $i
  {
    my $x = @arr[$i];
    if %count{$x}:!exists
    {
      %left{$x} = $i;
      %count{$x} = 1;
    }
    else
    {
      %count{$x}++;
    }
    if (%count{$x} > $max)
    {
      $max = %count{$x};
      $min = $i - %left{$x} + 1;
      $index = %left{$x};
    }
    elsif ((%count{$x} == $max) &&
	   ($i - %left{$x} + 1 < $min))
    {
      $min = $i - %left{$x} + 1;
      $index = %left{$x};
    }
  }
  for $index..^$index+$min -> $i
  {
    print @arr[$i], ' ';
  }
  print "\n";
}

array-degree([1,3,3,2]);
array-degree([1,2,1,3]);
array-degree([1,3,2,1,2]);
array-degree([1,1,2,3,2]);
array-degree([2,1,2,1,1]);


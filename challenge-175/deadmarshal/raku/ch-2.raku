sub phi(Int $n is copy)
{
  my ($i,$result) = (2,$n);
  while ($i <= $n)
  {
    if ($n %% $i)
    {
      while ($n %% $i) {$n div= $i};
      $result -= ($result div $i);
    }
    if $i == 2 {$i = 1}
    $i += 2;
  }
  if $n > 1 {$result -= ($result div $n)}
  return $result;
}

sub phi-iter(Int $n)
{
  return phi($n) if $n == 2;
  return phi($n) + phi-iter(phi($n));
}

sub MAIN()
{
  my ($i,$count) = (2,0);
  while ($count != 20)
  {
    if ($i == phi-iter($i))
    {
      print "$i ";
      $count++;
    }
    $i++;
  }
}

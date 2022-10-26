sub total_zero($x is copy, $y is copy)
{
  my $c = 0;
  while ($x > 0 && $y > 0)
  {
    ($x >= $y) ?? ($x -= $y) !! ($y -= $x);
    $c++;
  }
  $c;
}

say total_zero(5,4);
say total_zero(4,6);
say total_zero(2,5);
say total_zero(3,1);
say total_zero(7,4);


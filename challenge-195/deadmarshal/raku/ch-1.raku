sub special-integers($n)
{
  my $count = 0;
  $count++ if $_.comb.unique == $_.comb for 1..$n;
  $count;
}

say special-integers(15);
say special-integers(35);


sub MAIN()
{
  my ($i, $i2) = (3,4);
  my @n = (1,4,2,3,5);
  my @n2 = (9,0,6,2,3,8,5);
  printf "(%s)\n", (grep {$_ > $i}, @n).join(',');
  printf "(%s)\n", (grep {$_ > $i2}, @n2).join(',');
}

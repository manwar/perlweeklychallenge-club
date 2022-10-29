use Prime::Factor;

sub square-free-integers()
{
  my $i = 1;
  while ($i <= 500)
  {
    my @pf = prime-factors($i);
    print "$i " if @pf.elems - unique(@pf).elems == 0;
    $i++;
  }
}

sub MAIN()
{
  square-free-integers;
}

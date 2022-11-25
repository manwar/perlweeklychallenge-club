sub binary-flip($n)
{
  my $binary = $n.base(2);
  $binary ~~ tr/10/01/;
  $binary.parse-base(2);
}

say binary-flip(5);
say binary-flip(4);
say binary-flip(6);


#! /usr/bin/env raku

multi MAIN (Int $int)
{
  say to-excel($int);
}

multi MAIN (Str $str where $str ~~ /^<[A..Z]>+$/)
{
  say from-excel($str);
}

constant A := ord('A');

sub to-excel (Int $number is copy)
{
  $number--;

  my $div = $number mod 26;
  my $exp = $number div 26;

  # return to-excel($exp) ~ ('A' .. 'Z')[$div] if $exp;
  return to-excel($exp) ~ chr(A + $div) if $exp;

  # return ('A' .. 'Z')[$div];
  return chr(A + $div);
}

sub from-excel ($str)
{
  my @elems = $str.comb;

  my $sum = 0;

  for @elems
  {
    $sum = $sum * 26 + ord($_) - A + 1;
  }
  return $sum;
}

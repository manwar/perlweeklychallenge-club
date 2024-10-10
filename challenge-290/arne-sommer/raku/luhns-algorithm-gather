#! /usr/bin/env raku

unit sub MAIN ($str, :v($verbose));

my @digits = $str.flip.comb.grep: * ~~ /<[0..9]>/;

say ": Digits (reverse): @digits[]" if $verbose;

my $seq := gather
{
  my $index = 0;
  for @digits -> $sum is copy;
  {
    unless $index++ %% 2 { $sum *= 2; $sum = $sum.comb.sum if $sum > 9; }
    take $sum;
  }
}

my $total = $seq.sum;

say ! so $total mod 10;

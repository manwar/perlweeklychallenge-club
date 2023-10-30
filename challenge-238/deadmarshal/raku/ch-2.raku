#!/usr/bin/env raku

sub helper($n is copy)
{
  my $sum = 0;
  $n = do {$sum++; [*] $n.comb} until $n < 10;
  $sum
}

sub persistence_sort(@arr)
{
  @arr.sort({helper($_), $_});
}

say persistence_sort([15,99,1,34]);
say persistence_sort([50,25,33,22]);


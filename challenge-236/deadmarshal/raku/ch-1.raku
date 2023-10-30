#!/usr/bin/env raku

sub exact-change(@arr)
{
  my %hash;
  for @arr {
    if $_ == 10 {
      return False unless %hash{5}--;
    }
    elsif $_ == 20 {
      %hash{5} && %hash{10} ?? do {--%hash{$_} for 5,10} !!
      %hash{5} > 2 ?? (%hash{5} -= 3) !! return False;
    }
    %hash{$_}++;
  }
  True
}

say exact-change([5,5,5,10,20]);
say exact-change([5,5,10,10,20]);
say exact-change([5,5,5,20]);


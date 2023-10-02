#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);
use List::MoreUtils qw(slide all);
use Data::Show;

sub is_perfect_square{
  do{
    my $sqrt = sqrt($_[0]);
    return ($sqrt * $sqrt) == $_[0];
  }if($_[0] >= 0);
  0
}

sub squareful{
  my %hash;
  map{$hash{$_}++} @{$_[0]};
  return @{$_[0]} if keys %hash == 1;
  my @ret;
  my $iter = permutations($_[0]);
  while(my $p = $iter->next)
  {
    if(all{$_ == 1} slide{is_perfect_square($a+$b)} @$p)
    {
      push @ret,$p;
    }
  }
  @ret;
}

print show squareful([1,17,8]);
print show squareful([2,2,2]);


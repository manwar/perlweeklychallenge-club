#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub final_price {
  my ($p) = @_;
  my @stack;
  my @res = @$p;
  foreach my $i(0..$#$p){
    while(@stack && ($p->[$stack[-1]] >= $p->[$i])) {
      my $j = pop @stack;
      $res[$j] = $p->[$j] - $p->[$i]
    }
    push @stack,$i
  }
  @res
}

print show final_price([8,4,6,2,3]);
print show final_price([1,2,3,4,5]);
print show final_price([7,1,1,5]);


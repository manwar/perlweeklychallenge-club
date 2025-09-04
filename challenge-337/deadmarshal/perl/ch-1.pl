#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;
use List::Util qw(sum0);
use List::MoreUtils qw(frequency);

sub smaller_than_current{
  my %h = frequency(@{$_[0]});
  my @arr;
  foreach my $i(0..$#{$_[0]}) {
    my %h2 = %h{grep{$_ <= $_[0]->[$i]} keys %h};
    @arr[$i] = sum0(values %h2) - 1
  }
  @arr
}

print show smaller_than_current([6,5,4,8]);
print show smaller_than_current([7,7,7,7]);
print show smaller_than_current([5,4,3,2,1]);
print show smaller_than_current([-1,0,3,-2,1]);
print show smaller_than_current([0,1,1,2,0]);


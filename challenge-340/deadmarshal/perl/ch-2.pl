#!/usr/bin/env perl
use strict;
use warnings;

sub is_ascending{
  foreach my $i(1..$#{$_[0]}) {
    return 0 if $_[0]->[$i] <= $_[0]->[$i-1]
  }
  1
}

sub ascending_numbers{
  my @arr = grep {/\d+/} split /\s+/,$_[0];
  is_ascending(\@arr)
}

printf "%d\n",ascending_numbers('The cat has 3 kittens 7 toys 10 beds');
printf "%d\n",ascending_numbers('Alice bought 5 apples 2 oranges 9 bananas');
printf "%d\n",ascending_numbers('I ran 1 mile 2 days 3 weeks 4 months');
printf "%d\n",ascending_numbers('Bob has 10 cars 10 bikes');
printf "%d\n",ascending_numbers('Zero is 0 one is 1 two is 2');

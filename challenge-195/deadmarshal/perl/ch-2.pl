#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all min uniqint reduce);

sub most_frequent_even{
  my ($arr) = @_;
  return -1 if all {$_ % 2 != 0} @$arr;
  my %hash;
  $hash{$_}++ foreach(grep {!($_ & 1)} @$arr);
  return min keys %hash if((values %hash) == uniqint(values %hash));
  return reduce {$hash{$a} == $hash{$b} ? $a : $b}
    sort {$a <=> $b} keys %hash;
}

print most_frequent_even([1,1,2,6,2]), "\n";
print most_frequent_even([1,3,5,7]), "\n";
print most_frequent_even([6,4,4,6,1]), "\n";


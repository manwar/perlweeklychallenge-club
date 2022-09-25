#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings 'experimental::signatures';

my @list1 = ([1,2], [3,4], [5,6], [1,2]);
my @list2 = ([9,1], [3,7], [2,5], [2,5]);

say "(", join(", ", map { "[$_->[0],$_->[1]]" } unique_array(@list1)), ")";
say "(", join(", ", map { "[$_->[0],$_->[1]]" } unique_array(@list2)), ")";

sub unique_array (@list)
{
  my @unique;
  my %seen;
  
  for my $ref (@list)
  {
    next if $seen{"$ref->[0] $ref->[1]"};
    push @unique, $ref;
    $seen{"$ref->[0] $ref->[1]"}++;
  }

  return @unique;
}

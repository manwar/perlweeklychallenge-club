#!/usr/bin/env perl

use v5.38;

use List::Util qw( sum );

my @ints = @ARGV; # just accept the list of integers on the command line

# find the unique elements
my %unique;
foreach my $int ( @ints ) {
  $unique{$int}++;
}

# make a list of ONLY the unique ints
my @unique_ints = grep { $unique{$_} == 1 } @ints;

# sum the unique elements
my $sum = sum(@unique_ints) // 0;

# produce the output
say "Input: \@int = (" . join(', ', @ints) . ")";
say "Output: $sum";
say "";

print "In the given array ";
if ( scalar(@unique_ints) == scalar(@ints) ) {
  say "every element is unique.";
}
elsif ( scalar(@unique_ints) == 0 ) {
  say "no unique element found.";
}
else {
  say "we have " . scalar(@unique_ints) . " unique elements ("
    . join(', ', @unique_ints) . ").";
}
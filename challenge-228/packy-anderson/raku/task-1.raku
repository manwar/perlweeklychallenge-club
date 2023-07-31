#!/usr/bin/env raku

use v6;

my @ints = @*ARGS; # just accept the list of integers on the command line

# find the unique elements
my %unique;
for @ints -> $int {
  %unique{$int}++;
}

# make a list of ONLY the unique ints
my @unique_ints = grep { %unique{$_} == 1 }, @ints;

# sum the unique elements
my $sum = [+] @unique_ints;

# produce the output
say "Input: \@int = (" ~ @ints.join(', ') ~ ")";
say "Output: $sum";
say "";

print "In the given array ";
if ( @unique_ints.elems == @ints.elems ) {
  say "every element is unique.";
}
elsif ( @unique_ints.elems == 0 ) {
  say "no unique element found.";
}
else {
  say "we have " ~ @unique_ints.elems ~ " unique elements ("
    ~ @unique_ints.join(', ') ~ ").";
}

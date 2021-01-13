#!/usr/bin/env perl

use v5.30;
use warnings;

my ($A, $B) = @ARGV[0, 1];

my $shorter = length $A;
$shorter = length $B if length $B < length $A;

my @solutions;

for (my $len = 1; $len <= $shorter; $len++) {
    next if length($A) % $len != 0 or length($B) % $len != 0;
    my $candidate = substr $A, 0, $len;
    if ($A eq $candidate x (length($A) / $len) and $B eq $candidate x (length($B) / $len)) {
        push @solutions, $candidate;
    }
}

print "(", join(", ", map qq{"$_"}, @solutions), ")\n";

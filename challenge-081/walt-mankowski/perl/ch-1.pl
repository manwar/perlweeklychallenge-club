#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(min);

# You are given 2 strings, $A and $B.
#
# Write a script to find out common base strings in $A and $B.
#
#     A substring of a string $S is called base string if repeated
#     concatenation of the substring results in the string.

my ($A, $B) = @ARGV;
my $max_base_len = min(length($A), length($B));

for my $i (1 .. $max_base_len) {
    if (is_base(substr($A, 0, $i), $A) && is_base(substr($B, 0, $i), $B)) {
        say substr($A, 0, $i);
    }
}

sub is_base($prefix, $s) {
    my $cnt = length($s) / length($prefix);
    return $prefix x $cnt eq $s;
}


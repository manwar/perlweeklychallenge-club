#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Interleave String
# Submitted by: Mohammad S Anwar
#
# You are given 3 strings; $A, $B and $C.
#
# Write a script to check if $C is created by interleave $A and $B.
#
# Print 1 if check is success otherwise 0.

my ($A, $B, $C) = @ARGV;

say is_interleave($A, $B, $C);

sub is_interleave($A, $B, $C) {
    if ($A eq '' && $B eq '' && $C eq '') {
        return 1;
    }

    if (substr($A, 0, 1) eq substr($C, 0, 1)) {
        return is_interleave(substr($A, 1), $B, substr($C, 1));
    }
    if (substr($B, 0, 1) eq substr($C, 0, 1)) {
        return is_interleave($A, substr($B, 1), substr($C, 1));
    }
    return 0;
}

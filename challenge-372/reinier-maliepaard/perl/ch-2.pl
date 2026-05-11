#!/usr/bin/perl
use strict;
use warnings;

# Three versions of the solution
# Each highlights a different idea

sub largest_substring_1 {

    my ($s) = @_;

    my (%first, %last);

    for my $i (0 .. length($s) - 1) {

        # Extract one character at position $i. No array split needed.
        my $ch = substr($s, $i, 1);

        # First and last occurrence of each character
        $first{$ch} //= $i;   # only set on first encounter
        $last{$ch}  = $i;     # always update -> final position
    }

    my $max = -1;

    for my $ch (keys %first) {

        # Characters strictly BETWEEN first and last occurrence:
        # The -1 excludes the two endpoint characters themselves.
        #
        # If a character only appears once, last == first so gap = -1,
        # which will never beat $max (already -1 or higher).
        my $gap = $last{$ch} - $first{$ch} - 1;

        # Update $max only when a strictly larger gap is found.
        $max = $gap if $gap > $max;
    }

    # -1  -> no character repeated
    #  0  -> a character repeated but nothing between (e.g. "aa")
    # >0  -> gap of that many characters exists between two identical chars
    return $max;
}

# The only real debate left is whether to merge the two loops - but keeping
# them separate makes the intent of each phase (collect, then evaluate)
# immediately obvious to a reader.

sub largest_substring_2 {
    my ($s) = @_;

    my (%first, $max);
    $max = -1;

    for my $i (0 .. length($s) - 1) {
        my $ch = substr($s, $i, 1);

        if (!exists $first{$ch}) {
            # First time seeing $ch: pin its index.
            # So, the left boundary never changes - only the right one moves.
            # We can't compute a gap yet - need a second occurrence first.
            $first{$ch} = $i;
        } else {
            # $ch was seen before, so we can measure the gap.
            # We DO recompute the gap on every subsequent occurrence, because
            # later occurrences push the right endpoint further out.
            # Example: "a??a???a"
            #   i=3: gap = 3 - 0 - 1 = 2
            #   i=7: gap = 7 - 0 - 1 = 6  <-- this is the one we want
            my $gap = $i - $first{$ch} - 1;
            $max = $gap if $gap > $max;
        }
    }

    return $max;
}

# Advanced micro-optimization with unpack
# If performance matters, we can avoid repeated substr calls.
# Replace it with split once, or better - use unpack which
is the fastest way to explode a string in Perl.

sub largest_substring_3 {
    my ($s) = @_;

    my (%first, $max);
    $max = -1;

    # Faster than repeated substr calls (optional micro-optimization)
    my @chars = unpack("A1" x length($s), $s);
    # or: my @chars = split //, $s;

    for my $i (0 .. $#chars) {
        my $ch = $chars[$i];
        if (!exists $first{$ch}) {
            $first{$ch} = $i;
        } else {
            my $gap = $i - $first{$ch} - 1;
            $max = $gap if $gap > $max;
        }
    }

    return $max;
}

# Tests

my $str;

# Example 1
$str = "aaaaa";
print largest_substring_3($str), "\n"; # Output: 3

# Example 2
$str = "abcdeba";
print largest_substring_3($str), "\n"; # Output: 5

# Example 3
$str = "abbc";
print largest_substring_3($str), "\n"; # Output: 0

# Example 4
$str = "abcaacbc";
print largest_substring_3($str), "\n"; # Output: 4

# Example 5
$str = "laptop";
print largest_substring_3($str), "\n"; # Output: 2

# Example 6
$str = "abcdef";
print largest_substring_3($str), "\n"; # Output: -1

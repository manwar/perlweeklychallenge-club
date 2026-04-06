#!/usr/bin/perl
use strict;
use warnings;

sub duplicate_and_missing {

    my (@nums) = @_;

    # --- validation: count occurrences ---
    my %count;
    $count{$_}++ for @nums;

    # exactly one value must occur twice
    my @dups = grep { $count{$_} == 2 } keys %count;

    # no value may occur more than twice
    return -1 if @dups != 1;
    return -1 if grep { $count{$_} > 2 } keys %count;

    my $dup = $dups[0];

    # --- build ideal sequence ---
    my @normal_sequence;
    for (my $i = 0; $i < @nums; $i++) {
        push @normal_sequence, $nums[0] + $i;
    }

    # --- compute sums ---
    my $sum_expected = 0;
    $sum_expected += $_ for @normal_sequence;

    my $sum_actual = 0;
    $sum_actual += $_ for @nums;

    # --- compute missing ---
    my $missing = $dup + ($sum_expected - $sum_actual);

    return ($dup, $missing);
}


# Tests

# Example 1:
@nums = (1,2,2,4);          # Output (duplicate,missing): (2,3)
#print join ",", duplicate_and_missing(@nums), "\n";
print "Example 1 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 2:
@nums = (-1,-3, -3);         # Output (duplicate,missing): (-3,-2)
print "Example 2 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# selection examples from RECAP
# https://theweeklychallenge.org/blog/recap-challenge-208/

# Example 3:
@nums = (1,1,2,3);           # Output (duplicate,missing): (1, 4)
print "Example 3 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 4:
@nums = (1,2,2,3);           # Output (duplicate,missing): (2, 4)
print "Example 4 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 5:
@nums = (1,2,3,3);           # Output (duplicate,missing): (3, 4)
print "Example 5 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 6:
@nums = (1,2,2,4);           # Output (duplicate,missing): (2, 3)
print "Example 6 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 7:
@nums = (1,3,3,4);           # Output (duplicate,missing): (3, 2)
print "Example 7 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 8:
@nums = (1,2,4,4);           # Output (duplicate,missing): (4, 3)
print "Example 8 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 9:
@nums = (2,2,3);             # Output (duplicate,missing): (2, 4)
print "Example 9 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 10:
@nums = (2,2,3,4);           # Output (duplicate,missing): (2, 5)
print "Example 10 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 11:
@nums = (1,2,2,3,5);         # Output (duplicate,missing): (2, 4)
print "Example 11 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 12:
@nums = (1,2,2,3,4,6);       # Output (duplicate,missing): (2, 5)
print "Example 12 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 13:
@nums = (1,2,3,4,5,7,7);     # Output (duplicate,missing): (7, 6)
print "Example 13 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 14:
@nums = (4,5,6,7,7,8);       # Output (duplicate,missing): (7, 9)
print "Example 14 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 15:
@nums = (4,5,6,7,7,9);       # Output (duplicate,missing): (7, 8)
print "Example 15 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 16:
@nums = (4,5,6,6,7,9);       # Output (duplicate,missing): (6, 8)
print "Example 16 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 17:
@nums = (4,6,6,7,8,9);       # Output (duplicate,missing): (6, 5)
print "Example 17 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Invalid cases

# Example 18:
@nums = (2,3,3,3);           # Output: -1
print "Example 18 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 19:
@nums = (1,3,3,3,5);         # Output: -1
print "Example 19 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 20:
@nums = (1,2,4,5);           # Output: -1
print "Example 20 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 21:
@nums = (3,6,5,6,7,8);       # Output: -1
print "Example 21 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 22:
@nums = (3,4,5,6,7,3);       # Output: -1
print "Example 22 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 23:
@nums = (1,2,3,4);           # Output: -1
print "Example 23 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 24:
@nums = (1,2);               # Output: -1
print "Example 24 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 25:
@nums = (1,3);               # Output: -1
print "Example 25 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 26:
@nums = (1,);                # Output: -1
print "Example 26 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Borderline but valid

# Example 27:
@nums = (1,1);               # Output (duplicate,missing): (1, 2)
print "Example 27 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 28:
@nums = (1,1,3);             # Output (duplicate,missing): (1, 2)
print "Example 28 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

# Example 29:
@nums = (1,3,3);             # Output (duplicate,missing): (3, 2)
print "Example 29 Input: (", join(",", @nums), ") Output (duplicate,missing): (", join(",", duplicate_and_missing(@nums)), ")\n";

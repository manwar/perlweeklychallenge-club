#!/usr/bin/perl
use strict;
use warnings;

sub count_vowel {

    my $s = lc shift;
    my @res;

    return @res if $s =~ /[^a-z]/i ||
                   $s !~ /^(?=.*a)(?=.*e)(?=.*i)(?=.*o)(?=.*u)/i;

    # Each vowel is treated as a "feature".
    # We encode each feature as a bit:

    my %b = (
        a => 1,
        e => 2,
        i => 4,
        o => 8,
        u => 16
    );

    my $n = length($s);

    # We try every possible starting position of a "cell"
    # (a cell = a continuous block of vowels)
    for my $i (0 .. $n - 1) {

        my $mask = 0;  # Tracks which vowels we have seen in this cell

        # Extend the cell to the right step by step
        for my $j ($i .. $n - 1) {

            my $c = substr($s, $j, 1);

            # If we hit a non-vowel, the cell is broken
            last if !exists $b{$c};

            # Mark this vowel as "seen"
            # (bitwise OR means we keep previous vowels too)
            $mask |= $b{$c};

            # If all vowels are present, this is a valid cell
            if ($mask == 31) {

                push (@res, "'" . substr($s, $i, $j - $i + 1) . "'");

                # IMPORTANT:
                # We do NOT stop here, because longer expansions
                # of the same cell are also valid.
            }
        }
    }
    return @res;
}

# TESTS

my $str;

# Example 1
$str = "aeiou";
print "(", join(", ", count_vowel($str)), ")\n"; # Output: ("aeiou")

# Example 2
$str = "aaeeeiioouu";
print "(", join(", ", count_vowel($str)), ")\n"; # Output: ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu")

# Example 3
$str = "aeiouuaxaeiou";
print "(", join(", ", count_vowel($str)), ")\n"; # Output: ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua")

# Example 4
$str = "uaeiou";
print "(", join(", ", count_vowel($str)), ")\n"; # Output: ("aeiou", "uaeio", "uaeiou")

# Example 5
$str = "aeioaeioa";
print "(", join(", ", count_vowel($str)), ")\n"; # Output: ()

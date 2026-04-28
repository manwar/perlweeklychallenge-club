#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Test::More;

=head1 NAME

ch-1.pl - Challenge 371 Task 1: Missing Letter

=head1 SYNOPSIS

Identify the missing letter in a sequence of five lowercase letters.
The sequence follows a constant or alternating step pattern.

=head1 DESCRIPTION

Example 1: ('a', 'c', 'e', '?', 'i') -> 'g' (step +2)
Example 2: ('a', 'd', 'e', 'g', '?') -> 'h' (alternating +3, +1)
Example 3: ('?', 'b', 'd', 'f', 'h') -> 'z' (Actually, 'a' because step is +2)
Wait, let's re-verify example 3 logic.
'b' to 'd' is +2, 'd' to 'f' is +2, 'f' to 'h' is +2.
If step is +2, the first letter should be 'b' - 2 = 'a'.

=cut

sub find_missing_letter {
    my (@letters) = @_;

    # Convert letters to 1-based indices (a=1, b=2, ...)
    my @indices = map { $_ eq '?' ? undef : ord($_) - ord('a') + 1 } @letters;

    # Find the pattern
    # Possible patterns: (d1, d1, d1, d1) or (d1, d2, d1, d2)
    # We have 4 knowns and 1 unknown index.

    # Try all possible letters for '?'
    for my $cand_char ('a' .. 'z') {
        my $cand_idx = ord($cand_char) - ord('a') + 1;

        my @current_indices = @indices;
        for (my $i=0; $i<5; $i++) {
            $current_indices[$i] = $cand_idx if !defined $current_indices[$i];
        }

        my @diffs;
        for (my $i=0; $i<4; $i++) {
            push @diffs, $current_indices[$i+1] - $current_indices[$i];
        }

        # Check if constant step
        if ($diffs[0] == $diffs[1] && $diffs[1] == $diffs[2] && $diffs[2] == $diffs[3]) {
            return $cand_char;
        }

        # Check if alternating pattern
        if ($diffs[0] == $diffs[2] && $diffs[1] == $diffs[3]) {
            return $cand_char;
        }
    }

    return '?';
}

# Unit Tests
is(find_missing_letter('a', 'c', 'e', '?', 'i'), 'g', "Example 1 (+2)");
is(find_missing_letter('a', 'd', 'e', 'g', '?'), 'h', "Example 2 (+3, +1)");
is(find_missing_letter('?', 'b', 'd', 'f', 'h'), 'a', "Example 3 (+2, start)");
is(find_missing_letter('a', '?', 'e', 'g', 'i'), 'c', "Example 4 (+2, interior)");
is(find_missing_letter('a', 'b', '?', 'e', 'f'), 'd', "Example 5 (+1, +2 alternating? No, Example 2 style)");
# Let's check a custom alternating one: a, c, f, h, ?
# +2, +3, +2, +3 -> 1, 3, 6, 8, 11 (k)
is(find_missing_letter('a', 'c', 'f', 'h', '?'), 'k', "Custom alternating (+2, +3)");

done_testing();

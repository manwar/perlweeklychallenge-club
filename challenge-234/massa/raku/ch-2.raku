#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Unequal Triplets

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

Input: @ints = (4, 4, 2, 4, 3)
Ouput: 3

(0, 2, 4) because 4 != 2 != 3
(1, 2, 4) because 4 != 2 != 3
(2, 3, 4) because 2 != 4 != 3

=head3 Example 1:

Input: @ints = (1, 1, 1, 1, 1)
Ouput: 0

=head3 Example 2:

Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
Output: 28

triplets of 1, 4, 7  = 3x2×2 = 12 combinations
triplets of 1, 4, 10 = 3×2×1 = 6  combinations
triplets of 4, 7, 10 = 2×2×1 = 4  combinations
triplets of 1, 7, 10 = 3x2x1 = 6 combinations

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub unequal-triplets(@_) {
    @_.combinations(3).grep(!*.repeated).elems
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (4, 4, 2, 4, 3), output => 3 },
        %{ input => (1, 1, 1, 1, 1), output => 0 },
        %{ input => (4, 7, 1, 10, 7, 4, 1, 1), output => 28 },
    ];

    for @tests {
        unequal-triplets( .<input> ).&is-deeply: .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test!)



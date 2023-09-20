#!/usr/bin/env perl
=begin comment
------------------------------------------
AUTHOR: Robert DiCicco
DATE  ; 2023-09-18
Challenge Task 02 Duplicate Zaroes ( Perl )
------------------------------------------
=cut

use v5.38;
my @myints = ([1, 0, 2, 3, 0, 4, 5, 0],[1, 2, 3],[0, 3, 0, 4, 5]);

for my $mints (@myints) {
    say "Input: \@ints = [@$mints]";
    my @seen = ();
    my $len = scalar @$mints - 1;
    for my $x (@$mints) {
        if ($x != 0) {
            push(@seen, $x);
        } else {
            push(@seen, 0);
            push(@seen, 0);
        }
    }
    say "Output: [@seen[0..$len]]\n";
}

=begin comment
------------------------------------------
SAMPLE OUTPUT
perl .\DuplicateZeros.pl

Input: @ints = [1 0 2 3 0 4 5 0]
Output: [1 0 0 2 3 0 0 4]

Input: @ints = [1 2 3]
Output: [1 2 3]

Input: @ints = [0 3 0 4 5]
Output: [0 0 3 0 0]
------------------------------------------
=cut



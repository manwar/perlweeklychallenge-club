#!/usr/bin/perl
use strict;
use warnings;

I think for this challenge, two modules are particularly useful:
Algorithm::Combinatorics and Data::PowerSet. Both have advantages
and disadvantages.

Algorithm::Combinatorics (combinations) is better suited here because it
allows you to generate subsets by size (e.g. 2..n), giving more control
and avoiding unnecessary cases. It is also more efficient when you only
care about specific subset sizes.

Data::PowerSet generates all subsets at once, which is simpler conceptually
but less efficient for this challenge, since it includes subsets of all sizes
and requires filtering out unwanted cases, increasing the search space.

Overall, Algorithm::Combinatorics is more efficient in practice for this
challenge because it avoids generating irrelevant subsets (sizes < 2).
Both approaches are exponential in complexity, but combinatorics reduces
unnecessary enumeration.

In this solution, I provide implementations using both modules, which
are suitable for small datasets. The APIs are well-documented on CPAN,
and the implementations are similar in size and structure, producing
identical results.

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);
use Data::PowerSet;

# Combinatorics version (preferred)
sub subset_equilibrium_combinatorics {

    my (@nums) = @_;

    my @res;
    my @indices = 0 .. $#nums;

    for my $k (2 .. scalar @nums) {
        my $iter = combinations(\@indices, $k);

        while (my $subset = $iter->next) {

            my $sum_values    = sum(@nums[@$subset]);
            my $sum_positions = sum(map { $_ + 1 } @$subset); # 1-based positions

            if ($sum_values == $sum_positions) {
                push @res, [ @nums[@$subset] ];
            }
        }
    }

    return @res;
}

# Powerset version (simpler but less efficient)
sub subset_equilibrium_powerset {

    my (@nums) = @_;

    my @res;
    my @indices = 0 .. $#nums;

    my $ps = Data::PowerSet->new(\@indices);

    while (my $subset = $ps->next) {

        next if @$subset < 2;

        my $sum_values    = sum(@nums[@$subset]);
        my $sum_positions = sum(map { $_ + 1 } @$subset); # 1-based positions

        if ($sum_values == $sum_positions) {
            push @res, [ @nums[@$subset] ];
        }
    }

    return @res;
}

# Helper to print results
sub print_result {
    my (@res) = @_;

    my $out = join(", ", map { "(" . join(", ", @$_) . ")" } @res);

    print "Output: $out\n";
}

# Tests

# Example 1
print_result subset_equilibrium_combinatorics(2, 1, 4, 3); # Output: (2, 1), (1, 4), (4, 3), (2, 3), (2, 1, 4, 3)
# print_result subset_equilibrium_powerset(2, 1, 4, 3);

# Example 2
print_result subset_equilibrium_combinatorics(3, 0, 3, 0); # Output: (3, 0), (3, 0, 3)
# print_result subset_equilibrium_powerset(3, 0, 3, 0);

# Example 3
print_result subset_equilibrium_combinatorics(5, 1, 1, 1); # Output: (5, 1, 1)
# print_result subset_equilibrium_powerset(5, 1, 1, 1);

# Example 4
print_result subset_equilibrium_combinatorics(3, -1, 4, 2); # Output: (3, 2), (3, -1, 4)
# print_result subset_equilibrium_powerset(3, -1, 4, 2);

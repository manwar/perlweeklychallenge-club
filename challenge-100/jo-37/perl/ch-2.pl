#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(min reduce);
use Data::Dump 'pp';
use experimental qw(signatures postderef);
use utf8;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [val ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print triangle values and minimum path sums

val ...
    values forming a triangle, taking sequentially from the top corner
    to the base edge.

    Example:
    The triangle

      1
     2 3
    4 5 6

    would be given as 1 2 3 4 5 6

EOS


### Input and Output

my $Δ = read_triangle(@ARGV);
print 'triangle:  ', pp($Δ), "\nmin sum:   " if $verbose;
say triangle_sum($Δ);
say 'path sums: ', pp $Δ if $verbose;


### Implementation

# Gather values forming a triangle.
sub read_triangle (@val) {
    my @Δ;
    push @Δ, [splice @val, 0, @Δ + 1] while @val;
    die "not a triangle" unless $Δ[$#Δ]->@* == @Δ;

    \@Δ;
}

# Find the minimum path sum bottom-up.  
# The path sum at each field is the sum of the field itself and the
# minimum of the path sums at its predecessor fields.  The input
# triangle will be overwritten with its path sums by this procedure.
# Afterwards the top corner contains the requested minimum sum, which is
# returned.
sub triangle_sum ($Δ) {
    (reduce {
            $b->[$_] += min $a->@[$_, $_ + 1] for 0 .. $b->$#*;
            $b;
        } reverse $Δ->@*
    )->[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is triangle_sum([[1], [2, 4], [6, 4, 9], [5, 1, 7, 2]]), 8,
            'example 1';

        is triangle_sum([[3], [3, 1], [5, 2, 3], [4, 3, 1, 3]]), 7,
            'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is read_triangle(qw(1 2 4 6 4 9 5 1 7 2)),
            [[1], [2, 4], [6, 4, 9], [5, 1, 7, 2]], 'read example 1';
        is read_triangle(qw(3 3 1 5 2 3 4 3 1 3)),
            [[3], [3, 1], [5, 2, 3], [4, 3, 1, 3]], 'read example 2';

        is triangle_sum(
                [[1], [1, 1], [1, 2, 1], [1, 2, 2, 1], [2, 2, 1, 2, 1]]
        ), 5, 'edge case';

        my $Δ = [[1], [2, 1], [3, 1, 3], [1, 2, 2, 1]];
        is triangle_sum($Δ), 5, 'bottom max';
        # check overwritten triangle:
        is $Δ, [[5], [5, 4], [4, 3, 4], [1, 2, 2, 1]], 'path sums';

        is triangle_sum([[37]]), 37, 'nothing to be done';

        like dies {read_triangle(qw(1 2 3 4 5))}, qr/not a triangle/,
            'invalid data';
	}

    done_testing;
    exit;
}

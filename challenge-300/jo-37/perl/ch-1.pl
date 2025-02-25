#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    length of cute lists to be counted.

EOS


### Input and Output

say count_cute(shift);


### Implementation

# This is (almost) a copy from https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-191/jo-37/perl/ch-2a.pl

# For details see:
# https://github.sommrey.de/the-bears-den/2024/12/20/ch-300.html#task-1

sub count_cute ($n) {
    # Build the adjacency matrix A for a "cute list" of size N.
    my @a;
    for my $i (0 .. $n - 1) {
        for my $k (0 .. $n - 1) {
            my $v = 0 + (!(($i + 1) % ($k + 1)) || !(($k + 1) % ($i + 1)));
            $a[$i][$k] = $v;
        }
    }

    # Find the number of cute lists.
    permanent_01(\@a);
}

# An attempt to implement the "Johnson-Gentleman tree minor algorithm":
# This is a non-recursive approach that avoids the re-examination of
# minors appearing in recursive approaches.  It does not split the task
# of calculating a determinant/permanent into smaller tasks but instead
# builds the whole result by extending from single elements.  This takes
# a lot of memory for larger matrices.  Restricting to matrices having
# only zeroes and ones as elements.
#
sub permanent_01 ($a) {
    my $node;
    my $last = $#$a;
    my $sel;

    # Nodes are key-value pairs where the keys are integers with bits
    # set for the selected rows forming a minor matrix and the
    # corresponding sub-permanent as values.

    # Build the first node, consisting of the non-zero elements of the
    # first column.
    for my $i (0 .. $last) {
        $node->{1 << $i} = 1 if $a->[0][$i];
    }

    # Loop over the remaining columns.
    for my $i (1 .. $last) {
        my $next;
        # Loop over all minors of the previous node. These have a size
        # of $i x $i
        for my $minor (keys %$node) {
            # Loop over all rows.  Process only nonzero elements.  Get
            # the selector for the current row and check if it is
            # already part of the current minor or add the minor's part
            # to the next larger minor extended by the current row
            # otherwise.  Avoiding any multiplications here as all
            # elements are zero or one - though the impact is very low.
            $a->[$i][$_] && (($sel = 1 << $_) & $minor && next ||
#            ($next->{$minor | $sel} += $a->[$i][$_] * $node->{$minor}))
            ($next->{$minor | $sel} += $node->{$minor}))
            for 0 .. $last;
        }
        $node = $next;
    }
    
    # At the end, there is only one value left - the permanent of the
    # whole matrix.
    (values %$node)[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_cute(2), 2, 'Example 1';
        is count_cute(1), 1, 'Example 2';
        is count_cute(10), 700, 'Example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is count_cute(15),  24679, 'N=15 from https://oeis.org/A320843';
        is count_cute(20),  1939684, 'N=20 from A320843';
	}

    done_testing;
    exit;
}

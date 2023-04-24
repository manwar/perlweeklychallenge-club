#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL 2.017;  # trimmed results from "rle"
use PDL::NiceSlice;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show moves

N
    list of numbers

EOS


### Input and Output

main: {
    my ($moves, $points) = collect_points(long [@ARGV]);
    if ($verbose) {
        say "(@ARGV)";
        say "max points: $points";
        printf "take (%3\$d)x%2\$d at %1\$d\n", $_->list for $moves->dog;
    } else {
        say $points;
    }
}


### Implementation

# Try all equal and consecutive numbers and find the maximum by
# recursion into the remaining list.

sub collect_points ($n, $coll=0) {
    $n->badflag(1);
    my ($count, $val) = rle $n;
    # Break recursion on a single value.  Return the final selection as
    # [[index, length, value]] and the squared length as score.
    return (
        long(0, $count(0), $val(0))->reshape(3, 1),
        $coll + $count(0;-) ** 2
    ) if $count->dim(0) == 1;
    # Loop over all equal and consecutive numbers.  The loop variable is
    # a piddle consisting of the part's offset and length.
    my $max = 0;
    my $move;
    for my $sel (append(0, $count->cumusumover->(0:-2))->glue(1, $count, $val)
            ->xchg(0, 1)->dog) {
        my $m = $n->copy;
        # Set the selection to BAD.
        $m($sel(0):$sel(0)+$sel(1)-1) .= $m->badvalue;
        # Recursion with the BAD elements removed.
        my ($moves, $points) =
            collect_points($m->where($m->isgood), $coll + $sel(1;-) ** 2);
        # Record a new maximum along with the moves leading there.
        ($move, $max) = ($sel->glue(1, $moves), $points) if $points > $max;
    }
    # Return the maximum and its moves.
    ($move, $max);
}



### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is collect_points(long(2,4,3,3,3,4,5,4,2)), 23, 'example 1';
        is collect_points(long(1,2,2,2,2,1)), 20, 'example 2';
        is collect_points(long([1])), 1, 'example 3';
        is collect_points(long(2,2,2,1,1,2,2,2)), 40, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}

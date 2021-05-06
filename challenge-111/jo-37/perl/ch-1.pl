#!/usr/bin/perl -s
#
use v5.16;
use PDL;
use Test2::V0 '!float';
use Benchmark 'cmpthese';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [value m...]

-examples
    run the examples from the challenge
 
-tests
    run some tests and benchmarks

value
    value to search for

m...
    The matrix' elements.  Each row is given as a single argument.  The
    individual elements are separated by comma and/or blanks, e.g.
    '1 2 3' '4 5 6' '7 8 9' or 1,2,3 4,5,6 7,8,9

EOS


### Input and Output

{
    my $value = shift;
    my $matrix = [map {[split /[, ] */]} @ARGV];
    say bsearch_matrix($matrix, v(0), @$matrix**2, $value);
}


### Implementations

# Perform a binary search within the matrix.  It would be pointless to
# convert the matrix into a 1-d array as this operation has a complexity
# of O(n²), whereas a binary search may be performed in O(log n).
# Therefore List::MoreUtils::bsearch is of no use for this task and we
# need to implement our own binary search.
# It needs large matrices for the binary search to become faster than a
# PDL scan.  While for the given 5x5 matrix there is a tie, the scan
# is faster until the size goes up to 100x100.
#
# $matrix: the matrix as an AoA reference
# $low: lower linear search index, inclusive
# $high: higher linear search index, exclusive
# $value: search value
# The caller's $_[1] and $_[2] have to be writable and will be modified!
sub bsearch_matrix ($matrix, $low, $high, $value) {
    my $low_val = get_at($matrix, $low);
    return 1 if $value == $low_val;
    return 0 if $value < $low_val;
    return 0 if $low + 1 == $high;

    # Split the search interval and select the appropriate part.
    my $mean = int(($low + $high) / 2);
    @_[1, 2] = $value < get_at($matrix, $mean) ?
        ($low, $mean) : ($mean, $high);

    # Recursion without stack growth.
    goto &{(__SUB__)};
}

# Retrieve matrix element by linear index.
sub get_at ($m, $l) {
    $m->[$l / @$m][$l % @$m];
}

# Turn the argument into an independent, writable value.
# Enforces call-by-value when applied to a subroutine parameter.
sub v ($v) {$v}

# Alternative PDL solution.  Simple and fast, though not optimal.
sub scan_matrix($pdl, $value) {
    any $pdl == $value;
}


### Examples and tests

sub run_tests {
    my $m = [
        [  1,  2,  3,  5,  7 ],
        [  9, 11, 15, 19, 20 ],
        [ 23, 24, 25, 29, 31 ],
        [ 32, 33, 39, 40, 42 ],
        [ 45, 47, 48, 49, 50 ]];
    my $high = @$m**2;

    SKIP: {
        skip "examples" unless $examples;

        my $pdl = long $m;
        ok !bsearch_matrix($m, v(0), v($high), 35), 'example 1, bsearch';
        ok !scan_matrix($pdl, 35), 'example 1, scan';
        ok bsearch_matrix($m, v(0), v($high), 39),  'example 2, bsearch';
        ok scan_matrix($pdl, 39),  'example 2, scan';
    }

    SKIP: {
        skip "tests" unless $tests;
        
        # Some edge cases.
        ok bsearch_matrix($m, v(0), v($high), 1),  'first element';
        ok bsearch_matrix($m, v(0), v($high), 50),  'last element';
        ok !bsearch_matrix($m, v(0), v($high), 0),  'below min';
        ok !bsearch_matrix($m, v(0), v($high), 51),  'above max';

        # bsearch is taking over:
        for (5, 80, 160) {
            my $pdl = sequence long, $_, $_;
            my $matrix = $pdl->unpdl;
            my $high = @$matrix**2;
            my $value = $high - 1;
            say "\n${_}x${_}:";
            cmpthese(-1, {
                    scan => sub {scan_matrix($pdl, $value)},
                    bsearch => sub {
                        bsearch_matrix($matrix, v(0), v($high), $value)
                    }
                });
        }
	}

    done_testing;
    exit;
}

__DATA__
5x5:
            Rate    scan bsearch
scan    115925/s      --     -0%
bsearch 115925/s      0%      --

80x80:
           Rate bsearch    scan
bsearch 47999/s      --    -21%
scan    60703/s     26%      --

160x160:
           Rate    scan bsearch
scan    25599/s      --    -39%
bsearch 42309/s     65%      --

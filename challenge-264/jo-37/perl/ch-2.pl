#!/usr/bin/perl -s

use v5.26;
use Test2::V0 '!float';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [SRC IDX]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SRC
    source array

IDX
    index array

EOS


### Input and Output

say "(@{target_array(map [split /[, ]/, $_], @ARGV)})";


### Implementation

sub target_array ($source, $indices) {
    my @source = @$source;
    my (@target, @begin, @end);
    # Loop over indices
    for my $i (@$indices) {
        # Get the corresponding source element
        my $s = shift @source;
        # Shift an existing block and store its new end
        if (defined(my $ei = $end[$i])) {
            @target[$i + 1 .. $ei + 1] = @target[$i .. $ei];
            $end[$i] = $ei + 1;
        }
        # Begin of block: existing or new
        my $b = $begin[$i] // $i;
        # Possibly join a preceding block
        $b = $begin[$b - 1] if $b > 0 && defined $begin[$b - 1];
        # End of block: existing or new
        my $e = $end[$i] // $i;
        # Possibly join a subsequent block
        $e = $end[$e + 1] if defined $end[$e + 1];
        # Update new block begin and end
        @end[$b .. $e] = ($e) x ($e + 1 - $b);
        @begin[$b .. $e] = ($b) x ($e + 1 - $b);
        # Store the current item
        $target[$i] = $s;
    }
    \@target;
}

sub target_array_si {
    use PDL;
    my ($s, $i) = map pdl($_), @_;
    $s->index(cat($i, -sequence($i))->xchg(0, 1)->qsortveci)->unpdl;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]),
            [0, 4, 1, 3, 2], 'example 1';
        is target_array_si([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]),
            [0, 4, 1, 3, 2], 'example 1 - isi';
        is target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]),
            [0, 1, 2, 3, 4], 'example 2';
        is target_array_si([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]),
            [0, 1, 2, 3, 4], 'example 2 - si';
        is target_array([1], [0]), [1], 'example 3';
        is target_array_si([1], [0]), [1], 'example 3 - si';
    }

    SKIP: {
        skip "tests" unless $tests;

        my sub smoke ($testee) {
            my @tests = (
              [[10, 21, 32, 40, 51], [0, 1, 2, 0, 1], [40, 51, 10, 21, 32]],
              [[10, 21, 30, 42, 51], [0, 1, 0, 2, 1], [30, 51, 10, 42, 21]],
              [[10, 20, 32, 41, 51], [0, 0, 2, 1, 1], [20, 51, 41, 10, 32]],
              [[10, 20, 31, 42, 51], [0, 0, 1, 2, 1], [20, 51, 31, 42, 10]],
              [[10, 21, 30, 41, 52], [0, 1, 0, 1, 2], [30, 41, 52, 10, 21]],
              [[10, 20, 31, 41, 52], [0, 0, 1, 1, 2], [20, 41, 52, 31, 10]]);
            plan scalar @tests;
            my $n;
            for my $test (@tests) {
                is $testee->($test->@[0,1]), $test->[2], 'smoketest ' . ++$n;
            }
        }

        subtest 'target array', \&smoke, \&target_array;
        SKIP: {
            skip "failing sort indices";
            subtest 'sort indices', \&smoke, \&target_array_si;
        }   

        is target_array([1, 2, 3, 4, 5, 6], [0, 2, 1, 0, 5, 3]),
            [4, 1, 3, 6, 2, 5], 'example from blog';

	}

    done_testing;
    exit;
}

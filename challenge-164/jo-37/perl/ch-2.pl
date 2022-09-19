#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(todigits vecreduce);
use Coro::Generator;
use Data::Dump;

use experimental 'signatures';

our ($tests, $examples, $base, $power);
$base ||= 10;
$power ||= 2;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    Specify the base. Default: 10

N
    Print the first N happy numbers in base B

EOS


### Input and Output

main: {
    my $happy = happy_gen($base);
    say for map $happy->(), 1 .. shift;
}


### Implementation

# Generalizing the task to b-happy numbers in any base.
#
# Build a generator for b-happy numbers.
sub happy_gen ($base) {
    my %happy;
    generator {
        for (my $n = 1;; $n++) {
            # Return cached results.
            if (exists $happy{$n}) {
                yield $n if $happy{$n};
                next;
            }
            # Get the digit square sum sequence for $n in base $base up to
            # the first known happy or unhappy number.
            my $seen = dsss($n, $base, \%happy);
            # Is $n a b-happy number?
            my $happy = $seen->{1};
            # Cache the new found numbers as happy or unhappy.
            @happy{keys %$seen} = ($happy) x keys %$seen;
            
            yield $n if $happy;
        }
    }
}

# Build a digit square sum sequence for $n in base $base with cached
# results in the hash ref $happy
sub dsss ($n, $base, $happy) {
    my %seen;
    # Test and set $n as seen.
    while (!$seen{$n}++) {
        if (exists $happy->{$n}) {
            # Add one as hash key to signal that a b-happy number has
            # been found.
            $seen{1} = 1 if $happy->{$n};
            return \%seen;
        }
        # Get the next number as the digit square sum of the current
        # number.
        $n = vecreduce {$a + $b**2} 0, todigits $n, $base;
    }
    # Return the seen numbers as hash keys.
    \%seen;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $happy = happy_gen(10);
        is [map $happy->(), 1 .. 8], [1, 7, 10, 13, 19, 23, 28, 31],
            'task 1 according to http://oeis.org/A007770';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $happy = happy_gen(6);
        is [map $happy->(), 1 .. 74],
            [1, 6, 36, 44, 49, 79, 100, 160, 170, 216, 224, 229, 254,
                264, 275, 285, 289, 294, 335, 347, 355, 357, 388, 405,
                415, 417, 439, 460, 469, 474, 533, 538, 580, 593, 600,
                608, 628, 638, 647, 695, 707, 715, 717, 767, 777, 787,
                835, 837, 847, 880, 890, 928, 940, 953, 960, 968, 1010,
                1018, 1020, 1033, 1058, 1125, 1135, 1137, 1168, 1178,
                1187, 1195, 1197, 1207, 1238, 1277, 1292, 1295],
            'From Wiki';
	}


    done_testing;
    exit;
}

#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Gather;
use List::Util 'min';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [I,D,A ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

I,D,A ...
    Triplets of service interval, departure minute and arrival minute

EOS


### Input and Output

say join ', ', let_leave(map [split ','], @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/06/19/ch-274.html#task-2


sub s2t ($s) {
    map {my $d = $s->[0] * $_ + $s->[1]; [$d, $d + $s->[2]]} 0 .. 60 / $s->[0];
}

sub let_leave {
    my $seq = 0;
    my @tt = sort {$a->[0] <=> $b->[0]}
        map [$_->[0], $seq++],
        sort {$a->[1] <=> $b->[1]}
        map s2t($_), @_;

    gather {
        (\my %expected)->@{0 .. $#tt} = ();
        my $depart = -1;
        for my $next (@tt) {
            my $d = $next->[0];
            my $seq = $next->[1];
            take $depart + 1 .. min $d, 59 if $seq > min keys %expected;
            delete $expected{$seq};
            $depart = $d;
            last if $depart > 59;
        }
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [let_leave([12, 11, 41], [15, 5, 35])], [36 .. 47], 'example 1';
        is [let_leave([12, 3, 41], [15, 9, 35], [30, 5, 25])],
            [0 .. 3, 25 .. 27, 40 .. 51, 55 .. 59], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}

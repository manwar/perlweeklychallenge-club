#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'binomial';
use Math::Utils 'ceil';
use List::Util 'reduce';
use experimental 'signatures';

our ($help, $tests, $verbose, $fusc);

run_tests() if $tests;	# does not return

die <<EOS if $help;
usage: $0 [-help] [-tests] [-verbose] [-fusc] [N]

-help
    print this help text

-tests
    run some tests

-verbose
    print argument and result

-fusc
    calculate fusc(N) only

N
    calculate fusc(k) for 0 <= k < N
    Default: 50

EOS


### Input and Output

my $n = shift // 50;
if ($fusc) {
    say "fusc($n)=" x !!$verbose, fusc($n);
} else {
    say "fusc($_)=" x !!$verbose, fusc($_) for 0 .. $n - 1;
}


### Implementation

# Non-recursive implementation of fusc according to
# http://oeis.org/A002487
sub fusc ($n) {
    # Interestingly, without the modulus this would produce the
    # respective Fibonacci number.
    reduce {$a += $b % 2} 0, map binomial($_, $n - $_ - 1),
        ceil(($n - 1) / 2) .. $n - 1;
}


### Tests

sub run_tests {

    my $n = 0;
    for (0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5, 4, 7,
        3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7,
        10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9, 7, 12, 5, 13, 8, 11, 3,
        10, 7, 11, 4, 9, 5, 6, 1, 7, 6, 11, 5, 14, 9, 13, 4, 15, 11,
        18, 7, 17, 10, 13, 3, 14, 11, 19, 8, 21, 13, 18, 5, 17, 12,
        19) {
        is fusc($n++), $_;
    }

    done_testing;
    exit;
}

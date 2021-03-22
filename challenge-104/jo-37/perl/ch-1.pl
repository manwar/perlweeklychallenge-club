#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use Math::Prime::Util 'binomial';
use List::Util 'reduce';
use Math::BigRat;
use PDL; # Just for ceil and rle
use experimental 'signatures';

our ($help, $tests, $verbose, $single, $cws);

run_tests() if $tests;	# does not return

die <<EOS if $help;
usage: $0 [-help] [-tests] [-verbose] [-single] [-cws] [N]

-help
    print this help text

-tests
    run some tests

-verbose
    print argument and result

-single
    calculate fusc(N) or fusc_from_cws(N) only

N
    calculate fusc(k) or fusc_from_cws(N) for 0 <= k < N
    Default: 50

EOS


### Input and Output

my $n = shift // 50;
if ($single) {
    if ($cws) {
        say "fusc_from_cws($n)=" x !!$verbose, fusc_from_cws($n);
    } else {
        say "fusc($n)=" x !!$verbose, fusc($n);
    }
} else {
    if ($cws) {
        say "fusc_from_cws($_)=" x !!$verbose, fusc_from_cws($_)
            for 0 .. $n - 1;
    } else {
        say "fusc($_)=" x !!$verbose, fusc($_) for 0 .. $n - 1;
    }
}


### Implementation

# Non-recursive implementation of fusc according to
# http://oeis.org/A002487 as the number of odd elements in the diagonal
# of Pascal's triangle.  Drawback of this implementations: rather large
# numbers are involved and lots of memory are wasted.
sub fusc ($n) {
    # Interestingly, without the modulus this would produce the
    # respective Fibonacci number.
    reduce {$a += $b % 2} 0, map binomial($_, $n - $_ - 1),
        ceil(($n - 1) / 2) .. $n - 1;
}

# An alternative non-recursive implementation:
# Compute fusc(n) from the Calkin-Wilf sequence.  The n-th element of
# the Calkin-Wilf sequence is the fraction fusc(n)/fusc(n+1).  This
# element can be calculated by taking the run-length encoding of the
# binary representation of n as the coefficients of a continued
# fraction.
# See https://en.wikipedia.org/wiki/Calkin%E2%80%93Wilf_tree
# Coefficients are in reversed order here.
#
# No performance or memory issues with this approach:
# ./ch-1.pl -single -cws -verbose 9223372036854775808
# works like a charm: fusc_from_cws(2**63)=1
sub fusc_from_cws ($n) {
    # This doesn't work for zero.
    return 0 unless $n;

    # Get the rle of the binary representation.  Using PDL here as I
    # didn't find an easier way.
    my @rle = grep $_, (rle(byte split //, sprintf '%b', $n))[0]->list;
    # Append a zero if the binary number ends in zero.  See the example
    # in Wikipedia.
    push @rle, 0 unless $n % 2;

    # Convert the first element of @rle to Math::BigRat, thus enabling
    # BigRat math for the evaluation of the continued fraction.
    $rle[0] = Math::BigRat->new($rle[0]);

    # Return the numerator from the calculated continued
    # fraction.
    (reduce {1 / $a + $b} @rle)->numerator;

}


### Tests

sub run_tests {

    my $n = 0;
    my @target = (0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5,
        4, 7, 3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7,
        10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9, 7, 12, 5, 13, 8, 11, 3, 10,
        7, 11, 4, 9, 5, 6, 1, 7, 6, 11, 5, 14, 9, 13, 4, 15, 11, 18, 7,
        17, 10, 13, 3, 14, 11, 19, 8, 21, 13, 18, 5, 17, 12, 19);
    for (@target) {
        is fusc($n++), $_;
    }
    $n = 0;
    for (@target) {
        is fusc_from_cws($n++), $_;
    }

    done_testing;
    exit;
}

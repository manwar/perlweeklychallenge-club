#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/
# Task #2
#
# Collatz Conjecture
# Contributed by Ryan Thompson
# It is thought that the following sequence will always reach 1:
#
# $n = $n / 2 when $n is even
# $n = 3*$n + 1 when $n is odd
# For example, if we start at 23, we get the following sequence:
#
# 23 -> 70 -> 35 -> 106 -> 53 -> 160 -> 80 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
#
# Write a function that finds the Collatz sequence for any positive integer.
# Notice how the sequence itself may go far above the original starting number.
#
# Extra Credit
# Have your script calculate the sequence length for all starting numbers up to 1000000 (1e6),
# and output the starting number and sequence length for the longest 20 sequences.

use strict;
use warnings;

use constant TOP_SEQ => 20;

my $n = shift;
if (defined $n) {
    die "USAGE: $0 <positive-integer>" unless $n && $n =~ /^\d+$/;
    print collatz_seq($n);
}
else{
    top_seq();
}

sub collatz_seq {
    my $n = shift;
    my $s;
    while ($n != 1) {
        $s .= $n . ' -> ';
        if ($n % 2 == 0) { $n = $n / 2;   }
        else             { $n = 3*$n + 1; }
    }
    return $s . 1;
}

sub top_seq {

    my @long_seq;
    my $min = 0;

    # reversing the order to check bigger numbers first
    # there are less unnecessary pushing/shifting elements
    # from @long_seq array
    for (reverse 1 .. 1_000_000) {
        my $l = seq_length($_);

        # Add sequence
        next if ($l < $min);
        push @long_seq, {'n' => $_, 'l' => $l};
        @long_seq = sort { $a->{l} <=> $b->{l} } @long_seq;

        # Adjust minimum sequence
        next if (@long_seq <= TOP_SEQ);
        shift @long_seq;
        $min = $long_seq[0]->{l};

    }

    print $_->{n} . ': ' . $_->{l}.$/ for (reverse @long_seq);

    return;
}

sub seq_length {
    my $n = shift;
    my $l = 0;
    while ($n != 1) {
        ++$l;
        if ($n % 2 == 0) { $n = $n / 2;   }
        else             { $n = 3*$n + 1; }
    }
    return ++$l;
}

__END__

./ch-2.pl 17
17 -> 52 -> 26 -> 13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1

time ./ch-2.pl
837799: 525
626331: 509
939497: 507
704623: 504
927003: 476
910107: 476
511935: 470
796095: 468
767903: 468
970599: 458
546681: 452
820023: 450
820022: 450
818943: 450
410011: 449
615017: 447
938143: 445
922526: 445
922525: 445
922524: 445

real    0m22,832s
user    0m22,760s
sys     0m0,031s

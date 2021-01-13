#!/usr/bin/perl
use strict;

# Usage: $ ch-1.pl (number of terms) (diff-k) (LIST of N sorted integers, from small to large)
# ch-1.pl 3 1 1 2 3

my $N = shift @ARGV;
my $DIFFK = shift @ARGV;

die "not enough terms or too many terms" if $N != $#ARGV+1;

my @A = @ARGV;

my @B;

for (1..$N-1) {
    push @B, $A[$_] - $A[$_-1];
}

for (0..$N-2) {
    my $diff = 0;
    my $pointer = $_+1;
    while ($pointer < $N and $diff <= $DIFFK) {
        $diff += $B[$pointer-1];
        print $pointer, " ", $_, "\n" if $diff==$DIFFK;
        $pointer++;
    }
}

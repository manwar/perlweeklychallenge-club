#!/usr/bin/perl
use 5.030;
use warnings;

my @n = @ARGV;

if (! scalar @n) {
    die "Need a list of integers.\n";
}

my @previous = @n[1 .. $#n];
my $total;

while (scalar @previous) {
    $total = $previous[0];
    my @next = ( $total );

    for my $i (1 .. scalar @previous - 1) {
        $total += $previous[$i];
        push @next, $total;
    }

    @previous = @next[1 .. $#next];
}

say $total;

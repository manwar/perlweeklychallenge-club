#!/usr/bin/perl
use 5.038;
use warnings;

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return (keys %elems);
}

my ($from, $to, $count) = @ARGV;
my $total = 0;

for my $i ($from .. $to) {
    my $shufflePairs = 0;
    my @digits = split //, $i;
    my $shortest = join q{}, sort @digits;

    for my $j (2 .. 100) {
        my $candidate = $i * $j;
        if (length $candidate > length $i) {
            last;
        }

        if ((join q{}, sort (split //, $candidate)) eq $shortest) {
            $shufflePairs++;
            if ($shufflePairs == $count) {
                $total++;
                last;
            }
        }
    }
}

say $total;

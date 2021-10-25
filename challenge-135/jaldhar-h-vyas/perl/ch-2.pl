#!/usr/bin/perl
use 5.020;
use warnings;

sub check {
    my ($sedol) = @_;

    if (length $sedol != 7) {
        return undef;
    }

    if ($sedol !~ /^ [0-9B-DF-HJ-NP-TV-Z]{6} [0-9] $/x) {
        return undef;
    }

    my @weights = (1, 3, 1, 7, 3, 9, 1);

    my @chars = split //, $sedol;

    my $sum = 0;

    for my $i (0 .. 5) {
        if (ord($chars[$i]) >= ord('0') && ord($chars[$i]) <= ord('9')) {
            $sum += $chars[$i] * $weights[$i];
        } else {
            $sum += (ord($chars[$i]) - ord('A')) * $weights[$i];
        }
    }

    return ((10 - $sum % 10) % 10) == $chars[6];
}

my $sedol = shift // die "Need a seven character string.\n";

say check($sedol) ? '1' : '0';

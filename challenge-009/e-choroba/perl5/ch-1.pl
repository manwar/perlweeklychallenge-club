#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub distinct_digits {
    my ($n) = @_;
    my %d;
    undef @d{split //, $n};
    return keys %d
}

my $n = int sqrt 10234;
while (distinct_digits($n ** 2) < 5) {
    ++$n;
}
say $n ** 2;

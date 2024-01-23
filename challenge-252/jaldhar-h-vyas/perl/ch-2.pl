#!/usr/bin/perl
use 5.030;
use warnings;

my $n = shift; 
my @results = map { $_, -$_ } (1 .. $n / 2);

unless ($n % 2 == 0) {
    push @results, 0;
}

say q{(}, (join q{, }, sort @results), q{)};

#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub factorial {
    my ($n) = @_;
    $n *= $_ for 2 .. $n - 1;
    return $n
}

my @max = (0, "");
while (my $word = <>) {
    chomp $word;
    my %frequency;
    ++$frequency{$_} for my @letters = split //, $word;
    my $count = factorial(scalar @letters);
    $count /= factorial($frequency{$_}) for keys %frequency;
    @max = ($count, $word) if $count > $max[0];
}

say "@max";

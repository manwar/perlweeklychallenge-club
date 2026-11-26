#!/usr/bin/env perl
use strict;
use warnings;
use Math::BigRat;

# Challenge 401, task 1. Pass each expression as one argument.
sub fraction_sum {
    my ($expr) = @_;
    my $sum = Math::BigRat->new(0);

    # A sign is optional only for the first term. Consume the whole string.
    while ($expr =~ /\G\s*([+-]?)\s*([0-9]+)\s*\/\s*([0-9]+)\s*/gc) {
        my ($sign, $num, $den) = ($1, $2, $3);
        die "Missing operator between fractions\n" if $-[0] > 0 && $sign eq '';
        die "Zero denominator\n" if $den !~ /[1-9]/;
        $sum->badd(Math::BigRat->new("$sign$num/$den"));
    }
    die "Expected a sum or difference of fractions\n"
        unless defined(pos($expr)) && pos($expr) == length($expr) && length($expr);

    return $sum->numerator() . '/' . $sum->denominator();
}

die "Usage: perl ch-1.pl '1/2+3/2' [...]\n" unless @ARGV;
print fraction_sum($_), "\n" for @ARGV;

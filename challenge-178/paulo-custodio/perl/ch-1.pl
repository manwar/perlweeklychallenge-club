#!/usr/bin/env perl

# Perl Weekly Challenge 178 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-178/

use Modern::Perl;

sub dec_to_base2i {
    my($n) = @_;
    my $base = -4;
    my $result = "";
    while ($n != 0) {
        my $i = $n % $base;
        $n /= $base;
        if ($i < 0) {
            $i += abs($base);
            $n++;
        }
        $result = "0".$i.$result;       # imaginary is zero
    }
    $result =~ s/^0+//;
    return $result;
}

sub base2i_to_dec {
    my($n2i) = @_;
    my $base = -4;
    my $result = 0;
    my @digits = reverse split //, $n2i;
    for my $i (0..$#digits) {
        if ($i % 2 == 0) {          # real part
            $result += $digits[$i] * $base ** ($i/2);
        }
        elsif ($digits[$i] != 0) {  # imaginary part
            die "number $n2i has imaginary component";
        }
    }
    return $result;
}

@ARGV==2 or die "usage: $0 dec_to_base2i|base2i_to_dec n\n";
if    ($ARGV[0] eq "dec_to_base2i") { say dec_to_base2i($ARGV[1]); }
elsif ($ARGV[0] eq "base2i_to_dec") { say base2i_to_dec($ARGV[1]); }
else { die "usage: $0 dec_to_base2i|base2i_to_dec n\n"; }

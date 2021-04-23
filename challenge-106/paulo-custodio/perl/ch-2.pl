#!/usr/bin/perl

# TASK #2 › Decimal String
# Submitted by: Mohammad S Anwar
# You are given numerator and denominator i.e. $N and $D.
# 
# Write a script to convert the fraction into decimal string. If the fractional
# part is recurring then put it in parenthesis.
# 
# Example
# Input: $N = 1, $D = 3
# Output: "0.(3)"
# 
# Input: $N = 1, $D = 2
# Output: "0.5"
# 
# Input: $N = 5, $D = 66
# Output: "0.0(75)"

use Modern::Perl;
use Math::BigFloat;

my($N, $D) = @ARGV;
say decimal($N, $D);

sub decimal {
    my($n,$d) = @_;

    Math::BigFloat->round_mode('trunc');    # so that 1/6=0.16666
    Math::BigFloat->accuracy(1000);         # very long list of digits
    
    my $N = Math::BigFloat->new($n);
    my $D = Math::BigFloat->new($d);
    my $Q = $N->copy()->bdiv($D);
    $Q =~ s/(\.\d+?)0+$/$1/;                # remove 00000 from 2.30000
    
    # naive solution: finds repetitions by string match
    for my $rept (1..100) {
        my $code = "return \$Q if \$Q =~ s/((\\d{$rept})\\2+)\\d*?\$/\\(\$2\\)/;";
        eval $code;
    }
    # no repetitions
    return $Q;
}

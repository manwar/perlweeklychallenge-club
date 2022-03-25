#!/usr/bin/env perl

# Challenge 150
#
# Input: $a = '1234' $b = '5678'
# Output: 7
#
# Fibonacci Words:
#
# '1234'
# '5678'
# '12345678'
# '567812345678'
# '12345678567812345678'
# '56781234567812345678567812345678'
# '1234567856781234567856781234567812345678567812345678'
#
# The 51st digit in the first term having at least 51 digits
# '1234567856781234567856781234567812345678567812345678' is 7.

use Modern::Perl;

my $pos = 51;

@ARGV==2 or die "Usage: ch-1.pl word word\n";
my @words = @ARGV;
my $fib_word = fib_word(@words[0..1], $pos);
say substr($fib_word, $pos-1, 1);

sub fib_word {
    my($a, $b, $len) = @_;
    my @seq = ($a, $b);
    while (length($seq[-1]) <= $len) {
        push @seq, $seq[-2].$seq[-1];
        shift @seq;
    }
    return $seq[-1];
}

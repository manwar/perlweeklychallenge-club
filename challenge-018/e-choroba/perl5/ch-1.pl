#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my @longest = ("");
my $string  = shift;
for my $pos (1 .. length $string) {
    for my $length (1 .. 1 - $pos + length $string) {
        next if $length < length $longest[0];

        my $substr = substr $string, $pos - 1, $length;
        my $found = 0;
        -1 != index $_, $substr and ++$found for @ARGV;
        if ($found == @ARGV) {
            if ($length == length $longest[0]) {
                push @longest, $substr;
            } else {
                @longest = $substr;
            }
        }
    }
}
say "<$_>" for @longest;

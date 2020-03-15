#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ product };

sub is_colorful_number {
    my ($n) = @_;
    my $max_length = length $n;
    my %uniq;
    my $count = 0;
    for my $length (1 .. $max_length) {
        for my $pos (0 .. $max_length - $length) {
            my @pattern = ((0) x $pos, (1) x $length);
            undef $uniq{
                product((split //, $n)[ grep $pattern[$_], 0 .. $#pattern ])
            };
        }
    }
    return ($max_length ** 2 + $max_length) / 2 == keys %uniq;
}

say for grep is_colorful_number($_), 100 .. 999;


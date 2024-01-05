#!/usr/bin/perl
use 5.030;
use warnings;

my $str = shift;

my @chars = split //, $str;
my @numbers = 0 .. length $str;
my @s;

for my $c (@chars) {
    if ($c eq 'D') {
        push @s, pop @numbers;
    }
    if ($c eq 'I') {
        push @s, shift @numbers;
    }
}
push @s, shift @numbers;

say q{(}, (join q{, }, @s), q{)};

#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub is_prime{
    my $num = shift;
    for my $i (2 .. $num ** .5) {
        return 0 if $num % $i == 0;
    }
    return 1;
}
my @p = grep is_prime($_), 1..105;
my @strong = map $p[$_],
    grep { $p[$_] - $p[$_-1] > $p[$_+1] - $p[$_] } 1..25;
my @weak = map $p[$_],
    grep { $p[$_] - $p[$_-1] < $p[$_+1] - $p[$_] } 1..25;
say "Strong: @strong[0..9]";
say "Weak: @weak[0..9]";

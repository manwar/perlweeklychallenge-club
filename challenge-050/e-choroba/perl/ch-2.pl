#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub noble_integer {
    my @s = sort { $b <=> $a } @_;
    my $c = 0;
    my @noble;
    for my $i (0 .. $#s) {
        push @noble, $s[$i] if $c == $s[$i];
        ++$c if $s[$i] != ($s[$i + 1] // $s[$i] + 1);
    }
    return @noble
}

use Test::More;

is_deeply [noble_integer(2, 6, 1, 3)], [2];
is_deeply [noble_integer(2, 2, 6, 1, 3)], [2, 2];
is_deeply [noble_integer(0, 0, 0)], [0, 0, 0];


#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub multiply {
    my ($x, $y) = @_;
    my $m = 0;
    my $sig = $x > 0 ? 1 : -1;
    while () {
        $m += $sig * $y if $x % 2;
        say "$x $y\t",
            $x % 2
                ? {1 => 'add ', -1 => ' subtract '}->{$sig} . $y
                : 'skip';
        last if 1 == abs $x || 0 == $x;

        $x = int($x / 2);
        $y *= 2;
    }
    say "The result is $m";
    return $m
}

my ($x, $y) = @ARGV;
$x * $y == multiply($x, $y) or die "Wrong!";

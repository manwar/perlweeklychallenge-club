#!/usr/bin/perl
use 5.038;
use warnings;

my $str = shift;
my $max = 0;
my @stack = (-1);
my @chars = split //, $str;

for my $i (keys @chars) {
    if ($chars[$i] eq q{(}) {
        push @stack, $i;
    } else {
        pop @stack;
        unless (scalar @stack) {
            push @stack, $i;
        } else {
            my $len = $i - $stack[-1];
            if ($len > $max) {
                $max = $len;
            }
        }
    }
}

say $max;

#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub female {
    my ($n) = @_;

    return ($n == 0) ? 1 : $n - male(female($n - 1));
}

sub male {
    my ($n) = @_;

    return ($n == 0) ? 0 : $n - female(male($n - 1));
}

my (@f, @m); 

for my $n (0 .. 20) {
    push @f, female($n);
    push @m,  male($n);
}

say 'Female: ', join ', ', @f;
say 'Male:   ', join ', ', @m;

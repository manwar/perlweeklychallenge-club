#!/usr/bin/perl
use v5.38;

my $sentance = shift;
my $repeat = 1;

say 
    join q{ },
    map {
        $_ . 'ma' . ('a' x $repeat++);
    }
    map {
        if (/^([^AaEeIiOoUu])(\S+)/) {
            s/(\S)(\S+)/$2$1/;
        }
        $_
    }
    split /\s+/, $sentance;

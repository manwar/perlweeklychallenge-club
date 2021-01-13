#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub gapful_iterator {
    my ($n) = @_;
    my $iterator = sub {
        $n++ until 0 == $n % join "", $n =~ /^(.)/, $n=~ /(.)$/;
        $n++
    };
}

my $iter = gapful_iterator(100);
say $iter->() for 1 .. 20;

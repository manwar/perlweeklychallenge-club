#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub prettify {
    my $matrix = shift;
    return join "\n", map { join " ", @$_ } @$matrix;
}

my $size = shift() - 1;
my @matrix = map { my $i = $_; [map { $i == $_ ? 1 : 0 } 0..$size] }
    0..$size;
say prettify \@matrix;

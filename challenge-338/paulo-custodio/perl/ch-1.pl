#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(max sum);

my @m = parse_input();
say max map {sum @$_} @m;

sub parse_input {
    my @m;
    while (<>) {
        my @r = split ' ', $_;
        push @m, \@r;
    }
    return @m;
}

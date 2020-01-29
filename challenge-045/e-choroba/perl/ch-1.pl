#!/usr/bin/perl
use warnings;
use strict;

sub square_secret_code {
    my ($message) = @_;
    my @code = ("") x 8;
    for my $group (lc($message) =~ s/\s//gr =~ m/(.{1,8})/g) {
        $code[$_] .= (split //, $group)[$_] // "" for 0 .. 7;
    }
    return join ' ', @code
}

use Test::More tests => 1;
is square_secret_code('The quick brown fox jumps over the lazy dog'),
    'tbjrd hruto eomhg qwpe unsl ifoa covz kxey',
    'encode';

#!/usr/bin/env perl

# Perl Weekly Challenge 349 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/

use Modern::Perl;

@ARGV==1 or die "usage: $0 UDLR...\n";
say passes_start($ARGV[0]) ? 'true' : 'false';

sub passes_start {
    my($moves) = @_;
    my($x, $y) = (0, 0);
    for (split //, $moves) {
        /R/ and $x++;
        /L/ and $x--;
        /U/ and $y++;
        /D/ and $y--;
        return 1 if $x==0 && $y==0;
    }
    return 0;
}

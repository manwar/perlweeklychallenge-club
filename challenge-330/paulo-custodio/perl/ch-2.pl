#!/usr/bin/env perl

# Perl Weekly Challenge 330 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-330/

use Modern::Perl;
use List::Util qw(uniq);

@ARGV or die "usage: $0 words...\n";
my $str = "@ARGV";
say join ' ', map {capitalize($_)} split ' ', $str;

sub capitalize {
    my($str) = @_;
    if (length($str) <= 2) {
        return lc($str);
    }
    else {
        return uc(substr($str,0,1)).lc(substr($str,1));
    }
}

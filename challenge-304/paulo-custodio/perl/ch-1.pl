#!/usr/bin/env perl

# Perl Weekly Challenge 304 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-304/

use Modern::Perl;

@ARGV==2 or die "usage: $0 1010101 n\n";

say can_arrange(@ARGV) ? "true" : "false";

sub can_arrange {
    my($bin, $n) = @_;
    return 0 if $bin =~ /11/;
    # replace minimum of n digits
    for (1..$n) {
        return 0 if !($bin =~ s/000/010/);
    }
    return 1;
}

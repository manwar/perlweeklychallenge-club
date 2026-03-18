#!/usr/bin/env perl

# Perl Weekly Challenge 239 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-239/

use Modern::Perl;

my($allowed, @strs) = @ARGV;
say scalar grep {is_consistent($_, $allowed)} @strs;

sub is_consistent {
    my($str, $allowed) = @_;
    for my $ch (split //, $allowed) {
        $str =~ s/$ch//ig;
    }
    return $str eq '';
}

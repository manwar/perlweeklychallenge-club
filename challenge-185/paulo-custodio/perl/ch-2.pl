#!/usr/bin/env perl

# Perl Weekly Challenge 185 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-185/

use Modern::Perl;

sub mask_code {
    my($code) = @_;
    $code =~ s/\w/\x01/ for 1..4;
    return $code =~ s/\x01/x/gr;
}

@ARGV or die "usage: ch-2.pl code...\n";
say join " ", map {mask_code($_)} @ARGV;

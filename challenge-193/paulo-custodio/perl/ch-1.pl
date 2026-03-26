#!/usr/bin/env perl

# Perl Weekly Challenge 193 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-193/

use Modern::Perl;

@ARGV==1 or die "usage: ch-1.pl n\n";
my $n=shift||1;
say "(", join(", ", map{sprintf("%0${n}b", $_)} (0..2**$n-1)), ")";

#!/usr/bin/env perl

# Perl Weekly Challenge 282 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/

use Modern::Perl;

@ARGV==1 or die "Usage: $0 STR\n";

my $str = uc(shift);
$str =~ s/(.)\1*/$1/g;
say length($str)-1;

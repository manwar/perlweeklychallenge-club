#!/usr/bin/env perl

# Perl Weekly Challenge 280 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/

use Modern::Perl;

my $str = shift // "";
$str =~ s/\|[^|]*\|//g;
my $count = $str =~ tr/*/*/;
say $count;

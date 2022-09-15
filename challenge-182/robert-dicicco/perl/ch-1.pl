#!perl.exe

use strict;
use warnings;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-12
# Challenge 182 Max Index ch-1.pl ( Perl )

my @n = (5, 2, 9, 1, 7, 6);

my %n_ndx = ();

my $count = 0;

foreach (@n) {

  $n_ndx{$_} = $count++;

}

my @n_srt = reverse sort(@n);

print "Input: \@n = \(@n\)\n";

print "Output: $n_ndx{$n_srt[0]}\n";

#! /usr/bin/perl
use strict;
use feature 'say';

my @list = (1, 3, 1, 2, 4, 5);
my %h;

$h{$_}++ for @list;

my $r = (sort { $h{$b}-$h{$a} } keys %h)[0];

print ( ($h{$r}> @list/2) ? $r : -1 )
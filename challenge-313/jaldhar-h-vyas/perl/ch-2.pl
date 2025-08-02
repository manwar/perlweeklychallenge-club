#!/usr/bin/perl
use v5.38;

my $str = shift;
my @reversed = reverse grep { /[[:alpha:]]/ } split //, $str;
my $index = 0;

$str =~ s/[[:alpha:]]/$reversed[$index++]/g;
say $str;
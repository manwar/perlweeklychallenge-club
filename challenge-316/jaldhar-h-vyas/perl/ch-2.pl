#!/usr/bin/perl
use v5.38;

my ($str1, $str2) = @ARGV;
my $match = join q{.*}, split //, $str1;
say $str2 =~ /$match/x ? 'true' : 'false';

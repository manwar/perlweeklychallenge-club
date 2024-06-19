#!/usr/bin/perl
use v5.38;
use Math::Round qw/ round /;

my ($str, $chr) = @ARGV;

my %freq;
map { $freq{$_}++; } split //, $str;

say exists $freq{$chr} ? round($freq{$chr} / (length $str) * 100) : 0;

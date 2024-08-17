#!/usr/bin/perl
use v5.38;

my $str = shift;
my @keys = @ARGV;


my $keys = join q{}, ('[', @keys, ']');
say scalar grep { $_ !~ /$keys/i } split /\s+/, $str;

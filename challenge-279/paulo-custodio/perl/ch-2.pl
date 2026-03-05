#!/usr/bin/env perl

use Modern::Perl;

my $str = "@ARGV";
my $vowels = $str =~ tr/aeiouAEIOU/aeiouAEIOU/;
say $vowels % 2 == 0 ? "true" : "false";    # actual splitting is not necessary

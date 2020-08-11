#!/usr/bin/env perl6

my $string="The quick brown fox jumps over the lazy dog";
my $padded=$string.trans(" "=>"");
my $a=$padded.comb.rotor: 8;
put ([Z~] $a).join: " ";

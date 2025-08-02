#!/usr/bin/perl
use v5.38;

my ($first, $second, $sentence) = @ARGV;
my @output = ($sentence =~ /(?=$first\s+$second\s+(\w+))/gmsx);
say q{(}, (join q{, }, map { "\"$_\"" } @output), q{)};

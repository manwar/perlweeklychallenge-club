#!/usr/bin/perl
use v5.38;

my $char = shift;
my @list = @ARGV;

say q{(}, (join q{, }, grep { index ($list[$_], $char) > -1 } keys @list), q{)};
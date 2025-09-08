#!/usr/bin/perl
use v5.38;
use warnings;
use builtin qw/ indexed /;
no warnings qw/ experimental::builtin experimental::for_list /;

my @num1 = @ARGV;
my %sorted;

foreach my ($k, $v) (reverse indexed sort { $a <=> $b } @num1) {
    $sorted{$k} //= $v;
}

say q{(}, (join q{, }, map { $sorted{$_} } @num1), q{)};

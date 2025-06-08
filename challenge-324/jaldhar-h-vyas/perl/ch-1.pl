#!/usr/bin/perl
use v5.38;

my ($r, $c, @ints) = @ARGV;
my @output;

for my $row (1 .. $r) {
    push @output, [ splice @ints, 0, $c ];
}

say q{(}, (join q{, }, map { q{[} . (join q{, }, @{$_}) . q{]} } @output), q{)};
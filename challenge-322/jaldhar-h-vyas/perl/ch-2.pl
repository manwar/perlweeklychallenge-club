#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;

my %ranked;
my $rank = 1;

for my $int (sort {$a <=> $b} @ints) {
    $ranked{$int} //= $rank++;
}

 say q{(}, (join q{, }, map { $ranked{$_} } @ints), q{)};

#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my %ones;

for my $i (@ints) {
    $ones{$i} = scalar grep { $_ == 1} split //, sprintf("%b", $i);
}

say q{(}, (join q{, }, sort { $ones{$a} <=> $ones{$b} || $a <=> $b } keys %ones), q{)};

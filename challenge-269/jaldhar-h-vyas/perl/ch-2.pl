#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my @arr1 = shift @ints;
my @arr2 = shift @ints;
for my $k (keys @ints) {
    if ($arr1[-1] > $arr2[-1]) { 
        push @arr1, $ints[$k];
     } else {
        push @arr2, $ints[$k];
     }
}
push @arr1, @arr2;

say q{(}, (join q{, }, @arr1), q{)};

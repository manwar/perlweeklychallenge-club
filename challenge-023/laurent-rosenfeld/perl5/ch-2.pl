#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my $num = shift;
my %factors;
while ($num % 2 == 0) {
    $factors{2} ++;
    $num /= 2;
}
my $div = 1;
while (1) {
    $div += 2;
    while ($num % $div == 0) {
        $factors{$div} ++;
        $num /= $div;
    }
    last if $num == 1
}
for my $fact (sort { $a <=> $b } keys %factors) {
    say "$fact ** $factors{$fact}";
}

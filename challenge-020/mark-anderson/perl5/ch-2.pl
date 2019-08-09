#!/usr/bin/env perl

use Modern::Perl '2018';
use List::Util 'sum';
use Math::Factor::XS 'factors';

my %sum;
my $num_1;

while(1) {
    $num_1++;
    $sum{$num_1} = sum(1, factors($num_1));
    my $sum_1 = $sum{$num_1};
    my $num_2 = $sum_1;
    next if $num_1 == $num_2;
    $sum{$num_2} // next;
    my $sum_2 = $sum{$num_2};

    if($num_1 == $sum_2) {
        say "$sum_1, $sum_2";
        last;
    }
}

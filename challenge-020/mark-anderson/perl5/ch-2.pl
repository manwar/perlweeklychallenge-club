#!/usr/bin/env perl

use Modern::Perl '2018';
use List::Util 'sum';
use Math::Factor::XS 'factors';

my %sum;

my $num_1 = 0;

while(1) {
    $num_1++;

    my $num_2 = sum (1, factors($num_1));

    next if $num_1 == $num_2;

    $sum{$num_1} = $num_2;

    $sum{$num_2} // next;

    if($num_1 == $sum{$num_2}) {
        say "$num_2, $num_1";
        last;
    }
}

#!/usr/bin/env perl

use Modern::Perl '2018';
use List::Util 'sum';
use Math::Factor::XS 'factors';

my %sum;
my $num;

while(1) {
    $num++;
    my $sum = $sum{$num} = sum(1, factors($num));

    $num != $sum || next;
    $sum{$sum}   // next;

    if($num == $sum{$sum}) {
        say "$sum, $num";
        last;
    }
}

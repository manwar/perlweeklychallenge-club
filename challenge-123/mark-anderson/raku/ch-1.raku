#!/usr/bin/env raku

# https://www.geeksforgeeks.org/ugly-numbers/

use Test;
plan 4;

is ugly(7),   8;
is ugly(10),  12;
is ugly(15),  24;
is ugly(150), 5832;

sub ugly($n where * >= 1)
{
    my ($i2, $i3, $i5);

    $i2 = $i3 = $i5 = 0; 
         
    my @uglies = [1];

    for 1..^$n
    {
        my $m2 = @uglies[$i2] * 2;
        my $m3 = @uglies[$i3] * 3;
        my $m5 = @uglies[$i5] * 5;

        my $min = min($m2, $m3, $m5);

        $i2++ if $min == $m2;    
        $i3++ if $min == $m3; 
        $i5++ if $min == $m5;           

        @uglies.push($min);
    }

    @uglies[*-1];
}

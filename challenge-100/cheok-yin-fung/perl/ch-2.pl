#!/usr/bin/perl
# The Weekly Challenge #100
# Task 2 Triangle Sum

use strict;
use warnings;
use Test::Simple tests => 3; 

sub go_upper_layer {
    my @triangle = @{$_[0]};
    my $layer = scalar @triangle;
    my @a = @{$triangle[-1]};
    while ($layer != 1) { 
        my @c;
        for my $t ( 0 .. $layer-2) {
            my $term = $triangle[-2]->[$t];
            $term = ($term + $a[$t] < $term + $a[$t+1]) ? 
                     $term + $a[$t] : $term + $a[$t+1];
            push @c, $term;
        }
        pop @triangle;
        @a = @c;    
        $layer--;    
    }
    return $a[0];
}


ok go_upper_layer( [ [1],[1,2],[1,2,3] ] ) == 3, "Test 1";
ok go_upper_layer( [ [1],[2,4],[6,4,9],[5,1,7,2] ] ) == 8 , "Example 1";
ok go_upper_layer( [ [3],[3,1],[5,2,3],[4,3,1,3] ] ) == 7, "Example 2";


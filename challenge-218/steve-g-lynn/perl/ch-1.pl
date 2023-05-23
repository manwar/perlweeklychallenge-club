#!/usr/bin/env -S perl -wl

use List::Util qw(max);

local *maximum_product = sub {
    
    local *myprod=sub {
        $_[0]*$_[1]*$_[2];
    };

    #-- main part of &maximum_product
    my @list = sort {$a <=> $b} @_;
    
    (scalar(@list) < 2) && (die "Need at least 3 elements in input"); 

    max( 
        &myprod( $list[0], $list[1], $list[-1] ),
        &myprod( $list[-1], $list[-2], $list[-3] )
    );
};

print &maximum_product( 3, 1, 2); #6
print &maximum_product( 4, 1, 3, 2); #24
print &maximum_product( -1, 0, 1, 3, 1); #3
print &maximum_product( -8, 2, -9, 0, -4, 3); #216

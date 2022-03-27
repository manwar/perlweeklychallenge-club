#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $num = 1994 ) ;

brazilian( $num ).say;

sub brazilian ( $num ) {
## up/down check if number is a Brazilian number
    return 1 if digit_test( $num, $_ ) for 2..$num-2 ;
    return 0;
}

sub digit_test ( $num is copy, $base ) {
## up/down check for all digits are the same in a given base 
## converts from base-10 to any given base
## does not internally store converted number other than 
## single digit as base-10 sequence index: 1
## short-circuits 0 if non-repeated digit found, otherwise returns 1
    my $rem; 
    my $digit;
    while ( $num > 0  ) {
        ($num, $rem) = $num div $base, $num % $base;   
        $digit //= $rem;
        return 0 if $digit != $rem;
    }
    return 1;
}




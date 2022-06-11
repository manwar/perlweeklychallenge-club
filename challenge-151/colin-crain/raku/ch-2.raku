#!/usr/bin/env perl6
#
#
#       daylight-robbery.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( *@arr ) ;


## test data
@arr = 1,2,3,4 if @arr.elems == 0;

say lookahead();

sub lookahead( $pos = -2, $sum is copy = 0) {
    return $sum if $pos > @arr.end;
    $pos >= 0 && $sum += @arr[$pos];
    ( lookahead( $pos + $_, $sum ) for 2, 3 ).max
}



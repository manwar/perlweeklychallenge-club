#!/usr/bin/env perl6
#
#
#       222-2-last-element-standing.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


unit sub MAIN ( *@arr ) ;

my $VERBOSE = 1;  ## show progress of array reduction?
@arr .= sort;

while @arr.elems > 1 {
    $VERBOSE && say @arr;
    $_ = [-] (@arr.splice(*-2).reverse) || next;
    @arr.splice( ((|@arr, $_).first: * >= $_, :k), 0, $_ );     
}

say @arr.defined ?? @arr[0] !! 0;








#!/usr/bin/env perl6
#
#
#       triangular-sum-ting.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( *@input ) ;

put trisum( @input ) and exit if @input.elems > 0 ;


sub trisum (*@list) {
    shift @list and @list = [\+] @list while @list.elems > 1;
    @list;
}





use Test;

is trisum(1, 2, 3, 4, 5), 42, 'ex-1';
is trisum(1, 3, 5, 7, 9), 70, 'ex-2';

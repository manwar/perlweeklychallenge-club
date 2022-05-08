#!/usr/bin/env perl6
#
#
#       163-1-an-sumting-else.raku
#
#       method:
#         reading left-to-right
#             1. take the input list
#             2. for each 2-combination of the elements
#             3. treated as a list, reduce the list by applying a bitwise AND
#             4. then sum the reduced results
#             5. implicitly return the sum
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( *@list ) ;

put and_sum( @list ) and exit if @list.elems > 0;

sub and_sum (*@list) {    
    @list.combinations(2).map({ [+&] |$_ }).sum
}


use Test;

is and_sum(1, 2, 3), 3, 'ex-1';
is and_sum(2, 3, 4), 2, 'ex-2';

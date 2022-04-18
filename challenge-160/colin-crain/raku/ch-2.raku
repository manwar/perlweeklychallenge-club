#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;


sub eq_direct (@list) {
## exhaustive traversal, re-summing side-lists
    @list.keys[1..@list.end-1].first( 
        { @list[$_+1..@list.end].sum == @list[0..$_-1].sum }
        ) // -1
} ;

sub eq_linear (@list) {
## single-pass continuous summing with lookup
    my %sums;
    my $total = @list.head;
    for (1..@list.end-1) {
        %sums{ 2 * $total + @list[$_] } = $_;
        $total += @list[$_];
    }
    $total += @list[*-1];
    return %sums{$total} // -1
}


use Test;

is eq_direct( [1, 3, 5, 7, 9] )   , 3,    'ex-1';
is eq_direct( [1, 2, 3, 4, 5] )   , -1,   'ex-2';
is eq_direct( [2, 4, 2] )         , 1,    'ex-3';


is eq_linear( [1, 3, 5, 7, 9] )   , 3,    'ex-1-lin';
is eq_linear( [1, 2, 3, 4, 5] )   , -1,   'ex-2-lin';
is eq_linear( [2, 4, 2] )         , 1,    'ex-3-lin';

## multi-stable arrays
is eq_direct( [5, -5, 0, 5, 0] )         , 1,    'bistable  exhaustive';
is eq_direct( [5, -5, 0, 5, 0, -5, 5] )  , 1,    'tristable exhaustive';

is eq_linear( [5, -5, 0, 5, 0] )         , 3,    'bistable  single pass';
is eq_linear( [5, -5, 0, 5, 0, -5, 5] )  , 5,    'tristable single pass';

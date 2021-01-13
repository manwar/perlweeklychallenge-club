#!/usr/bin/env perl
#
# ch-1.pl - Merge intervals
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use List::Util qw/reduce/;

sub merge_int {
    reduce {
        (@$a and $a->[-1][1] >= $b->[0]) ?
            $a->[-1] = [ $a->[-1][0], $b->[1] ] : push @$a, $b;
        $a;
    } [] => sort { $a->[0] <=> $b->[0] } @_;
}

use Test::More;

is_deeply 
    merge_int([2,7], [3,9], [10,12], [15,19], [18,22]), 
    [ [2, 9], [10, 12], [15, 22] ], 'PWC example';

is_deeply 
    merge_int([10,12], [18,22], [2,7], [15,19], [3,9]), 
    [ [2, 9], [10, 12], [15, 22] ], 'PWC example, unsorted';

done_testing;

#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ min sum };

# This is inspired by a reading of the problem
# from Adam Russell, who notes that there's no
# direct down-left or down-right between 3 on
# the second level and 2 on the third in this
# triangle:
#
#                1
#               5 3
#              2 3 4
#             7 1 0 2
#            6 4 5 2 8
#
# A similar problem occurs with the 0 on the
# fourth row of the second example:
#
#                5
#               2 3
#              4 1 5
#             0 1 2 3
#            7 2 4 1 9
#
# If the problem requires a solution that's less
# using List::Util and more actual tree structures,
# that solution will be forthcoming.

my @examples;
push @examples, '$triangle=[ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]';
push @examples, '$triangle=[ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]';

for my $e (@examples) {
    my $triangle;
    eval($e); 

    # let's do this the functional way?
    my $path = join ' + ', map { min $_->@* } $triangle->@*;
    my $sum  = sum map { min $_->@* } $triangle->@*;

    my $tree = make_tree($triangle);
    say <<"END";
        Input:  $e
        Output: $sum
        Minimum Sum Path = $path => $sum
$tree
END
}

sub make_tree ( $src ) {
    my $output = '';
    my $n      = 10;
    my $i      = 0;
    while ( $src->[$i] ) {
        my $line = join ' ', $src->[$i]->@*;
        $output .= "\n";
        $output .= ' ' x ( $n - $i );
        $output .= $line;
        $i++;
    }

    return $output;
}

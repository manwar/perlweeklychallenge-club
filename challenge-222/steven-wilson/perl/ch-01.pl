#!/usr/bin/env perl

use 5.18.0;
use Test::More;

sub matching_members {
    my $unsorted_ref = shift;
    my @unsorted     = @{$unsorted_ref};
    my @sorted       = sort { $a <=> $b } @unsorted;
    my $total = grep { $unsorted[$_] == $sorted[$_] }
        ( 0 .. ( scalar(@unsorted) - 1 ) );
    return $total;
}

my @ints_ex1 = ( 1, 1, 4, 2, 1, 3 );
my @ints_ex2 = ( 5, 1, 2, 3, 4 );
my @ints_ex3 = ( 1, 2, 3, 4, 5 );
cmp_ok( matching_members( \@ints_ex1 ), "==", 3 );
cmp_ok( matching_members( \@ints_ex2 ), "==", 0 );
cmp_ok( matching_members( \@ints_ex3 ), "==", 5 );
done_testing();

#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub two_out_of_three {
    my ( $array1, $array2, $array3 ) = @_;
    my %count;

    $count{$_}++ for @$array1;
    $count{$_} += 2 for @$array2;
    $count{$_} += 4 for @$array3;

    return
      sort { $a <=> $b }
      grep { $count{$_} == 1 + 2 || $count{$_} == 2 + 4 || $count{$_} == 1 + 4 || $count{$_} == 1 + 2 + 4 }
      keys %count;
}

my @array1 = ( 1, 1, 2, 4 );
my @array2 = ( 2, 4 );
my @array3 = (4);
is_deeply( [ two_out_of_three( \@array1, \@array2, \@array3 ) ], [ 2, 4 ], 'Test Case 1' );

my @array4 = ( 4, 1 );
my @array5 = ( 2, 4 );
my @array6 = ( 1, 2 );
is_deeply( [ two_out_of_three( \@array4, \@array5, \@array6 ) ], [ 1, 2, 4 ], 'Test Case 2' );

done_testing();

#!/usr/bin/env perl
# Week 139 Task 1
# JortSort

use strict;
use warnings;
use feature qw/ say /;
use Test::More;

my @input1_t = qw/ 1 2 3 4 5 /;
my @input2_t = qw/ 1 3 2 4 5 /;
ok( jortsort( \@input1_t ) == 1, "Sorted" );
ok( jortsort( \@input2_t ) == 0, "Unsorted" );
done_testing();

sub jortsort {
    my $input_ref    = shift;
    my @input        = @{$input_ref};
    my @sorted_input = sort @input;
    my $length       = scalar @input;
    my $sorted       = 1;
    for ( my $index = 0; $index < $length; $index++ ) {
        if ( $input[$index] != $sorted_input[$index] ) {
            $sorted = 0;
            last;
        }
    }
    return $sorted;
}

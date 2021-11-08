#!/usr/bin/env perl
# Week 135 Task 2
# Lychrel Number

use strict;
use warnings;
use Test::More;

ok( is_lychrel_number(56) == 0,  "Test 56" );
ok( is_lychrel_number(57) == 0,  "Test 57" );
ok( is_lychrel_number(59) == 0,  "Test 59" );
ok( is_lychrel_number(196) == 1, "Test 196" );
done_testing();

sub is_lychrel_number {
    my $number            = shift;
    my $max_iter          = 500;
    my $max_number        = 10_000_000;
    my $iter              = 0;
    my $is_lychrel_number = 1;
    ( $number >= 10 && $number <= 1000 )
        or die "Number must be be between 10 an 1000\n";
    while ( $iter < $max_iter && $number < $max_number ) {
        $number += reverse $number;
        if ( $number == reverse $number ) {
            $is_lychrel_number = 0;
            last;
        }
        $iter++;
    }
    return $is_lychrel_number;
}

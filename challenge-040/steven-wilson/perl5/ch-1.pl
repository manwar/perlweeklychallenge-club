#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-12-24
# Week: 040
# Task #1
# Show multiple arrays content
# You are given two or more arrays. Write a script to display values of
# each list at a given index.
# For example:
# Array 1: [ I L O V E Y O U ]
# Array 2: [ 2 4 0 3 2 0 1 9 ]
# Array 3: [ ! ? £ $ % ^ & * ]
# We expect the following output:
# I 2 !
# L 4 ?
# O 0 £
# V 3 $
# E 2 %
# Y 0 ^
# O 1 &
# U 9 *

use strict;
use warnings;

my @array_1 = qw[ I L O V E Y O U ];
my @array_2 = qw[ 2 4 0 3 2 0 1 9 ];
my @array_3 = qw[ ! ? £ $ % ^ & * ];
my @arrays  = [ \@array_1, \@array_2, \@array_3 ];

display_arrays( \@arrays );

sub display_arrays {
    my $arrays_ref = shift;
    my @arrays     = @$arrays_ref;
    for my $array_ref (@arrays) {
        my @array        = @$array_ref;
        my $max_index   = get_max_index($array_ref);
        my $no_of_arrays = scalar @array;
        for ( my $index = 0; $index < $max_index; $index++ ) {
            for ( my $array_no = 0; $array_no < $no_of_arrays; $array_no++ ) {
                defined @{$array[$array_no]}[$index]
                    ? print @{$array[$array_no]}[$index]
                    : print " ";
                print " ";
            }
            print "\n";
        }
    }
}

sub get_max_index {
    my $array_ref = shift;
    my @arrays    = @$array_ref;
    my $max       = 0;
    for my $array_ref (@arrays) {
        my @array = @$array_ref;
        if ( scalar @array > $max ) {
            $max = scalar @array;
        }
    }
    return $max;
}

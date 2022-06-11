#!/usr/bin/env perl

# Challenge 040
#
# TASK #1
# Show multiple arrays content
# You are given two or more arrays. Write a script to display values of each
# list at a given index.
#
# For example:
#
# Array 1: [ I L O V E Y O U ]
# Array 2: [ 2 4 0 3 2 0 1 9 ]
# Array 3: [ ! ? @ $ % ^ & * ]
# We expect the following output:
#
# I 2 !
# L 4 ?
# O 0 @
# V 3 $
# E 2 %
# Y 0 ^
# O 1 &
# U 9 *

use Modern::Perl;

show_multiple([qw( I L O V E Y O U )],
              [qw( 2 4 0 3 2 0 1 9 )],
              [qw( ! ? @ $ % ^ & * )]);

sub show_multiple {
    my(@data) = @_;
    for my $i (0 .. $#{$data[0]}) {
        for (@data) {
            print $_->[$i]," ";
        }
        print "\n";
    }
}

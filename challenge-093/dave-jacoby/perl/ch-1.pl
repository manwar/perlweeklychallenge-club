#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Algorithm::Permute;

my @examples;
push @examples, [ 1, [ [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] ] ];
push @examples, [ 2, [ [ 1, 1 ], [ 2, 2 ], [ 3, 1 ], [ 1, 3 ], [ 5, 3 ] ] ];
push @examples,
    [
    3,
    [ [ 1, 1 ], [ 2, 2 ], [ 3, 1 ], [ 1, 3 ], [ 3, 3 ], [ 4, 4 ], [ 5, 3 ] ]
    ];
push @examples, [ 4, [ [ 1, 2 ], [ 2, 4 ], [ 3, 6 ], [ 4, 8 ] ] ];

# here we go through every example set and create output
# like in the instructions
for my $example (@examples) {
    my @points = $example->[1]->@*;
    say qq{EXAMPLE $example->[0]};
    say '';
    plot_points(@points);
    my $output = max_points( \@points );

    say 'Input:  ' . join ', ',
        map { "($_)" } map { join ',', $_->@* } $example->[1]->@*;
    say 'Output: ' . $output;
    say '';
}

# if we have two points, we have a line, so the minimum
# covered here is 2. perhaps a test for a set with one point?

# but anyway, we pull out every three-point subset and
# test that, and if that works fine, we go to the four-point
# subsets and so on. a problem is that we use Algoritm::Permute
# which means for the set 1,2,3, we cover it six times, but
# it cleanly avoids all the headaches of putting together the
# subsets yourself, and is very fast.

# we test every subset, and if we fine a positive, that 
# means there is a line of this length, and then we go onto 
# the next length, because we don't care how many i-length
# lines there are; we just need one.
sub max_points ( $set ) {
    my $max = 2;
    my $len = scalar $set->@*;

OUTER: for my $i ( 3 .. $len ) {
        my $ap = Algorithm::Permute->new( $set, $i );
        while ( my @res = $ap->next ) {
            my $t = test_area(@res);
            if ($t) {
                $max = $i;
                last OUTER;
            }
        }
    }
    return $max;
}

# break up to triangles, which makes the area math easier
# and test every triangle for area 0, which would indicate
# a line. If we only get area 0, they're all on the line.

# first pass, I used Algorithm::Permute to go through all
# possible combinations, but no. Take a five-point set.
# we first test the first three. If there's a line there,
# there's a line. 
#
#   1 2 3 4 5
#   ^ ^ ^
#
# then we look at the second, third and fourth, and if the 
# fourth is in line with the second and third, it's in line 
# with the first.
#
#   1 2 3 4 5
#     ^ ^ ^
#
# and so on to the fifth.
#
#   1 2 3 4 5
#       ^ ^ ^
#
# which means that the subroutine is simpler and shorter than 
# the comment explaining it
sub test_area( @set ) {
    my $passes = 0;
    my $loops  = 0;
    for my $i ( 2 .. -1 + scalar @set ) {
        my @subset = map { $set[$_] } $i - 2, $i - 1, $i;
        my $t = collinear(@subset);
        $loops++;
        $passes++ if $t;
    }
    return 1 if $loops == $passes;
    return 0;
}

# finds area of a triangle, which would be zero if they're
# on the same line
sub collinear ( $p1, $p2, $p3 ) {
    my $area =
        $p1->[0] * ( $p2->[1] - $p3->[1] ) +
        $p2->[0] * ( $p3->[1] - $p1->[1] ) +
        $p3->[0] * ( $p1->[1] - $p2->[1] );
    return $area == 0 ? 1 : 0;
}

# helper function to turn the array ref with the x and y
# values into a string like "x,y"
sub xy ( $point ) {
    return join ',', $point->@*;
}

# this simply finds the highest x or y value, uses that 
# as the graph size, and draws the graph and plots the points
sub plot_points( @set ) {
    my %xy = map { $_ => 1 } map { join ',', $_->@* } @set;
    my @max;
    for my $point (@set) {
        push @max, $point->@*;
    }
    my ($max) = reverse sort @max;
    $max++;
    for my $y ( reverse 1 .. $max ) {
        print '|';
        for my $x ( 1 .. $max ) {
            my $xy = join ',', $x, $y;
            print $xy{$xy} ? ' X' : '  ';
        }
        say '';
    }
    say join ' ', '+', map { '-' } 0 .. $max;
}

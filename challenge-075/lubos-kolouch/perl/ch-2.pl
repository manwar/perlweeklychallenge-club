#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use List::Util qw(max);

# Task 2: Largest Rectangle Histogram
# Given an array of positive numbers @A, find the largest rectangle histogram.

sub format_histogram ($histogram) {
    return '' if !@$histogram;

    my $hist_max = max(@$histogram);
    my $max_len  = length($hist_max) + 1;
    my @lines;

    for my $i ( reverse 1 .. $hist_max ) {
        my $line = sprintf "%${max_len}s", $i;
        for my $bar (@$histogram) {
            $line .= $bar >= $i ? sprintf( "%${max_len}s", '#' ) : sprintf( "%${max_len}s", ' ' );
        }
        push @lines, $line;
    }

    my $separator = ( '_' x $max_len ) . ( '_' x ( $max_len * scalar @$histogram ) );
    push @lines, $separator;

    my $bottom_row = ' ' x $max_len;
    for my $bar (@$histogram) {
        $bottom_row .= sprintf "%${max_len}s", $bar;
    }
    push @lines, $bottom_row;

    return join( "\n", @lines );
}

sub largest_rectangle ($histogram) {
    return 0 if !@$histogram;

    my @stack;
    my $max_area = 0;
    my $n        = scalar @$histogram;

    for my $i ( 0 .. $n ) {
        my $curr_height = ( $i == $n ) ? 0 : $histogram->[$i];

        while ( @stack && $histogram->[ $stack[-1] ] > $curr_height ) {
            my $top_idx = pop @stack;
            my $h       = $histogram->[$top_idx];
            my $w       = @stack ? ( $i - $stack[-1] - 1 ) : $i;
            my $area    = $h * $w;
            $max_area = $area if $area > $max_area;
        }

        push @stack, $i;
    }

    return $max_area;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( largest_rectangle( [ 2, 1, 4, 5, 3, 7 ] ), 12, 'Example 1' );
    is( largest_rectangle( [ 3, 2, 3, 5, 7, 5 ] ), 15, 'Example 2' );
    is( largest_rectangle( [2] ),                   2,  'Single bar' );
    is( largest_rectangle( [ 2, 4 ] ),             4,  'Two bars' );
    is( largest_rectangle( [] ),                    0,  'Empty histogram' );

    done_testing();
}
else {
    say "Histogram:\n" . format_histogram( \@ARGV );
    say "Largest Rectangle Area: " . largest_rectangle( \@ARGV );
}

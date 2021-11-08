#!/usr/bin/env perl
# Translation of my Raku solution.
use strict;
use warnings;
use 5.026;
use experimental    qw<signatures>;
use List::Util 1.56 qw<min first>;

# Count uninterrupted zeros, omitting left-side neighbors.
# So, <1 0 0 0 1 0> becomes <0 3 2 1 0 1>.
sub streaks_of_zeros ( @row ) {
    my $streak = 0;
    return [reverse map {
        +( $streak = $_ ? 0 : $streak+1 )
    } reverse @row];
}
sub running_min_unil_zero ( @n ) {
    my $min = $n[0];
    my @r;
    for (@n) {
        $min = ($min <= $_) ? $min : $_;
        last if $min <= 0;
        push @r, $min;
    }
    return @r;
}
# Based on "bottleneck"; The max width of a rectangle that you are trying to fit as you scan downward,
# gets squeezed narrower each time you iterate through a less-wide row.
sub largest_sub_matrix_of_zeros ( $m ) {
    # Build parallel matrix of zeros-to-my-right. @m not needed after this.
    my @sog = map streaks_of_zeros(@{$_}), @{$m};

    my @max = ( 0, 0, 0 );
    for my $i ( keys @sog ) {
        my @row = @{ $sog[$i] };
        for my $j ( keys @row ) {
            my $v = $row[$j];
            # Since @sog holds the max-width to the right, a triangular reduce on `min` yields
            # the max rectangle size from i,j down to each row.
            my @column = map $_->[$j], @sog[ $i .. $#sog ];
            my @slice_mins = running_min_unil_zero @column;
            for my $depth0 ( keys @slice_mins ) {
                my $width = $slice_mins[$depth0];
                my $depth = $depth0 + 1;
                my $area  = $depth * $width;
                @max = ($depth, $width, $area) if $area > $max[2];
            }
        }
    }
    return @max;
}

my @tests = (
    [
        [qw<1 0 0 0 1 0>],
        [qw<1 1 0 0 0 1>],
        [qw<1 0 0 0 0 0>],
    ],
    [
        [qw<0 0 1 1>],
        [qw<0 0 0 1>],
        [qw<0 0 1 0>],
    ],
    [
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
    ],
    [
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>],
        [qw<1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>],
    ],
    [],
);
# @tests = @tests[0,1];
for (@tests) {
    my ($depth, $width) = largest_sub_matrix_of_zeros($_);
    say '---';
    say join(' ' => '[', (0) x $width, ']') for 1..$depth;
}

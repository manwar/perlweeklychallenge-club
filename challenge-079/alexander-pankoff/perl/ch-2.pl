#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(min max sum0 head);

# You are given an array of positive numbers @N.
#
# Write a script to represent it as Histogram Chart and find out how much water it can trap.

use constant DEBUG => $ENV{DEBUG} // 0;

my @N = @ARGV;

print_chart(@N);
say calculate_volume(@N);

sub calculate_volume(@chart) {

    my $volume = 0;
    my $last   = 0;
    my @bucket;

    for my $i ( 0 .. $#chart ) {

        my $cur = $chart[$i];
        if ( !@bucket && $last > $cur ) {
            push @bucket, $last;
        }

        if (@bucket) {
            push @bucket, $cur;
            if ( $cur >= $bucket[0] || $cur >= max( @chart[ $i .. $#chart ] ) )
            {
                $volume += bucket_volume(@bucket);
                @bucket = ();
            }
        }

        $last = $cur;
        $i++;
    }

    return $volume;

}

sub bucket_volume(@bucket) {

    my $lwall         = shift(@bucket);
    my $rwall         = pop(@bucket);
    my $bucket_height = min( $lwall, $rwall );
    return sum0( map { $bucket_height - $_ } @bucket );
}

sub print_chart (@chart) {

    my $height = max(@chart);

    for my $line ( reverse( 1 .. $height ) ) {
        say join( " ", $line, ( map { $_ < $line ? ' ' : '#' } @chart ) );
    }

    say join( "-", map { '-' } 1, @chart );
    say join( " ", ' ', @chart );
}

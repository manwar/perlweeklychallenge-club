#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 324 Task 1: 2D Array
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( natatime );

sub two_d_array_natatime( $ints, $r, $c ) {
    my @matrix;
    my $iterator = natatime $c, $ints->@*;
    while ( my @row = $iterator->() ) {
        push @matrix, [ @row ];
    }
    return @matrix;
}

sub two_d_array_map( $ints, $r, $c ) {
    return map [ $ints->@[ $_ * $c .. $_ * $c + $c - 1 ] ], 0 .. $r - 1;
}

# Other implementations for benchmarking:

sub two_d_array_1_for( $ints, $r, $c ) {
    my @matrix;
    for ( my $i = 0; $i < $ints->@*; $i += $c ) {
        push @matrix, [ $ints->@[ $i .. $i + $c - 1 ] ];
    }
    return @matrix;
}

sub two_d_array_2_incr( $ints, $r, $c ) {
    my @matrix;
    my $i = 0;
    for ( 1 .. $r ) {
        push @matrix, [ $ints->@[ $i .. $i + $c - 1 ] ];
        $i += $c;
    }
    return @matrix;
}

sub two_d_array_map( $ints, $r, $c ) {
    return map [ $ints->@[ $_ * $c .. $_ * $c + $c - 1 ] ], 0 .. $r - 1;
}

sub two_d_array_4_map_add( $ints, $r, $c ) {
    my $i = 0;
    return map { $i += $c; [ $ints->@[ $i - $c .. $i - 1 ] ] } 1..$r;
}

sub two_d_array_5_dyn_range( $ints, $r, $c ) {
    my $i = 0;
    return map [ $ints->@[ 0+$i .. ( $i += $c ) - 1 ] ], 1..$r;
}

sub two_d_array_6_splice( $ints, $r, $c ) {
    my @copy = $ints->@*;
    return map [ splice @copy, 0, $c ], 1..$r;
}

#
#   Flexible testing.
#

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

my $sub_name = "two_d_array";
my @tests = (
    [ "Example 1:", [ [1 .. 4], 2, 2 ], [ [1, 2], [3, 4] ] ],
    [ "Example 2:", [ [1, 2, 3], 1, 3 ], [ [1, 2, 3] ] ],
    [ "Example 3:", [ [1 .. 4], 4, 1 ], [ [1], [2], [3], [4] ] ],
);

# This runs the tests not only for the sub named "$sub_name",
# but also for all variants with any suffix ("$subname<suffix>").
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "\n", "Testing $sub:\n", "\n";
    for ( @tests ) {
        my ( $descr, $input, $expected ) = $_->@*;
        $descr .= " $sub" . pp( $input->@* ) . " == "
            . pp $expected->@*
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
        is [ $sub->( $input->@* ) ], $expected, $descr;
    }
}

done_testing;

__END__

use Benchmark qw( :all :hireswallclock );

my @benchmark_data = (
    [ [1 .. 4], 2, 2 ],
    [ [1..16], 4, 4 ],
    [ [1..100], 10, 10 ],
    [ [1..10000], 100, 100 ],
    [ [1..1000000], 1000, 1000 ],
);

for my $args ( @benchmark_data ) {
    say "array size: $args->[1] x $args->[2]";
    cmpthese( -5, {
        "natatime" => sub { two_d_array_natatime( $args->@* ) },
        # "1_for" => sub { two_d_array_1_for( $args->@* ) },
        # "2_incr" => sub { two_d_array_2_incr( $args->@* ) },
        "map" => sub { two_d_array_map( $args->@* ) },
        # "4_map_add" => sub { two_d_array_4_map_add( $args->@* ) },
        # "5_dyn_range" => sub { two_d_array_5_dyn_range( $args->@* ) },
        # "6_splice" => sub { two_d_array_6_splice( $args->@* ) },
    } );
}

exit 0;


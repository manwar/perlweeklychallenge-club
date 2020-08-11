#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-08-30
# Week: 023
#
# Task #1
# Create a script that prints nth order forward difference series. You
# should be a able to pass the list of numbers and order number as
# command line parameters. Let me show you with an example.

# Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would
# like to create 1st order forward difference series (Y). So using the
# formula Y(i) = X(i+1) - X(i), we get the following numbers: (9-5),
# (2-9), (8-2), (1-8), (6-1). In short, the final series would be: 4,
# -7, 6, -7, 5. If you noticed, it has one less number than the original
# series. Similary you can carry on 2nd order forward difference series
# like: (-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.
#
# Usage: $ perl ch-1.pl [order] [list of numbers]
# example: $ perl ch-1.pl 2 5 9 2 8 1 6

use strict;
use warnings;
use feature qw/ say /;

use Test::More;
use Test::Exception;

my @t_series = qw/ 5 9 2 8 1 6 /;

ok( "4 -7 6 -7 5" eq join( " ", @{ difference_series( \@t_series ) } ),
    "test forward diffence series" );
ok( "-11 13 -13 12" eq
        join( " ", @{ nth_order_difference_series( 2, \@t_series ) } ),
    "test 2nd order forward difference series"
);
dies_ok { nth_order_difference_series( 6, \@t_series ) }
"test dies if order too large";

done_testing();

my ( $order, @series ) = @ARGV;
my $ref_result_series = nth_order_difference_series( $order, \@series );
my @result_series = @{$ref_result_series};

say join( " ", @result_series );

sub nth_order_difference_series {
    my $order      = shift;
    my $ref_series = shift;
    my @series     = @{$ref_series};
    if ( $order < scalar @series ) {
        while ( $order > 0 ) {
            $ref_series = difference_series($ref_series);
            $order--;
        }
    }
    else {
        die "Series isn't large enough for this order value\n";
    }
    return $ref_series;
}

sub difference_series {
    my $ref_series  = shift;
    my @series      = @{$ref_series};
    my $series_size = scalar @series;
    my @diff_series;
    for ( my $i = 0; $i < ( $series_size - 1 ); $i++ ) {
        push @diff_series, ( $series[ $i + 1 ] - $series[$i] );
    }
    return \@diff_series;
}

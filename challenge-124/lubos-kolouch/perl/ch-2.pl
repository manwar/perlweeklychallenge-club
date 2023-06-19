#!/usr/bin/perl
use strict;
use warnings;
use List::Util               qw(sum);
use Algorithm::Combinatorics qw(combinations);

sub find_min_difference_subsets {
    my @list        = @_;
    my $n           = scalar @list;
    my $subset_size = int( $n / 2 );
    my @result;
    my $min_diff = 2**32;

    my $iter = combinations( \@list, $subset_size );
    while ( my $c = $iter->next ) {
        my $current_diff = abs( sum(@list) - 2 * sum(@$c) );
        if ( $current_diff < $min_diff ) {
            $min_diff = $current_diff;
            @result   = @$c;
        }
    }

    my %is_in_result;
    @is_in_result{@result} = ();
    my @other = grep { !exists( $is_in_result{$_} ) } @list;

    return \@result, \@other;
}

use Data::Dumper;
print Dumper(
    find_min_difference_subsets( 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ) );
print Dumper(
    find_min_difference_subsets( 10, -15, 20, 30, -25, 0, 5, 40, -5 ) );

#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental::postderef experimental::signatures };

# A number is called a stepping number if the adjacent digits
# have a difference of 1. For example, 456 is a stepping number
# but 129 is not.

if ( scalar @ARGV > 1 ) {
    my @nums = sort grep { $_ >= 100 && $_ <= 999 } map { int } @ARGV;
    my @list = get_stepping_numbers( $nums[0], $nums[-1] );
    say join ", ", @list;
}
else {
    my @list = get_stepping_numbers( 100, 999 );
    say join ", ", @list;
}

sub get_stepping_numbers ( $low, $high ) {
    my @output;
    for my $n ( $low .. $high ) {
        my @n = split //, $n;
        push @output, $n
            if off_by_one( $n[0], $n[1] ) && off_by_one( $n[1], $n[2] );
    }
    return @output;
}

sub off_by_one ( $i, $j ) {
    return 1 if $i == $j + 1;
    return 1 if $i == $j - 1;
    return 0;
}

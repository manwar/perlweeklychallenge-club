#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw( sum0 any );

use constant {
    MAX_NUMS     => 3,
    REQUIRED_SUM => 12,
};

sub n {
    my $depth = shift // 1;
    my @nums  = @_;

    my $sum = sum0 @nums;

    if ( $depth > MAX_NUMS || REQUIRED_SUM < $sum ) {

        if ( $sum == REQUIRED_SUM && any { $_ % 2 == 0 } @nums ) {
            print "@nums\n";
        }

        return;
    }
    n( $depth + 1, @nums, $_ ) for 0 .. REQUIRED_SUM;
}

n();

#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw( sum0 );

use constant {
    NUM_COUNT    => 3,
    REQUIRED_SUM => 12,
};

sub n {
    my $depth = shift // 1;
    my @nums  = @_;

    my $sum = sum0 @nums;

    if ( $depth > NUM_COUNT || REQUIRED_SUM < $sum ) {

        print "@nums\n" if $sum == REQUIRED_SUM;

        return;
    }
    n( $depth + 1, @nums, $_ ) for 1 .. REQUIRED_SUM;
}

n();

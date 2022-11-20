#!/usr/bin/env perl
package challenge191::ch2;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(all);

use constant DEBUG => $ENV{DEBUG} // 0;

for ( 1 .. 15 ) {
    my @cuties = cute_list($_);
    say '$n = ' . sprintf( "%2d", $_ ) . ": " . scalar @cuties;

    if (DEBUG) {
        say "  " . join( ", ", @$_ ) for @cuties;
    }
}

sub cute_list ( $size, $index = 1, $acc = [] ) {
    return $acc if $index > $size;

    my @xs         = 1 .. $size;
    my @candidates = grep { $_ % $index == 0 || $index % $_ == 0 } @xs;

    my @out;
    for my $candidate (@candidates) {
        if ( !grep { $candidate == $_ } @$acc ) {
            push @out, cute_list( $size, $index + 1, [ @$acc, $candidate ] );
        }
    }

    return @out;
}


#!/usr/bin/env perl
package challenge188::ch2;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use constant DEBUG => $ENV{DEBUG} // 0;

run() unless caller();

sub run() {
    my ( $x, $y ) = @ARGV;

    say total_zero( $x, $y );
}

sub total_zero ( $x, $y ) {
    my $gen = mk_step_gen( $x, $y );
    count_gen( DEBUG
        ? print_gen( sub($pair) { 'x='.$pair->[0] . ' y=' . $pair->[1] }, $gen )
        : $gen );
}

sub mk_step_gen ( $x, $y ) {

    return sub {
        my $orig_x = $x;
        state $x = $x;
        state $y = $y;

        # Assuming the task should have been j
        # - ...number of operations needed to make both ZERO
        # + ...number of operations needed to make one ZERO
        # Otherwise the examples don't make sense and this starts looping with
        # the same values as soon as one of the numbers reach zero
        # Literally it would have been:
        # `0 != $x || 0 != $y`
        if ( 0 != $x && 0 != $y ) {
            if ( $x >= $y ) {
                $x -= $y;
            }
            else {
                $y -= $x;
            }

            return [ $x, $y ];
        }

        return undef;
    }
}

sub print_gen ( $show, $gen ) {
    return sub {
        while ( my $res = $gen->() ) {
            say $show->($res);
            return $res;
        }
        return undef;
    }
}

sub count_gen($gen) {
    my $i = 0;
    while ( defined $gen->() ) {
        $i++;
    }
    return $i;
}


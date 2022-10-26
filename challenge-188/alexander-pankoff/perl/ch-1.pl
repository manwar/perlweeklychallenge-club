#!/usr/bin/env perl
package challenge188::ch1;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use constant DEBUG => $ENV{DEBUG} // 0;
run() unless caller();

sub run() {
    my ( $k, @list ) = @ARGV;

    say divisble_pairs( $k, @list );
}

sub divisble_pairs ( $k, @list ) {
    my @candidates = grep { $_ < @list } @list;
    my $pair_gen   = mk_pairs_with_pred_gen(
        sub ( $a, $b ) {
            $a < $b && ( $a + $b ) % $k == 0;
        },
        @list
    );

    count_gen(
        DEBUG
        ? print_gen( sub($pair) { '[' . $pair->[0] . ', ' . $pair->[1] . ']' },
            $pair_gen )
        : $pair_gen
    );

}

sub mk_pairs_with_pred_gen ( $pred, @list ) {

    return sub {
        state $i = 0;
        state $j = 0;
        my $return;

        for ( $i = $i ; $i <= $#list ; $i++ ) {
            for ( $j = $j ; $j <= $#list ; $j++ ) {
                return $return if $return;
                if ( $j == $i ) {
                    next;
                }

                my @pair = ( $list[$i], $list[$j] );
                if ( !$pred->( $list[$i], $list[$j] ) ) {
                    next;
                }

                $return = \@pair;
            }
            $j = 0;
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

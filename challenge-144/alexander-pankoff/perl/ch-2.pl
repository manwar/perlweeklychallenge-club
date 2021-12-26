#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say signatures';
no warnings qw'experimental::signatures';

use File::Spec;
use FindBin;
use List::Util qw(min sum);

use constant DEBUG => $ENV{DEBUG} // 0;

package Challenge141Task02 {
    require File::Spec->catfile( $FindBin::RealBin,
        qw'.. .. .. challenge-141 alexander-pankoff perl ch-2.pl' );
}

run() unless caller();

sub run() {
    my $u = Challenge141Task02::prompt_for_integer('u');

    my $v;
    do {
        $v = Challenge141Task02::prompt_for_integer('v');
    } while ( $v <= $u && say("'v' must be greater than 'u' ($u)") );

    say join( ', ', generate_ulam_sequence( $u, $v ) );
}

sub generate_ulam_sequence ( $u, $v, $length = 10 ) {
    my @sequence = ( $u, $v );
    my @sums     = ( $u + $v );

    while ( @sequence < $length ) {
        @sums = grep { $_ > $sequence[-1] } @sums;
        my @unique_sums = remove_dupes(@sums);
        my $new         = min(@unique_sums);
        push @sums, ( map { $_ + $new } @sequence );
        push @sequence, $new;
    }

    return @sequence;
}

sub remove_dupes(@xs) {
    my %count;
    $count{$_}++ for @xs;
    return grep { $count{$_} == 1 } keys %count;
}


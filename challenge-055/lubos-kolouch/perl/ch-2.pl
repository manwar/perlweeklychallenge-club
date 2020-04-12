##!/usr/bin/env perl

use strict;
use warnings;
use Math::Combinatorics;
use Data::Dumper;
use feature qw/say/;

sub process_all_waves {

    my $arr_ref = shift;

    my @result;

    my $combinat = Math::Combinatorics->new(
        count => scalar(@$arr_ref),
        data  => [@$arr_ref],
    );

    while ( my @permu = $combinat->next_permutation ) {
        push @result, \@permu if check_wave( \@permu );
    }

    return \@result;
}

sub check_wave {
    my $perm_ref = shift;

    # 1 = greater, -1 = smaller
    my $direction = 1;

    for ( 0 .. scalar(@$perm_ref) - 2 ) {
        if ( $direction == 1 ) {
            # stop if wave is broken
            return 0 if $$perm_ref[$_] < $$perm_ref[ $_ + 1 ];
        }
        else {
            return 0 if $$perm_ref[$_] > $$perm_ref[ $_ + 1 ];
        }

        $direction *= -1;
    }

    return 1;
}

my $all_waves = process_all_waves( [ 1, 2, 3, 4 ] );

warn Dumper \$all_waves;

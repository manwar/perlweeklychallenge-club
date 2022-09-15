#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;

my @array = ( 2, 0, 1 );

say 'PERMUTATION2RANK';
say permutation2rank( \@array );
say '';

@array = ( 2, 0, 1 );
say 'RANK2PERMUTATION';
say toformat( rank2permutation( \@array, 1 ) );

exit;

sub permutation2rank ( $ref ) {
    my $format = toformat($ref);
    my @pmutes = find_permutes($ref);
    for my $i ( map { $_ - 1 } 1 .. scalar @pmutes ) {
        my $lformat = toformat( $pmutes[$i] );
        return $i if $format eq $lformat;
    }
    return -1;
}

sub rank2permutation ( $ref, $rank ) {
    my $format = toformat($ref);
    my @pmutes = find_permutes($ref);
    return $pmutes[$rank];
}

sub find_permutes( $ref ) {
    my @pmutes;
    my $ap = Algorithm::Permute->new($ref);
    while ( my @list = $ap->next ) { push @pmutes, \@list; }
    @pmutes = sort { joinr($a) <=> joinr($b) } @pmutes;
    return @pmutes;
}

sub toformat( $ref ) {
    my $str = join ', ', $ref->@*;
    return qq{[$str]};
}

sub joinr ( $ref ) {
    return join '', $ref->@*;
}

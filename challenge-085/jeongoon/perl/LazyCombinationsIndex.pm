# -*- Mode: cperl; cperl-indent-level:4; tab-width: 8; indent-tabs-mode: nil -*-
# Copyright (c) 2013,2020 JEON Myoungjin <jeongoon@gmail.com>

package LazyCombinationsIndex;
use strict; use warnings;

use version 0.77; our $VERSION = version->declare( 'v0.1' );

use parent 'Exporter';
our @EXPORT_OK = qw(combinationsIndexIter);

sub DLEN () { 0 }       # Data Lengh
sub NSEL () { 1 }       # Number of selection
sub ROOM () { 2 }
sub POSI () { 3 }
sub NCSR () { 4 }       # Next Cursor

sub combinationsIndexIter {
    my $class = __PACKAGE__;
    my ( $C, $S ) = @_; # (C)hoice (S)slection

    my $self = [];
    # minimum sanity check
    if ( $C < $S ) {
        warn "unable to choose $S from given selection of $C";
        bless $self, $class;
    }

    $self = [ $C,                       # DLEN
              $S,                       # NSEL
              [ ( $C-$S ) x ($S-1),
                $C-$S+1 ],              # ROOM
              [ 0 .. ($S-2), ($S-2) ],  # POSI
              ($S - 1) ];               # NCSR

    bless $self, $class;
}

sub nextIndices {
    my $s   = shift;
    my $csr = $$s[NCSR];
    my $S   = $$s[NSEL];

    if ( $s->[ROOM][$csr] > 0 ) {
        # current csr can move to right so just do it.
        ++( $s->[POSI][$csr] );
        --( $s->[ROOM][$csr] );   # room decreased of course
        return [ @{$$s[POSI]} ];  # return copy of the case
    }
    else {
        # no more room to move
        # so find the next cursor to move
        my $found = 0;
        for ( my $i = $csr; $i > 0; --$i ) {
                if ( $s->[ROOM][ $i-1 ] > 0 ) {
                    $csr = $i-1;
                    $found = 1;
                    last;
                }
            }

        if ( $found ) {
            my $base_pos = $s->[POSI][$csr];
            @{$$s[POSI]}[$csr .. ($S-1)]
              = map { $base_pos + $_ } 1 .. ($S-$csr);
            @{$$s[ROOM]}[$csr .. ($S-1)]
              = ( $s->[ROOM][$csr] - 1  )     x    ($S-$csr);

            # next cursor to move will be ($S-1)
            # or even if it is not next loop will find anohter
            $$s[NCSR] = $S-1;

            # return copy of the case
            return [ @{$$s[POSI]} ];
        }
    }
    return (); # return undef if there is no more cases
}

!!"^^";

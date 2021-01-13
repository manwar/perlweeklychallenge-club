# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

package Ch2PlanA;

use strict; use warnings;
use parent 'Exporter';
use List::Util qw(sum);

our @EXPORT = qw(isInterleaving);

# non-recursive version because I saw so many recursive version already.
# I couldn't think my own version of recursive method. :-]

sub isInterleaving ($$$) {
    my ( $A, $B, $C ) = @_;
    my ( $Alen, $Blen, $Clen ) = map {length} @_;

    $Alen + $Blen == $Clen or return 0; # already done in main() but for sure.

    my ( $checkingPlanB, @saved ) = ( 0, () );
    my ( $Ai, $Bi, $Ci ) = (0) x 3;
    ++$|;
    my $interleaved = 0;
    {
        if ( $checkingPlanB ) {
            last if @saved == 0; # there is no plan B ...

            ( $Ai, $Bi ) = @{pop @saved};
            $checkingPlanB = 0; # reset status
        }
        $Ci = $Ai + $Bi;

        if ( $Ci == $Clen ) {  # no more from $C:  we are done.
            $interleaved = 1
        }
        elsif ( $Ai == $Alen ) { # used $A all
            if ( (substr $B, $Bi) eq (substr $C, $Ci) ) {
                # and rest of B is same as rest of C
                $interleaved = 1
            }
            else {
                ( $checkingPlanB = 1, redo );
            }
        }
        elsif ( $Bi == $Blen ) { # used $B all
            if ( (substr $A, $Ai) eq (substr $C, $Ci) ) {
                # and rest of A is same as rest of C
                $interleaved = 1
            }
            else {
                ( $checkingPlanB = 1, redo );
            }
        }
        else {
            my ( $headA, $headB ) = ((substr $A, $Ai, 1), (substr $B, $Bi , 1));
            if ( $headA eq $headB ) {
                if ( $headA eq ( substr $C, $Ci, 1 ) ) {
                    # save this place
                    push @saved, [ $Ai, ($Bi+1) ];
                    # then try A (always) first for next case
                    ++$Ai
                }
                else {
                    $checkingPlanB = 1
                }
            }
            else {
                my $headC = substr $C, $Ci, 1;
                if ( $headA eq $headC ) {
                    ++$Ai
                }
                elsif ( $headB eq $headC ) {
                    ++$Bi
                }
                else {
                    $checkingPlanB = 1
                }
            }
            redo;
        }
    }

    $interleaved
}

!!"yes! no!";

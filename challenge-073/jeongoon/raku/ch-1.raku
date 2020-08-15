#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

class memo {  has ( $.idx, $.val ); }

sub caculate-everytime ( :numbers(:@number-list),
                       Int :window-size(:$ssize) where $ssize > 2 ) {
    @number-list.rotor( $ssize => -($ssize-1) ).map( *.min ).Array;
}

sub caculate-sometime ( :numbers(:@number-list),
                      Int :window-size(:$ssize) where $ssize > 2 ) {

    my memo @memo = Empty;
    my $i        = -$ssize + 1; # pseudo index: starting from negative value

    @number-list.map(
    -> $c {
        my $b = $i + $ssize -1; # last index in the group or to be compared
        my $mem-inbound = ( @memo.first.?idx andthen * >= $i );
        my $grp-inbound = 0 <= $i && $b < @number-list.elems;

        if $grp-inbound.not or ( $grp-inbound and $mem-inbound) {
            given  ( @memo.first.?val andthen $c cmp * or Less ) {
                #say "A:$_";
                when Less {
                    @memo.unshift( memo.new( :idx($b), :val($c) ) );
                }
                when Same { # same but better update index because
                          # if less value located in later,
                          # there less chance to recalculate
                    @memo.first.idx = $b;
                }
                when More { # leave memory: maybe too complex to reorder
                          # better recalculate everything again
                          # later
                }
            }
        }
        else { # grp-inbound && not mem-inbound
            #say "B:trying memo";
            # memorised value at leftmost is not useful
            if @memo.elems { # but maybe we can use next available memo
                @memo.shift;
                redo; # without changing map status
            }
            else { # no memo: compare evertying in the group
                #say "B:no memo:compare everything";
                # first one
                @memo.push( memo.new( :idx($i), :val( @number-list[$i] )));
                # and rest
                for  ( $i ^.. $b ) -> $k {
                    if @memo.first.val >= @number-list[$k] { # new value is min.
                        if @memo.first.idx > $k {     # and located on the left
                            # save for next next chance
                            @memo.push( memo.new( :idx($k), :val( @number-list[$k] )));
                        }
                        else { # too complicate if we re-arrange memo.
                            # just forget it :-(
                            @memo = memo.new( :idx($k), :val( @number-list[$k ] ));
                        }
                    }
                }
            }
        }
        #@memo.map( -> $m { print "{$m.val}\@{$m.idx} "; } );
        #print ": total {@memo.elems}";
        ++$i;
        unless $grp-inbound {
            #say "";
            next;
        }
        #say ">>> {@memo.first.val}";
        @memo.first.val;
    } ).Array;
}

sub MAIN ( Int \S where * > 2 #= sliding window size (>2)
       ) {

    my \FS = 10 * ( .3 * S + .5 ).floor; # reasonable (F)rame (S)ize
    my @sample = ( 0 .. FS -1 ).pick( FS );
    say "Input:     {@sample.raku}";
    say "Correct:   " ~ caculate-everytime( :numbers(@sample), :window-size(S) ).raku;
    say "My Answer: " ~ caculate-sometime(  :numbers(@sample), :window-size(S) ).raku;


}

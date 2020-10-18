# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

package Ch2PlanB;

use strict; use warnings;
use parent 'Exporter';
use List::Util qw(all any min);

our @EXPORT = qw(allPossiblePartitions);

sub allPossiblePartitions ($$$) {
    my ( $A, $B, $C ) = @_;
    my $sum = length $C;
    my @sps = somePossilbeSum( 1, $sum, [], [],
          sub ($) { # check if we can continue to make a permutation sequences
              my $parts = shift;
              @$parts <= 1 and return 1; # 1 block is too short
                                        # because we need to compare both A,B

              my ( $splited, $o, $e ) # o: odd indexed  chars(string)
                                      # e: even indexed chars(string)
                  = uninterleave( $C, $parts );
              # check if *maybe* interleaved
              # we will confirm later
              return any { # any case of A, B vs B, A
                  my ($l, $r) = @$_; # left, right

                  all {
                      # minimum compare  left  vs odds
                      #               or right vs evens
                      my ($m, $n, $len) = @$_;
                      $len = min map {length} $m, $n;
                      substr( $m, 0, $len ) eq substr( $n, 0, $len )
                      } [$l, $o], [$r, $e];
              } [$A,$B], [$B,$A];
          }
        );

    map { # confirm the cases if actually interleaved
        if ( @$_ > 1 ) {
            my @resultRow = uninterleave( $C, $_ );
            my ( $splited, $o, $e ) = @resultRow;

            if ( any {
                my ( $a, $b ) = @$_;
                $a eq $o and $b eq $e
                 } [$A, $B], [$B, $A] ) {
                \@resultRow
            }
            else {
                ()  # not interleaved
            }
        } else {
            # skip if only one block,  becuase it doesn't make a interleave str.
            # it is okay only if A or B is empty.
            # but it doesn't make sense for me
            # because interleaving has no meaning if one of them is empty
            ()
        }
    } @sps;
}

# limited permutations with repeatition and filtering ...
# find any possible cases of group of natural numbers can make $sum

sub somePossilbeSum ( $$$$$ );
sub somePossilbeSum ( $$$$$ ) {
    my ( $n, $sum,
         $parentPartitions, # store numbers into ArrayRef
                            # to remember current depth and totoal summation
         $siblings,         # possible other cases at the same level
         $isValid           # validator for current case
        ) = @_;
    return () if $sum == 0;

    my $maybeNewPartitions = [ @$parentPartitions, $n ];

    if ( $isValid->( $maybeNewPartitions ) ) {

        if ( $n == $sum ) { # last (edge case) for parent case
                            # no more *next* cases in other word
                            # due to $n starts from 1 until meet $sum
            @$siblings, [ $n ]
        }
        else {
             # *maybe* have lower cases
            my @childrenCases = somePossilbeSum( 1,           # starts from 1
                                                 ($sum - $n ), # with rest
                                                 $maybeNewPartitions,
                                                 [],          # without siblings
                                                 $isValid );

            my @expandedCurrentCases = map { [ $n, @$_ ] } @childrenCases;

            # go for next case with siblings which includes current one.
            somePossilbeSum( ++$n,              # next case
                             $sum,              # with same number
                             $parentPartitions, # with the same parent
                             [ @$siblings, @expandedCurrentCases ],
                             $isValid )
        }
    } else {
        @$siblings
    }
}

sub uninterleave ( $$ ) {
    # return as ( <splited $str as ArrayRef>, <odd joined> <even joined> )
    my ( $str, $partitionsRule ) = @_;
    @$partitionsRule > 1 or return ();

    my ( $ff, @splited, $odds, $evens ) = (0); # ff: flip flop
    for my $size ( @$partitionsRule ) {
        my $choped = (substr $str, 0, $size, "");
        push @splited, $choped;
        ${ ($ff ^= 1) ? \$odds : \$evens } .= $choped;
    }
    \@splited, $odds, $evens
}

!!"But there is No Planet B";

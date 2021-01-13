#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;
use List::Util qw(all any min);
use FindBin;
use lib ($FindBin::Bin);

=pod Interleave String

=head1 SYNOPSIS

this will find the all the possilbe way to make interleave string

perl ch-2.pl [-a|--show-all-cases] <string> <string> <maybe interleaved string>
  Options:
    --show-all-cases: show all possible interleaving cases
                      otherwise show simple (1|0) answer.

=head1 Tested cases

# tested with:
# perl ch-2.pl ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCABCDDEFGHIJEFKLGHIJKLMNMNOOPPQRQRSTUVSTWXYUVWXYZZ   # 1: 256 cases
# perl ch-2.pl XY XX XYXX   # 1: 1 cases
# perl ch-2.pl 1X XX XXX1   # 0

=cut

sub usage {
    say $/,'Usage: perl ch-2.pl [-a|--show-all-cases] <string> <string>'.
      ' <maybe interleaved string>',
      $/,'ex) perl ch-1.pl AY AA AYAA  # only 1 case.',$/;
}

sub saySeprately ($$) {
    local $|; ++$|;

    print $_[0];
    print STDERR $_[1];
    print "\n";
}

package main;

my @f_ARGV = grep { ! /^-(a|-*show-all-cases)$/ } @ARGV;
our $quickCheckOnly = (@f_ARGV == @ARGV);

my ( $A, $B, $C ) = @f_ARGV;
(  @f_ARGV == 3
   and
   all { length $_ > 0 } $A, $B, $C  ) or usage, exit 0;

# minimum sanity check
(length $A) + (length $B) == (length $C)
  or saySeprately( 0, " as length A + B != C" );

if ( $quickCheckOnly ) {
    require Ch2PlanA;
    Ch2PlanA->import();
    say 0 + isInterleaving( $A, $B, $C );
}
else {
    require Ch2PlanB;
    Ch2PlanB->import();
    my @correctCases = allPossiblePartitions( $A, $B, $C );
    if ( @correctCases == 0 ) {
        saySeprately( 0, " as no interleaved case found" );
    }
    else {
        saySeprately( 1, " as we found ".+@correctCases." possible case(s).\n");
        say STDERR "e.g) $C can be decomposed like below:\n";

        local $" = "|";

        for ( @correctCases ) {
            my ( $splited, $left, $right ) = @$_;
            say STDERR "[@{$splited}] -(uninterleave)-> $left, $right ";
        }
    }
}

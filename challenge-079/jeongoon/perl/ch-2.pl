#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use utf8;
use strict; use warnings;
use v5.26;

use Getopt::Long qw(:config gnu_compat);
use Pod::Usage;
use Term::ANSIColor;

use List::Util qw(min max sum);
use List::MoreUtils qw(all firstidx);

=pod

=head1 NAME

Challenge 79 Task #2 - Trapped Rain Water
(https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/)

=head1 SYSNOPSIS

=head1 USAGE

perl ch-2.pl [--help] [--no-utf8] [--no-color] <N> <N> <N> [ <N>*... ]

=cut

=head1 TEST

perl ch-2.pl --no-utf8 --no-color 2 1 4 1 2 5 6 8 2 1 3 4 8 1 3 2 9 3 7 3 2 1 3
Total capacity: 53
 9|                                 #            
 8|               # ~ ~ ~ ~ # ~ ~ ~ #            
 7|               # ~ ~ ~ ~ # ~ ~ ~ # ~ #        
 6|             # # ~ ~ ~ ~ # ~ ~ ~ # ~ #        
 5|           # # # ~ ~ ~ ~ # ~ ~ ~ # ~ #        
 4|     # ~ ~ # # # ~ ~ ~ # # ~ ~ ~ # ~ #        
 3|     # ~ ~ # # # ~ ~ # # # ~ # ~ # # # # ~ ~ #
 2| # ~ # ~ # # # # # ~ # # # ~ # # # # # # # ~ #
 1| # # # # # # # # # # # # # # # # # # # # # # #
  `----------------------------------------------
    2 1 4 1 2 5 6 8 2 1 3 4 8 1 3 2 9 3 7 3 2 1 3

 you can try with colour and utf8 option if your terminal is supported.

 perl ch-2.pl 2 1 4 1 2 5 6 8 2 1 3 4 8 1 3 2 9 3 7 3
 https://res.cloudinary.com/practicaldev/image/fetch/s--1OVve57x--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/0mxarixhc6g8oe3bewx1.png

=cut

BEGIN {
    $::utf8   = 1;
    $::colour = 1;
    $::help   = 0;

    GetOptions( 'help'          => \$::help,
                'utf8!'         => \$::utf8,
                'color|colour!' => \$::colour,
              ) or pod2usage(2);
    if ( $::utf8 ) {
        binmode( STDERR, ':utf8' );
        binmode( STDOUT, ':utf8' );
    }

    eval { ( @ARGV > 2 and all { $_ > 0 } @ARGV ) or die "invalid" };
    ($@ or $::help)  and pod2usage( -exitval => 0, -verbose => ($::help ? 2:1));
}

sub ssprintf ($$) { sprintf "%#$_[0]s", $_[1] }
sub map_ssprintf  { map { sprintf "%#$_[0]s", $_ } @_[1..$#_] }

sub u_($) { # unicode
    return $_[0] unless $::utf8;
    my $a = shift;
    state %u = ( qw{` └
                    - ─
                    | │
                    ~ ≈}, '#' => '■' );
    $u{$a} // $a
}

sub ch($$;$) { # unicode with colour
    my $a  = shift;
    my $ww = shift // 2;
    my $colour_str = shift;

    if ( $::colour and defined $colour_str ) {
        $a eq '#' and $a = ' '; # distinguish by color
        return colored( [ $colour_str ], ssprintf $ww, u_$a );
    }
    return ssprintf $ww, u_$a;
}

sub printTrappedInWater {
    my @T = @{$_[0]}; # territory heights
    my @W = @{$_[1]}; # water capacty

    my $maxh = max @T;                  # max height
    my $ww   = 1 + length $maxh;        # word width

    for my $y ( reverse 1 .. $maxh ) {
        my $line = ssprintf $ww, $y;
        $line .= u_"|";
        for my $x ( 0.. $#T ) {
            my $ch;
            if ( $T[$x] >= $y ) {
                $ch = ch("#", $ww, 'black on_yellow' );
            }
            elsif ( $W[$x] > 0 and $T[$x]+$W[$x] >= $y ) {
                $ch = ch("~", $ww, 'black on_cyan');
            }
            else {
                $ch = ch(" ", $ww);
            }
            $line .= $ch;
        }
        say $line;
    }

    say ssprintf( $ww, " " ), u_"`",
      map_ssprintf( $ww, ( (u_("-") x $ww ) x scalar @T ) );
    say ssprintf($ww, " "), " ",map_ssprintf( $ww, @T );
}

package main;

my @T = @ARGV;
my @W = (0) x scalar @T; # for water capacity per column
my ( $start, $left ) = ( 0, $T[0] );

for ( my $x = 1; $x < @T; ) {
    if ( $left <= $T[$x] ) { # increasing only: no useful data
        ( $start, $left ) = ( $x, $T[$x] );
        ++$x;
    }
    elsif ( (my $ri = firstidx { $_ >= $left } @T[$x..$#T]) >= 0 ) {
        my $abs_ri = $x+$ri;
        my $water_level = min( $left, $T[$abs_ri] );
        for (($start+1) .. ($abs_ri-1)) { # water area only
            $W[$_] = $water_level - $T[$_]
        }

        ( $start, $left ) = ( $x, $T[$abs_ri] );
        $x += $ri;
    }
    else { # generally decreasing ...
           # find a tallest one as right boundary
        my $tallest = max @T[$x .. $#T];
        if ( (my $ri = firstidx { $_ == $tallest } @T[$x..$#T]) >= 0 ) {
            my $abs_ri = $x+$ri;
            my $water_level = min( $left, $T[$abs_ri] );

            for (($start+1) .. ($abs_ri-1)) {
                $W[$_] = $water_level - $T[$_];
            }
            ( $start, $left ) = ( $x, $T[$x] );
            ++$x;
        }
    }
}

say "Total capacity: ",sum(@W);
printTrappedInWater( \@T, \@W );


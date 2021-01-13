#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# test with:
# raku jeongoon/raku/ch-2.raku 2 1 4 1 2 5 # exmaple 1
# raku jeongoon/raku/ch-2.raku 3 1 3 1 1 5 # exmaple 2
# raku jeongoon/raku/ch-2.raku 1 2 3 4 3 1 # a mountain: no rain trapped
# raku jeongoon/raku/ch-2.raku 2 1 4 1 2 5 6 8 2 1 3 4 8 1 3 2 9 3 7 3 # long

unit sub MAIN ( *@T where { @T.elems > 0 and @T.all ~~ UInt } );
#@T = @T».UInt; # unnecessary here. but note that thery are IntStr

role lake {
    method get-capacity-info( $territory-data = self ) {
        my ( $range, $terri ) = $territory-data.kv; # k: Range, v: List
        # we need at least 3 data to build a water reservoir : will check later
        #$terri.elems < 3 and (Nil => 0).return;
        with $terri {
            my $water-level = min( .head, .tail );
            my @t = .[ 1 .. * -2 ];
            #@t.max > $water-level and (Nil => 0).return; # will check later
            ($range.[1 .. * -2] => ($water-level X- @t).cache ).return;
            # k: Range, v: capacity
        }
    }
}

my $terri = class TerriInfo {
    has ( $.left, $.start ) is rw;
    has @.T;
    method export-lake($x) { ((self.start..$x)
                              => (@!T[ self.start..$x ])) does lake }
}.new( :T(@T):left(@T[0]):start(0) );

my @lakes;
# let's scan the territory and find proper lake region
given $terri {
    loop ( my $x = 1; $x < @T.elems; ) {
        if .left <= @T[$x] { # climbing only: no useful data
            ( .start, .left ) = $x, @T[$x];
            ++$x;
        }
        elsif my $right = @T[$x..*].pairs.first( *.value >= .left ) {
            @lakes.push( .export-lake( $x+$right.key ) );
            ( .start, .left ) = $x, $right.value;
            $x += $right.key;
        }
        else { # generally desceding:
               # find a tallest wall as right boundary
            if ( my $right = @T[$x..*].pairs.max( *.value ) ) {
                @lakes.push( .export-lake( $x+$right.key) );
            }
            ( .start, .left ) = $x, @T[$x];
            ++$x;
        }
    }
}

my @lakes-info = @lakes».get-capacity-info;
say "Total capacity: ", ([+] @lakes-info».value».sum),"\n";

sub ssprintf ( UInt:D $w, $str ) { sprintf( "%#{$w}s", $str ) }

# print histogram
my @histo;
my $mh = max @T;
my $ww = $mh.chars + 1;
for $mh ... 1 -> $y {
    my $line = ssprintf( $ww, $y ) ~ '│';
    for @T.kv -> $x, $h {
        my $ch = " "; # assume air (can be changed later)
        if $h >= $y {
            $ch = "#";
        }
        else {
            my ( $range, $cap ) = @lakes-info.first( $x ∈ *.key ).kv;
            with $cap andthen $cap.[ $x -$range.[0] ] {
                    $_ + $h >= $y and $ch = "≈";
            }
        }
        $line ~= ssprintf( $ww, $ch );
    }
    @histo.push($line);
}

@histo.join("\n").say;

say ssprintf( $ww, " " ) ~ '└' ~ ( "─" x ( $ww * @T.elems ) );
say ssprintf( $ww, " " ) ~ ' ' ~ [~] @T.map( -> $h { ssprintf( $ww, $h ) });

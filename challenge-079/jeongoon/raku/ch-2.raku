#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# test with:
# raku jeongoon/ch-2.raku 2 1 4 1 2 5 # exmaple 1
# raku jeongoon/ch-2.raku 3 1 3 1 1 5 # exmaple 2
# raku jeongoon/ch-2.raku 1 2 3 4 3 1 # a mountain: no rain trapped

unit sub MAIN ( *@T where { @T.elems > 0 and @T.all ~~ UInt } );
#@T = @T».UInt; # unnecessary here. but note that thery are IntStr

enum territory-stage
<terri-nothing   terri-wall   terri-mountain
 terri-lake>; # terri-lake is not used here

role lake {
    method get-capacity( @territory = self.List ) {
        # we need at least 3 data to build a water reservoir
        @territory.elems < 3 and 0.return;
        with @territory {
            my $water-level = min( .head, .tail );
            my @t = .[ 1 .. * -2 ];
            @t.max > $water-level and 0.return;
            ( [+] ( $water-level X- @t ) ).return;
        }
    }
}

# we can do some brute-force for any combinations of region but
# let's scan the territory and find proper lake region
my $terri = class TerriInfo {
    has ( $.left, $.right, $.start,
          territory-stage $.stage  ) is rw;
    method has-valley ( $pos-x ) { $pos-x - $!start > 1 }
}.new( :left(0):start(0):stage(terri-nothing) );

my lake @lakes;

for @T.kv -> $x, $h {
    given $terri {
        when .stage before terri-wall {
            ( .left, .start, .stage ) = $h, $x, terri-wall;
        }
        when .stage before terri-mountain {
            if .left <= $h {  # no useful data on the left hand side
                           # -> update left boundary and position
                ( .left, .start ) = $h, $x;
            }
            else { # has at lesast one lower height than left boundary
                ( .right, .stage ) = $h, terri-mountain;
            }
        }
        when  .left < $h { # and .stage eq terri-mountain
            # found a lake
            @lakes.push( @T[ .start .. $x ] does lake );
            # right boundary is higher than left one and has valley
            # -> start new scan with right boundary as new left boundary
            $_ = TerriInfo.new( :start($x):left($h):stage( terri-wall ) );
            next;
        }
        default { # .left >= $h
            # second-tallest height -> become a  temporary right boundary
            .right < $h and .right = $h;

            # otherwise we may have some water bucket here
            # but still unsure until reach the right boundary
        }
    }

    LAST {
        # check if any possble lake remained
        .stage eq terri-mountain
        and @lakes.push( @T[ .start .. * ] does lake ) with $terri;
    }
}

my &say-simple-answer = &say ∘ &sum ∘ ( *.map( *.get-capacity ) );
say-simple-answer @lakes;

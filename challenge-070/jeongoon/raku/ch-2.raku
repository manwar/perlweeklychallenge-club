#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# test: raku ch-2.raku --max=6 6

our $seqTwo = [ 0, 1, 3, 2 ];
our @seqCache = $seqTwo;

class NbitGrayCode {
    has Int $.N;
    method base-index () returns Int  { return $!N-4 } # N=4 => base index (N=2): 0
    method depth-to-defined () returns Int {
        my $depth = 0;
        while ( @seqCache[ self.base-index - $depth ].defined.not ) { ++$depth }
        return $depth;
    }

    method my-index () returns Int { self.base-index + 2 }

    submethod BUILD ( Int:D :$max where { $max >= 5 },
                      Int:D :$N   where  { 2 <= $N <= $max } )  {
        $!N = $N; # XXX

    }

    method get-graycode () returns Array {
        given $!N {
            when 2 { return  $seqTwo }
            when 3 { # test basic method
                return @seqCache[ 1 ] = ( $seqTwo.flat,
                                     ( $seqTwo.reverse X+ 2**2)).flat.Array;
            }
        }

        my $d = self.depth-to-defined;
        loop ( my $i = 0; $i < $d + 1; $i += 2 ) {
            my $offset = self.base-index - $d + $i;
            self!generate-seq-from-base( :first($offset+1), :second($offset+2),
                                       :part-seq( @seqCache[$offset] ) )
        }
        if so ( $d % 2 ) { # N = 5, 7, 9 ...
            self!generate-seq-from-base( :first( self.my-index ),
                                       :part-seq( @seqCache[ self.my-index - 1 ] ) );
        }
        return @seqCache[ self.my-index ].Array;
    }

    method !generate-seq-from-base( List :$part-seq,
                               Int:D :$first where { $first > 0 },
                               Int   :$second? ) {
        my $half-size = ( $part-seq.elems * 0.5 ).Int;

        @seqCache[$first] = Empty;
        # slip or |() is very important !! quite different from perl
        for ^$half-size -> $l, $r {
            @seqCache[$first] = |( slip(@seqCache[$first]) ),
                                |( ( 0, 1, 3, 2 ) X+ 4* $part-seq[$l]),
                                |( ( 2, 3, 1, 0 ) X+ 4* $part-seq[$r]);
        }
        #say "first>>>" ~ @seqCache[ $first ];

        return unless $second.defined and $first + 1 == $second;

        @seqCache[$second] = |@seqCache[$first];
        for $half-size ..$half-size*2 -1 -> $l, $r {
            @seqCache[ $second ] = |( @seqCache[$second] ),
            |( ( 0, 1, 3, 2 ) X+ 4* $part-seq[$l] ),
            |( ( 2, 3, 1, 0 ) X+ 4* $part-seq[$r] );
        }
        #say "second>>>" ~ @seqCache[ $second];
    }
}

sub MAIN (
    Int:D $N = 5,          #= N bit where 2 <= $N <= 5
    Int:D :$max = 5, #= if you want to increase default maximum value
) {
    my $ncode = NbitGrayCode.new( :$N, :max( $max ) );
    $*ERR.print: "Input: \$N = $N\nOutput: ";
    say ~$ncode.get-graycode.Array.raku;
}

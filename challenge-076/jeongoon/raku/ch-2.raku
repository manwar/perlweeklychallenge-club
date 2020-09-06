#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

our $debugging = False;

subset Nat of Int where { $^a > 0 }

class GridSizeInfo {
    has UInt ( $.max-pos is ro, $.line-len is ro, $!rows-idx );

    submethod BUILD( :$!max-pos!, :$!line-len!  ) {
        $!rows-idx = $!max-pos div $!line-len;
    }

    # all the indices when data in a string(linear form)
    method all-columns-indices {
        ( 0 ..^ $!line-len ).map(               # for every column index
            -> $c { ( 0 .. $!rows-idx ).         # for every row index
                   map( -> $r { my $p = $c + $!line-len * $r;
                               $p > $!max-pos and last; $p } ) } );
    }

    method all-rows-indices {
        ( 0 .. $!rows-idx ).map(              # for every row index
        -> $ri { my $r = $ri * $!line-len;
                ( 0 ..^ $!line-len ).map(     # for every colum index
                    -> $c { my $p = $r + $c;
                           $p > $!max-pos and last; $p } ) } );
    }

    method all-topleft-bottomright-indices {
        # for every starting point: ex) |(0,1,2), |(3,6,9)
        ( |(0 ..^ $!line-len),
          |(1 .. $!rows-idx).map( * *$!line-len ) ).map(
            -> $b {
                my $col = $b % $!line-len;
                $b, | (1..^$!line-len).map(* * ($!line-len+1) ).map(
                    -> $dt { my $p = $b + $dt;
                            # ex) when 0 -> 4 -> 8 -> 9(X)
                            ( ($p <= $!max-pos) and
                              ($p  % $!line-len) > $col ) or last;
                            $p } ) } );
    }

    method all-topright-bottomleft-indices {
        # for every starting point: ex) |(0,1,2) |(5,8)
        ( |(0 ..^ $!line-len),
          |(2.. $!rows-idx+1).map( * *$!line-len -1 ) ).map(
            -> $b {
                my $col = $b % $!line-len;
                $b, | (1 .. $col).map( * *($!line-len-1) ).map(
                    -> $dt { my $p = $b + $dt;
                            # ex) when 1 -> 3 -> 8(X)
                            ( ($p <= $!max-pos) and
                              ($p  % $!line-len) < $col ) or last;
                            $p } ) } );
    }

    multi method all-indices {
        with self {
            return |.all-columns-indices, |.all-rows-indices,
            |.all-topleft-bottomright-indices, |.all-topright-bottomleft-indices
        }
    }

    multi method all-indices( Bool :$both-direction ) {
        my @direction = callwith();
        $both-direction or @direction.List.return;
        @direction.map(
            -> @o {
                |(@o, ( @o.elems > 1 ?? @o.reverse !! Empty ));
            } );
    }

    # finay result =.=;
    method all-subsequences-indices {
        self.all-indices( :both-direction ).map(
            -> @i { |( |@i.combinations(1),
                      |@i[ (^@i.elems).combinations(2)
                           .map( -> @two { Range.new( |@two ) } ) ] ) } );
    }
}

class GridSearchData {
    has Str ( $.file-path, $!orig-data, $!string );
    has UInt $!line-len;

    method get-orig-data {
        $!orig-data = $!file-path.IO.slurp if $!orig-data.defined.not;
        $!orig-data
    }
    method get-string {
        if $!string.defined.not {
            $!string = $!orig-data;
            $!string ~~ s:g/" "//;
            $!line-len = $!string.index( "\n" ) // $!string.chars;
            $!string ~~ s:g/\n//;
            $!string = $!string.lc;
        }
        $!string
    }
    method max-pos { self.get-string.chars -1 }
    method line-len {
        self.get-string if $!string.defined.not;
        $!line-len
    }

    method get-all-possible-words {
        my $gsi = GridSizeInfo.new( :max-pos( self.max-pos ),
                                  :line-len( self.line-len ) );
        my @chars = self.get-string.comb;
        $gsi.all-subsequences-indices
        .map( -> @i { @chars[ @i ].join(""); } )
        .unique.sort
    }
}

sub MAIN (
    Str:D :$dict                  #= dictionary file path
        where { $dict.IO.r } = '../data/tinyDict.txt',
    Str:D :$grid                  #= word search grid file path
        where { $grid.IO.r } = '../data/grid.txt',
    Bool :verbose(:$v)             #= verbose message
                             = False,
) {
    $debugging = $v;

    my $gd = GridSearchData.new( :file-path( $grid ) );

    say "Grid Data:";
    say $gd.get-orig-data;
    if $debugging {
        say "Grid data in form of lower case string:";
        say $gd.get-string,"\n";
    }

    my @grid-words = $gd.get-all-possible-words;
    say "Total {@grid-words.elems} word(s) in the grid.\n" if $debugging;
    my $gi = 0;
    my @result;

    @result = ( $dict.IO.open.lines.map(
                      -> $w { $w.lc } )  ∩ @grid-words ).List;

    say @result.raku if $debugging;
    say "Total {@result.elems} word(s) found.";

    if 0 { # small test for indices: change to 1 to have a look
        # 0  1  2
        # 3  4  5
        # 6  7  8
        # 9 10

        my $test = GridSizeInfo.new( :max-pos(10), :line-len(3) );
        with $test {
            say .all-columns-indices;
            say .all-rows-indices;
            say .all-topleft-bottomright-indices;
            say .all-topright-bottomleft-indices;
        }

        say $test.all-indices( :!both-direction );
        say $test.all-indices( :both-direction );
        say "Finally...";
        say $test.all-subsequences-indices.raku;
        say "";
    }
}

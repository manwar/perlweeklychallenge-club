#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

class SomeZeroMatrix {
    has Array @!rows;
    has Bool @!row-all-zero-flags;
    has Bool @!col-one-flags;
    has Int $!col-count;

    submethod BUILD ( Int :$rows where { $rows > 2 } = 3,
                      Int :$columns where { $columns > 2 and $rows.defined } = 3 ) {
        $!col-count = $columns;
        self!purge-col-one-flags;
        self.push-random-row( :times( $rows ) );
    }

    method !purge-col-one-flags () {
        @!col-one-flags = ( True xx $!col-count );
    }
    method !max-nrows-to-zero {  return (@!rows.elems * 0.5 ).ceiling }

    method push-random-row( Int :$times where { $times > 0 } ) {
        for ^$times {
            my @values =
            @!row-all-zero-flags.sum <= self!max-nrows-to-zero
            ?? (( 0 xx 1, 1 xx 9 ).flat.pick xx $!col-count )
            !! ( 1 xx $!col-count );

            self!push-row( @values );
        }
        return self;
    }

    method !push-row( @values ) {
        push @!rows, @values;

        if $!col-count != @values.elems {
            warn "column count is not the same as count of new values";
            $!col-count max= @values.elems;
        }

        push @!row-all-zero-flags, ( @values.any == 0 ).Bool;
        if $!col-count != @!col-one-flags.elems {
            # unmatched length of data between previous and current rows
            # increase them
            @!col-one-flags.splice: *, *,  ( True xx ($!col-count - @!col-one-flags.elems) ).flat;
        }
        @!col-one-flags = @!col-one-flags Z&& @values.map( *.Bool );
    }

    method print-rows-orig () {
        $*ERR.say: "Input: ";
        for @!rows -> $r { $*ERR.say: ~ $r.Array.raku;  }
        return self;
    }

    method print-rows () {
        $*ERR.say: "Output: ";
        for @!row-all-zero-flags -> $all-zero {
            if $all-zero {
                say ( 0 xx $!col-count ).Array.raku;
            }
            else {
                say @!col-one-flags.map( *.Int ).Array.raku;
            }
        }
        $*ERR.say;
        return self;
    }

    method empty-rows () {
        @!rows = ();
        @!row-all-zero-flags = ();
        self!purge-col-one-flags();
        return self;
    }
}

sub MAIN (
    Int :$R where { $R > 2 } = 3,                      #= number of rows
    Int :$C where { $C > 2 } = 3,                      #= number of columns
    Int :$round is copy where { $round > 0 } = 1       # number of rounds to run
) {
    my SomeZeroMatrix $matrix .= new( :rows($R) :columns($C) );
    while ( $round-- > 0 ) {
        $matrix.
        print-rows-orig().
        print-rows().
        empty-rows().
        push-random-row( :times( $R ) );
    }
}

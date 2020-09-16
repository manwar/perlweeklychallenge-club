#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

sub USAGE {
    # tested with: raku ch-1.raku 7 4 2 6 3 / 1 3 4
    "Usage: raku ch-2.raku 10 20 30 40 50 60 <sep> 1 3 4" ~
    "       <sep> can be simply '/' or any other character.".say
}

role left-rotate {
    method map-left-rotate ( @B ) {
        with self { (.elems > 0 and @B.elems > 0 ) or .return; # minimum santiy check
               @B.map(-> $i {
                             if $i > .end { # little bit more safety check
                                 warn "$i is out of range: skipped";
                                 .[0..*]   # do not change
                             }
                             |.[$i..*], |.[0..$i-1] } );
             }
    }
}

sub MAIN ( *@args ) {
    my $sep-pos = @args.first: * !~~ Int, :k;
    my $a = @args.head($sep-pos) does left-rotate;
    $a.map-left-rotate( @args.tail(@args.elems - $sep-pos - 1)
                        .grep( * ~~ Int ) )
    .map( *.say );
}

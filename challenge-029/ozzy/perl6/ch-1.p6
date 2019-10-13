#!/usr/bin/env perl6

# wk29ch1 - Write a script to demonstrate brace expansion.

sub MAIN ( Str $string = 'Perl {Daily,Weekly,Monthly,Yearly} Challenge' ) {

    grammar G {
        token TOP           { ( <h> \{ <alt>+ % ',' \} <t> )+ }
        token h             { <[\w\d\s]>* }
        token alt           { <[\w\d\s]>+ }
        token t             { <[\w\d\s]>* }
    }

    my @m = G.parse($string)[0];
    my @r = "";

    for ^@m.elems -> $i {
        @r = (@r X~ @m[$i]<h> X~ @m[$i]<alt> X~ @m[$i]<t>);
    }
    map { .say }, @r;
}
#!/usr/bin/env raku

my $S := "perlweeklychallenge";
my @W := <weekly challenge perl week>;
my %H;

@W.map: -> $w { %H{$/.from}.push: ~$/ if $S ~~ /$w/ };

say %H.keys.sort(* <=> *).map({|%H{$_}.sort(*.chars)}).join(", ") || "0";

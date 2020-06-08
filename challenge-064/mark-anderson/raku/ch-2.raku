#!/usr/bin/env raku

my $S = "perlweeklychallenge";
my @W = <weekly challenge perl week>;
my %H;

for @W -> $w {
    if $S ~~ /$w/ {
        %H{$/.from}.push: ~$/;
    }
}

if %H.keys == 0 {
    say "0 as no matching word found";
}

else {
    say %H.keys.sort(* <=> *).map({|%H{$_}.sort(*.chars)}).join(", ");
}

#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

# TASK #1 › Four Is Magic.

my \TEST = False;

my %a =
    1 => %( <name one   sz 3 magic three> ),
    2 => %( <name two   sz 3 magic three> ),
    3 => %( <name three sz 5 magic five > ),
    4 => %( <name four  sz 4 magic magic> ),
    5 => %( <name five  sz 4 magic magic> ),
    6 => %( <name six   sz 3 magic three> ),
    7 => %( <name seven sz 5 magic five > ),
    8 => %( <name eight sz 5 magic five > ),
    9 => %( <name nine  sz 4 magic four > ),
;

if TEST {
    for 1..9 { m4gic($_); }
    exit;
}

sub MAIN( Int $i = 6 ) {
    m4gic($i);
}

sub m4gic ( Int $i where (0 < $i and $i < 10) ) {
    my $n = $i;
    my Str $out;
    while %a{$n}<magic> ne 'magic' {
       $out ~= "%a{$n}<name> is %a{$n}<magic>, ";
       $n = %a{$n}<sz>;
    }
    $out ~= "%a{$n}<name> is %a{$n}<magic>.";
    say "Input: \$n = $i\nOutput: ", $out.tc;
}

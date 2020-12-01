#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    $text,
    Bool :e(:$encrypt),
    Bool :d(:$decrypt) where {$_ || $encrypt},
    Str :k(:key(:$keyword)) where {$text && $_},
    ) {

    my @offsets=({|$keyword.lc.comb.map(*.ord-97)} ... *);

    my &shiftop=($encrypt && ! $decrypt) ?? &[+] !! &[-];
    
    say $text.comb.map( sub ($c) { $c ~~ /<[a..z]>/ && return (($c.ord-97).&shiftop(@offsets.shift) % 26 + 97).chr; $c ~~ /<[A..Z]>/ && return (($c.ord-65).&shiftop(@offsets.shift) % 26 + 65).chr; $c }).join;    
}

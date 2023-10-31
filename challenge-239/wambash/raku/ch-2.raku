#!/usr/bin/env raku
use v6.e.PREVIEW;

sub consistent-strings (+str,:$allowed!) {
    str
    andthen .map: *.comb.Set
    andthen .grep: { $_ ⊆ $allowed.comb.Set }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is consistent-strings(<ad bd aaab baa badab>,:allowed('ab')),2;
    is consistent-strings(<a b c ab ac bc abc>):allowed('abc'),7;
    is consistent-strings(<cc acd b ba bac bad ac d>):allowed('cad'),4;
    done-testing;
}

multi MAIN (+str,:$allowed!) {
    say consistent-strings str,:$allowed
}

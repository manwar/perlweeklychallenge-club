#!/usr/bin/env perl6
use v6;

sub MAIN ( Str $file where *.IO.r, *@letters where { .elems > 0 and .all ~~ /^^<:L>$$/ }  ) {
    my $letterbag = @letters.map({ .comb[0].lc }).Bag;
    my @words = $file.IO.lines( :chomp ).map({ .words[0].lc });
    for @words -> $word {
        say $word if $word.comb.Bag ⊆ $letterbag;
    }
}

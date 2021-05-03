#!/bin/env raku

sub MAIN(Str:D $words where *.IO.e = '/usr/share/dict/words') {
    my @w = $words.IO.words.grep({ [le] $_.lc.comb });
    my $max-length = @w».chars.max;
    @w.grep(*.chars == $max-length).put;
}

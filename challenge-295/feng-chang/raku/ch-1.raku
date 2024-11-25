#!/bin/env raku

unit sub MAIN(*@words);

my $str = @words.shift;
put word-break($str, @words);

sub word-break(Str:D $s, @words --> Bool:D) {
    return True if $s eq '';

    for @words -> $w {
        if $s.starts-with($w) {
            my $tail = $s.substr($w.chars);
            return True if word-break($tail, @words);
        }
    }
    
    False
}

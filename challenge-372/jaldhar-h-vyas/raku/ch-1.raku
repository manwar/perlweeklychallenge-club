#!/usr/bin/raku

sub MAIN($str) {
    my @words = $str.words;
    my $spaces = $str.chars - @words».chars.sum;
    my $gaps = @words.elems - 1;

    if $gaps {
        for 0 ..^ $gaps -> $i {
            @words[$i] ~= q{ } x ($spaces / $gaps);
        }
        @words.push(q{ } x ($spaces % $gaps));        
    } else {
        @words.push(q{ } x $spaces);
    }

    say q{"}, @words.join, q{"};
}

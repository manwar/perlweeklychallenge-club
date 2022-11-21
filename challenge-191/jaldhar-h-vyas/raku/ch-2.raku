#!/usr/bin/raku

sub isCute(@list) {
    my $i = 1;

    for @list -> $elem {
        if ($i % $elem && $elem % $i) {
            return False;
        }
        $i++;
    }
    return True;
}

sub MAIN(
    Int $n where { $_ ~~ 1 .. 15 } #= integer from 1 to 15 inclusive
) {
    (1 .. $n).permutations.grep({ isCute(@$_); }).elems.say;
}
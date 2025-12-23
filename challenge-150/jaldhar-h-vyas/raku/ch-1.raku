#!/usr/bin/raku

sub MAIN(
    $a,
    $b
) {
    my @strings = ($a, $b);
    my @words = @strings;

    loop {
        @words.push( (@words[*-2], @words[*-1]).join(q{}) ); 
        if @words[*-1].chars > 51 {
            last;
        }
    }

    say @words[*-1].substr(50, 1);
}

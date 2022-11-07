#!/usr/bin/raku

sub MAIN(
    $target, #= target character
    *@array  #= array of characters
) {
    my $result = $target;
    for @array.sort -> $char {
        if ($char gt $target) {
            $result = $char;
            last;
        }
    }

    say $result;
}
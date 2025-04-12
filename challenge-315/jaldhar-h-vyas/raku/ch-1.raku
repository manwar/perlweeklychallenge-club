#!/usr/bin/raku

sub MAIN(
    $char,
    *@list,
) {
    say q{(}, @list.keys.grep({ @list[$_].contains($char) }).join(q{, }), q{)};
}


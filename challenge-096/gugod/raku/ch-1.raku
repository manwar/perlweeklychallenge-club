sub MAIN {
    my @examples = (
        "The Weekly Challenge",
        "    Perl and   Raku are  part of the same family  ",
        "join reverse split \$S",
    );

    for @examples -> $S {
        say "Input: $S";
        say "Output: " ~ reverse-words($S);
    }
}

sub reverse-words (Str $S --> Str) {
    $S.words.reverse.join(" ");
}

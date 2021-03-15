use v6;
unit sub MAIN(Str:D $s) {
    say $s.trim.words.reverse.join: ' ';
}

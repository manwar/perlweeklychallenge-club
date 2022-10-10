#!raku

# Perl Weekly Challenge 186

sub MAIN() {
    my @a = < 1 2 3 4 >;
    my @b = < a b c d >;

    say |(|@a Z |@b);
}

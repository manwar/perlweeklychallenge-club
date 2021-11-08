#!raku


sub MAIN() {
    # my @S1 = 1, 2, 5, 3, 4;
    # my @S2 = 4, 6, 7, 8, 9;
    my @S1 = 1, 3, 5, 7, 9;
    my @S2 = 0, 2, 4, 6, 8;

    "0".say and exit if @S1.grep: $_ for @S2;
    "1".say;
}

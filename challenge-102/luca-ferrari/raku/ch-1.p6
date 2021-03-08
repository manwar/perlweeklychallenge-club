#!raku




multi sub MAIN( Int $year where { $year > 1900 } ) {
    my @animals = qw/ Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig /;
    my @elements = qw/ Wood Fire Earth Metal Water /;

    say "Year $year is %s %s".sprintf:
        @elements[ ( $year - 4 ) % 10 / 2 ],
        @animals[ ( $year - 4  ) % 12 ];
}

multi sub MAIN() {
    MAIN( DateTime.now.year );
}

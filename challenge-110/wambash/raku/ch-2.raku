#!/usr/bin/env raku

sub transpose-csv-lines (@lines) {
    @lines
    andthen .map: *.split: /\,/
    andthen zip $_, with => sub (+@a) is assoc<list> { @a.join: ',' }\
}

multi MAIN () {
    .put for transpose-csv-lines lines()
}

multi MAIN (:test($)!) {
    use Test;
    my @in-row =<
        name,age,sex
        Mohammad,45,m
        Joe,20,m
        Julie,35,f
        Cristina,10,f
    >;

    my @in-column =<
        name,Mohammad,Joe,Julie,Cristina
        age,45,20,35,10
        sex,m,m,f,f
    >;

    is transpose-csv-lines(@in-row), @in-column;
    is transpose-csv-lines(@in-column), @in-row;
    done-testing;
}

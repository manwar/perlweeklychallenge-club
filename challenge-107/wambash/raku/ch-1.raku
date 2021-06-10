sub self-descriptive-numbers () {
    1..*
    andthen .map: { slip 0 x $_ .. $_-2 x $_ }\
    andthen .grep: {.comb eq .comb.Bag{ (^.chars)».Str } }\
    andthen .head(3)
}

multi MAIN () {
    .say for self-descriptive-numbers
}

multi MAIN (Bool :$test!) {
    use Test;
    is self-descriptive-numbers(), (1210, 2020, 21200);
    done-testing;
}

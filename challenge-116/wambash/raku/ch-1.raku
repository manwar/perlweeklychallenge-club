#!/usr/bin/env raku

sub get-adept ($d, $s) {
    ([\~] $d .. *) Z=> [\,] $d .. *
    andthen .first: *.key.join.chars ≥ $s.chars
}

my regex number-sequence  {
    ^
    (\d+?)\d*:
    &
    <{with get-adept($0.Int,$/.orig) { make .value; .key } }>
    $
}

multi MAIN ( Int $n ) {
    say $n.match( &number-sequence ).made.fmt: '%d',','
}

multi MAIN (Bool :test($)) {
    use Test;
    is get-adept(12, 12131), '121314' => <12 13 14>;
    is '1234'.match( &number-sequence ).made, <1 2 3 4>;
    is '91011'.match( &number-sequence ).made, <9 10 11>;
    is '10203'.match( &number-sequence ).made, <10203>;
    is '12131214'.match( &number-sequence).made, <1213 1214>;
    done-testing;
}

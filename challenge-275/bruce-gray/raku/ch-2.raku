sub task2 ( Str $s --> Str ) {
    my $prior_char;

    return [~] gather for $s.comb {
        if /<.alpha>/ { take  $prior_char = $_ }
        else          { take chr( $_ + $prior_char.ord ) }
    }
}


use Test; plan +my @tests =
    <a1c1e1 abcdef>,
    <a1b2c3d4 abbdcfdh>,
    <b2b bdb>,
    <a16z abgz>,
;
for @tests -> ( $in, $expected ) {
    is task2($in), $expected;
}

sub task1 ( $str, $char --> UInt ) {
    my UInt $count = +$str.comb($char);
    # Alternatives:
    #                 $str.comb.Bag{$char} // 0;
    #                +$str.indices($char);

    return round( 100 * $count / $str.chars );
}


use Test; plan +constant @tests =
    <perl      e 25>,
    <java      a 50>,
    <python    m  0>,
    <ada       a 67>,
    <ballerina l 22>,
    <analitik  k 13>,
;
for @tests -> ( $str, $char, $expected ) {
    is task1( $str, $char ), $expected;
}

sub csj ( Str $s --> Str ) { return $s.comb.sort.join }

sub task2a ( $str, $char --> Str ) {
    return $str.subst: / ^ ( .+? $char ) /,
                       { csj(~$0) };
}
sub task2b ( $str, $char --> Str ) {
    my $k = $str.index($char)
        orelse return $str;

    return $str.substr(0,$k+$char.chars).&csj
         ~ $str.substr(  $k+$char.chars);
}
sub task2c ( $str, $char --> Str ) {
    my ($a, $b) = $str.split: $char, 2;

    return $b.defined ?? "$a$char".&csj ~ $b !! $str;
}


my @tests =
    <challenge   e  acehllnge>,
    <programming a  agoprrmming>,
    <champion    b  champion>,

    # All my solutions also work with $char.chars > 1.
    <programming ro oprgramming>,

    # Corner cases of search string being at the very end.
    <fedcbag     g  abcdefg>,
    <fedcbga     a  abcdefg>,
    <fedcbag     ag abcdefg>,
    <fedcbga     ga abcdefg>,
;
my @subs =
    :&task2a,
    :&task2b,
    :&task2c,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( $in_str, $in_char, $expected ) {
        is task2($in_str, $in_char), $expected, "$sub_name: $in_char, $in_str";
    }
}

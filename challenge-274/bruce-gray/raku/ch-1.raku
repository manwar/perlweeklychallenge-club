sub goat_word ( Str $s --> Str ) {
    constant $vowel = <a e i o u>.any;

    my $g = $s.starts-with( $vowel )
         ?? $s
         !! $s.substr(1) ~ $s.substr(0,1);  # or: `$s.comb.rotate.join;`

    return $g  ~ 'ma';
}
sub task1 ( Str $s --> Str ) {
    constant @as = 'a' Xx (1..*);

    return ( $s.words.map(&goat_word) Z~ @as ).join: ' ';
}


my @tests =
    ( 'I love Perl'               , 'Imaa ovelmaaa erlPmaaaa' ),
    ( 'Perl and Raku are friends' , 'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa' ),
    ( 'The Weekly Challenge'      , "heTmaa eeklyWmaaa hallengeCmaaaa" ),
;
use Test; plan +@tests;
for @tests -> ( $in_str, $expected ) {
    is task1($in_str), $expected;
}

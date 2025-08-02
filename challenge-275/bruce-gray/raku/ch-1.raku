sub task1 ( @broken_keys, Str $sentence --> UInt ) {
    my @w  = $sentence.lc.words;

    my $bk = @broken_keys».lc.Set;

    return +grep { !( .comb ∩ $bk ) }, @w;
}


use Test; plan +my @tests =
    ( 0, 'la' , 'Perl Weekly Challenge' ),
    ( 1, 'a'  , 'Perl and Raku' ),
    ( 2, 'lo' , 'Well done Team PWC' ),
    ( 2, 'T'  , 'The joys of polyglottism' ),
;
for @tests -> ( $expected, $in_keys, $in_sentence ) {
    is task1($in_keys.comb, $in_sentence), $expected;
}

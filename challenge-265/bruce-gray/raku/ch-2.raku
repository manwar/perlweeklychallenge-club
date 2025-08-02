# I point out:
#   * You can directly `.comb(/.../)`, instead of `.comb.grep(/.../)`.
#   * You can `.lc` the whole word/string, instead of each letter.
sub task2 ( Str $s, @ss --> Str ) {
    my &letter_bag = *.lc.comb(/<.alpha>/).Bag;

    my $lb = letter_bag($s);

    my @completing_words = @ss.grep( *.&letter_bag ⊇ $lb )
        or return '';

    return @completing_words.min(*.chars);
}
# Credit: I changed original `(-)` to `(<=)` after reading arne-sommer's code,
# then flipped the args and changed to Unicode `⊇`.


use Test; plan +constant @tests =
    ( 'accbbb' , 'aBc 11c' , <accbbb abc abbc> ),
    ( 'baacd'  , 'Da2 abc' , <abcm baacd abaadc> ),
    ( 'bjb'    , 'JB 007'  , <jj bb bjb> ),

    # Test that we are really returning smallest of the completing words, not just the first one.
    ( 'accbbb' , 'aBc 11c' , <accbbbb accbbb> ),
;
for @tests -> ( Str $expected, Str $in_s,  @in_ss ) {
    is task2($in_s, @in_ss), $expected;
}

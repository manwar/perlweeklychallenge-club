sub task2 ( Str $s, UInt $print_limit, @character_widths ) {
    my %w = 'a'..'z' Z=> @character_widths;

    my @s_char_widths = %w{ $s.comb };
    die unless @s_char_widths.all ~~ .defined;

    my $line_count = 1;
    my $line_width = 0;

    for @s_char_widths {
        $line_width += $_;
        $line_width =  $_, $line_count++ if $line_width > $print_limit;
    }

    return $line_count, $line_width;
}


use Test; plan +constant @tests =
    ( (3, 60) ,     (10 xx 26)  , 'abcdefghijklmnopqrstuvwxyz' ),
    ( (2,  4) , (4,|(10 xx 25)) , 'bbbcccdddaaa' ),
;
for @tests -> ( @expected, @widths, $string ) {
    is-deeply task2($string, 100, @widths), @expected;
}

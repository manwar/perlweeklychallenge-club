#!/usr/bin/raku

sub MAIN(
    Str $str1,
    Str $str2,
) {
    my @chars = $str1.comb;
    my $result = False;

    for @chars.keys.combinations(2) -> ($i, $j) {
        my @temp = @chars;

        (@temp[$i], @temp[$j]) = (@temp[$j], @temp[$i]);

        if @temp.join eq $str2 {
            $result = True;
            last;
        }
    }

    say $result;
}

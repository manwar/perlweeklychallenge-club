#!/usr/bin/raku

sub MAIN(
    $str
) {
    my $palindrome = $str;
    my $len = 1;

    while $palindrome ne $palindrome.flip {
        $palindrome = $str.substr(*-($len), $len).flip ~ $str;
        $len++;
    }

    say $palindrome;
}

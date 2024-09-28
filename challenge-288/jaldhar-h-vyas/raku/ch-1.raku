#!/usr/bin/raku

sub isPalindrome(Str $str) {
    return $str eq $str.flip;
}

sub MAIN(
    Str $str
) {
    my $lower = $str - 1;
    my $upper = $str + 1;

    loop {
        if (isPalindrome($lower)) {
            say $lower;
            last;
        }
        if (isPalindrome($upper)) {
            say $upper;
            last;
        }
        $lower--;
        $upper++;
    }
}
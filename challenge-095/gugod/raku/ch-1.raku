sub MAIN {
    for (1221, -101, 90) -> $n {
        say "\nInput: $n\nOutput: " ~ (is-palindrome-number($n) ?? "1" !! "0");
    }
}

sub is-palindrome-number (Int $n --> Bool) {
    return "$n" eq "$n".flip;
}

#!/usr/bin/raku

sub MAIN(
    Str $str,
    Int $width
) {
    my $output = '*' x $width;
    $output.substr-rw(($width - $str.chars) / 2, $str.chars) = $str;
    say $output;
}

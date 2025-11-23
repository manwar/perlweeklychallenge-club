#!/usr/bin/raku

sub MAIN(
    $str
) {
    my $mid = $str.chars / 2;
    my $first = $str.substr(0, $mid);
    my $second = $str.substr($mid);
    my $vowels = / (<[a e i o u A E I O U]>) /;
    my $firstVowels = $first.match($vowels, :g).elems;
    my $secondVowels = $second.match($vowels, :g).elems;

    say $firstVowels > 0 && $secondVowels > 0 && $firstVowels == $secondVowels;
}
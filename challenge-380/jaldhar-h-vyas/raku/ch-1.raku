#!/usr/bin/raku

sub MAIN(
    $str
) {
    my %freq = <a .. z>.map({ $_ => 0 });

    S:g/(.)/ {%freq{$0}++ }/ given $str;

    my %vowels;
    for <a e i o u> -> $vowel {
        %vowels{$vowel} = %freq{$vowel}:delete // 0;
    }

    say %vowels.values.sort({ $^b <=> $^a }).first +
        %freq.values.sort({ $^b <=> $^a }).first;
}

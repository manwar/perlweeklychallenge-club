#!/usr/bin/raku

sub MAIN(
    Str $str
) {
    my @chars = $str.comb;
    my @numbers = 0 .. $str.chars;
    my @s;

    for @chars -> $c {
        if $c eq 'D' {
            @s.push(@numbers.pop);
        }
        if $c eq 'I' {
            @s.push(@numbers.shift);
        }
    }
    @s.push(@numbers.shift);

    say q{(}, @s.join(q{, }), q{)};
}

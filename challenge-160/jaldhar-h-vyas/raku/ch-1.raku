#!/usr/bin/raku

sub MAIN(
    Int $n where { $n > 0 && $n < 10 } #= an integer from 1-9
) {
    my %words = (
        1  => 'one',
        2  => 'two',
        3  => 'three',
        4  => 'four',
        5  => 'five',
        6  => 'six',
        7  => 'seven',
        8  => 'eight',
        9  => 'nine',
    );

    my $first = %words{$n};
    loop {
        if $first eq 'four' {
            say "four is magic.";
            last;
        } else {
            my $second = %words{$first.chars};
            print "$first is $second, ";
            $first = $second;
        }
    }
}
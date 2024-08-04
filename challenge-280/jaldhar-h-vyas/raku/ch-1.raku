#!/usr/bin/raku

sub MAIN(
    $str
) {
    my %seen;

    for ($str.comb) -> $c {
        if %seen{$c}:exists {
            say $c;
            last;
        } else {
            %seen{$c} = True;
        }
    }
}
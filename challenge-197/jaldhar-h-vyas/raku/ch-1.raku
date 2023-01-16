#!/usr/bin/raku

sub MAIN(
    *@list
) {
    my @zeros;
    my @numbers;

    for @list -> $i {
        if $i == 0 {
            @zeros.push($i)
        } else {
            @numbers.push($i)
        }
    }

    say q{(}, @numbers.push(| @zeros).join(q{, }), q{)};
}
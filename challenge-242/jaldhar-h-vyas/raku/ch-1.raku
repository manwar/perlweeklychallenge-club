#!/usr/bin/raku

sub MAIN(
    Str $arg1,
    Str $arg2
){
    my @arr1 = $arg1.split(q{ });
    my @arr2 = $arg2.split(q{ });

    say q{(},
        (
            (@arr1 ∖ @arr2).keys.sort.join(q{, }), 
            (@arr2 ∖ @arr1).keys.sort.join(q{, })
        )
        .grep({ .chars })
        .map({ q{[} ~ $_.join(q{, }) ~ q{]} })
        .join(q{, }),
    q{)};
}
#!/usr/bin/perl6

multi sub MAIN(
    Int $N  #= bit length (2 - 5)
    where { $N >= 2 && $N <= 5 }
) {

    my @code = (0, 1, 3, 2);

    if $N >2 {
        for 3 .. $N -> $i {
            my @s1 = @code.map({ sprintf('%0*b', $i - 1, $_); });
            my @s2 = @s1.reverse;
            @s1 = @s1.map({ "0b0$_"; }); 
            @s2 = @s2.map({ "0b1$_"; });
            @code = @s1.push(| @s2).map({ +$_; });
        }
    }

    say q{[}, @code.join(q{, }), q{]};
}
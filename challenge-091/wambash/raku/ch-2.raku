#!/usr/bin/env raku

subset Steps of Int;

sub jump-game(+@n --> Steps) {
    my $end = @n.end;
    my @jump-to = ^∞ Z+ @n;

    0,  { @jump-to[$^a] // $^a } ... * == *
    andthen .first: * == $end, :k
}

multi MAIN (Bool :$test!) {
    use  Test;
    is jump-game(1,2,1,2),       2;
    is jump-game(2,1,1,0,2),     Nil;
    is jump-game(2,0,3,0,0,1,0), 3;
    done-testing;
}

multi MAIN (*@n) {
    say +so jump-game @n
}

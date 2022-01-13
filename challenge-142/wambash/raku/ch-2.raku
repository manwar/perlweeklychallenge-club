#!/usr/bin/env raku

sub sleep-sort (+@n) {
    my Channel $ch .= new;
    @n
    andthen .map: {start {sleep $_/5;$ch.send($_)}}\
    andthen await $_;
    $ch .close;
    $ch.list;
}

multi MAIN (Bool :test($)!) {
    use Test;
    is( sleep-sort($_),(1...10),$_) for (1 .. 10).pick(10) xx 3;
    done-testing;
}

multi MAIN (*@n) {
    say sleep-sort @n
}

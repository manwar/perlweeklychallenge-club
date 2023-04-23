#!/usr/bin/env raku

sub fun-sort (+@list) {
    @list.sort: {$_ % 2 => $_}
}

multi MAIN (Bool :test($)!) {
    use Test;
    is fun-sort(1..6),(2,4,6,1,3,5);
    is fun-sort(1,2),(2,1);
    is fun-sort(1),(1);
    done-testing;
}

multi MAIN (*@list) {
    say fun-sort @list
}

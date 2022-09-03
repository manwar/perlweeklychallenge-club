#!/usr/bin/env raku

sub trim-list ($i, +@n) {
    @n.grep: * after $i
}

multi MAIN (Bool :test($)!) {
    use Test;
    is trim-list(3,1,4,2,3,5), (4,5);
    is trim-list(4,9,0,6,2,3,8,5), (9,6,8,5);
    done-testing;
}

multi MAIN ($i, +@n) {
    put trim-list $i, @n
}

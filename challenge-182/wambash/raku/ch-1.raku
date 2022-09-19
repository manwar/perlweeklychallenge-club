#!/usr/bin/env raku

sub max-index (+@n) {
   @n
   andthen .maxpairs
   andthen .head
   andthen .key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is max-index(5, 2, 9, 1, 7, 6),2;
    is max-index(4, 2, 3, 1, 5, 0),4;
    done-testing;
}

multi MAIN (+@n) {
    say max-index @n
}

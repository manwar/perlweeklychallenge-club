#!/usr/bin/env raku

sub move-zero (+@list) {
   @list
   andthen .classify: * == 0
   andthen .sort
   andthen .map: |*.value
}

multi MAIN (Bool :test($)!) {
    use Test;
    is move-zero(1, 0, 3, 0, 0, 5),(1, 3, 5, 0, 0, 0);
    is move-zero(1, 6, 4), (1, 6, 4);
    is move-zero(0, 1, 0, 2, 0), (1, 2, 0, 0, 0);
    done-testing;
}

multi MAIN (*@list) {
    put move-zero @list
}

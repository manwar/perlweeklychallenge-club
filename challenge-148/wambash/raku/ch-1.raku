#!#!/usr/bin/env raku

multi MAIN () {
    "",3,4,5,6 X~ 0,2,4,6
    andthen .skip
    andthen .say
}

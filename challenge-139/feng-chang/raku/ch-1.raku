#!/bin/env raku

sub MAIN(*@nums where .all ~~ Int) {
    put + [<] @nums;
}

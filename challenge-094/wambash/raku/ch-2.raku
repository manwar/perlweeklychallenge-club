#!/usr/bin/env raku

sub binary-tree-to-linked-list ( @a ) {    
      gather { @a.deepmap: *.take }
}

sub MAIN (Bool :$test!) {
    use Test;
    is-deeply binary-tree-to-linked-list( (1, (2,(4,(5,6,7))), 3) ), (1,2,4,5,6,7,3);
    done-testing;
}

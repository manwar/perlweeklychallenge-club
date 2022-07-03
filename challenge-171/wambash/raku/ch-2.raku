#!/usr/bin/env raku

multi infix:<o> (&f,@g) {
    &f o -> |c { @g».(|c) }
}

multi infix:<o> (@f,@g) {
    &list o @f o -> |c { @g».(|c) }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply ( (&[/],&[-]) o (&[+],&[*]) ).(2,3), ( 5/6, 5-6 ) ;
    is-deeply ( &sum o (-> +@a {@a.tail},-> +@b {@b.head},-> +@c {@c.skip.head}) ).(2,3,4),  9 ;
    is-deeply ( &[,] o (*.tail, *.head, *.skip.head) ).((2,3,4)),  (4,2,3) ;
    is-deeply ( &[/] o {$^a + $^b, $^a * $^b} ).(-12,3), 1/4;
    done-testing;
}


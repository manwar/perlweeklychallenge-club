sub task1 ( @LoLists --> UInt ) {

    return +[∩] map { .Set (-) .repeated }, @LoLists;
}


use Test; plan +my @tests =
    ( 2, <Perl is my friend>, <Perl and Raku are friend> ),
    ( 1, <Perl and Python are very similar>, <Python is top in guest languages> ),
    ( 0, <Perl is imperative Lisp is functional>, <Crystal is similar to Ruby> ),

    ( 1, <Perl is Perl>, <Java is not> ),
;
for @tests -> ( $expected, @in1, @in2 ) {
    is task1([@in1, @in2]), $expected;
}

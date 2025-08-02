sub pop-count { $^number.base(2).comb('1').elems } # From challenge-258; could also have done any of:
                            #   .comb(/1+/)».chars.sum
                            #   .comb(/1+/).join.chars
                            #   .subst(:g, '0').chars

sub task2 ( @ns --> Seq ) {
    return @ns.sort: { +.&pop-count, +$_ };
}


use Test; plan +constant @tests =
    ( (0, 1, 2, 3, 4, 5, 6, 7, 8) , (0, 1, 2, 4, 8, 3, 5, 6, 7) ),
    ( (1024, 512, 256, 128, 64)   , (64, 128, 256, 512, 1024)   ),
;
for @tests -> (@in, @expected) {
    is-deeply task2(@in), @expected, "@in[]";
}

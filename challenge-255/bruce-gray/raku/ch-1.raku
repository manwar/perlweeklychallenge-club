subset Char of Str where *.chars == 1;

sub task1 ( Str $s, Str $t --> Char ) {
    my @ts = $t, $s;

    warn "\$t ('$t') should be 1 char more than \$s ('$s')"
        if 1 !=  [-]  @ts».chars;
    my Bag $r = [(-)] @ts».comb».Bag;

    warn if $r.elems !== 1;

    return ~$r;
}


my @tests = map { %( <expected s t> Z=> .list ) },
    < e Perl   Preel   >,
    < a Weekly Weeakly >,
    < y Box    Boxy    >,
;
use Test; plan +@tests;
is task1(|.<s t>), .<expected>, .<s t> for @tests;

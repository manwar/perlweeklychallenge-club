#!/usr/bin/env raku
<<<<<<< HEAD
=======
use v6.e.PREVIEW;
>>>>>>> upstream/master
use Test;

is consecutive-ones(0,1,1,0,1,1,1), 3;
is consecutive-ones(0,0,0,0),       0;
is consecutive-ones(1,0,1,0,1,1),   2;

<<<<<<< HEAD
sub consecutive-ones(+@b)
{
    my $m = @b.join.match(/1+/, :g) or return 0;
    $m.max.chars
}

=======
multi consecutive-ones(+@b where .head == 0)
{
    sum max 0,  max @b.snip(flat (0,1) xx *)[1,3...*]
}

multi consecutive-ones(+@b)
{
   .elems given max @b.snip(flat (1,0) xx *)[0,2...*]
}
>>>>>>> upstream/master

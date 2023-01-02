#! /usr/bin/raku

use Test;

plan 2;

sub maxgap(@l0) {
    if (@l0.elems < 2) {
        return 0;
    }
    my @l = sort @l0;
    my @q;
    for @l.rotor(2 => -1) -> @i {
                   push @q,@i[1] - @i[0];
                  }
    my $mq = @q.max;
    return (grep {$_ == $mq}, @q).elems;
}

is(maxgap([2, 5, 8, 1]), 2, 'example 1');
is(maxgap([3]), 0, 'example 2');

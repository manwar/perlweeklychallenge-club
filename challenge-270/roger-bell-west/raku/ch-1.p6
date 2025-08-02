#! /usr/bin/raku

use Test;

plan 2;

is(specialpositions([[1, 0, 0], [0, 0, 1], [1, 0, 0]]), 1, 'example 1');
is(specialpositions([[1, 0, 0], [0, 1, 0], [0, 0, 1]]), 3, 'example 2');

sub validator(@a0) {
    my @a = sort @a0;
    my $l = @a.elems;
    if (@a[0] == 0 && @a[$l - 2] == 0 && @a[$l - 1] == 1) {
        for (0 .. $l - 1) -> $i {
            if (@a0[$i]== 1) {
                return $i;
            }
        }
    }
    return -1;
}

sub specialpositions(@a) {
    my @vr = [];
    my %xs = SetHash.new;
    for @a.kv -> $y, $row {
        my $x = validator($row);
        if ($x > -1) {
            push @vr, [$y, $x];
            %xs{$x}++;
        }
    }
    for %xs.keys -> $x {
        my @c = @a.map({$_[$x]});
        if (validator(@c) == -1) {
            %xs{$x}:delete;
        }
    }
    return @vr.grep({%xs{$_[1]}:exists}).elems;
}

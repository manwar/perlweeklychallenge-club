#! /usr/bin/raku

use Test;

plan 2;

is(knightsmove('g2', 'a8'), 4, 'example 1');
is(knightsmove('g2', 'h2'), 3, 'example 2');

sub cs2xy($a) {
  my @c = $a.comb;
  my $x = ord(@c[0]) - ord('a');
  my $y = ord(@c[1]) - ord('1');
  return [$x, $y];
}

sub knightsmove($from, $to) {
    my @fc = cs2xy($from);
    my @tc = cs2xy($to);
    my @queue;
    @queue.push([@fc[0], @fc[1], 0]);
    my %seen = SetHash.new;
    while (@queue.elems > 0) {
        my @cc = @queue.shift.flat;
        if (@cc[0] == @tc[0] && @cc[1] == @tc[1]) {
            return @cc[2];
        } else {
            for (
                [2, 1],
                [1, 2],
                [2, -1],
                [1, -2],
                [-2, 1],
                [-1, 2],
                [-2, -1],
                [-1, -2]
            ) -> @offset {
                my $x = @cc[0] + @offset[0];
                my $y = @cc[1] + @offset[1];
                if ($x >= 0 && $x <= 7 && $y >= 0 && $y <= 7) {
                    my $cv = $x * 8 + $y;
                    if (%seen{$cv}:!exists) {
                        @queue.push([$x, $y, @cc[2] + 1]);
                        %seen{$cv} = True;
                    }
                }
            }
        }
    }
    return -1;
}

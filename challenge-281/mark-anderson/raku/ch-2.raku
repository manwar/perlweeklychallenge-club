#!/usr/bin/env raku
use Test;

# With help from https://www.geeksforgeeks.org/minimum-steps-reach-target-knight/

is knights-move('g2', 'a8'), 4;
is knights-move('g2', 'h2'), 3;

sub knights-move($start is copy, $end is copy)
{
    $start .= &coordinates;
    $end   .= &coordinates;

    my $dx := -2, -1,  1,  2, -2, -1, 1, 2;
    my $dy := -1, -2, -2, -1,  1,  2, 2, 1;

    my @queue;
    my @visit;

    @queue.push: { :x($start[0]), :y($start[1]), :dis(0) }
    @visit[$start[0];$start[1]] = True;

    while @queue
    {
        my %t = shift @queue;
        return %t<dis> if all(%t<x> == $end[0], %t<y> == $end[1]);

        for ^8
        {
            my $x = %t<x> + $dx[$_];
            my $y = %t<y> + $dy[$_];

            if all(all($x,$y) ~~ 0..7, not @visit[$x;$y])
            {
                @visit[$x;$y] = True;
                @queue.push: { :$x, :$y, :dis(%t<dis> + 1) }
            }
        }
    }

    return Inf
}

sub coordinates($str)
{
    if $str ~~ /(<.alpha>)(<.digit>)/ -> ($col, $row)
    {
        8 - $row, $col.ord - 97
    }
}

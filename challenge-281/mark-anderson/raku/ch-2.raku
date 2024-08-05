#!/usr/bin/env raku
use Test;

# With help from https://www.geeksforgeeks.org/minimum-steps-reach-target-knight/

is knights-move('g2', 'a8'), 4;
is knights-move('g2', 'h2'), 3;

sub knights-move($start is copy, $end is copy)
{
    $start .= &coordinates;
    $end   .= &coordinates;

    my $mv := (-2,-1),(-1,-2),(1,-2),(2,-1),(-2,1),(-1,2),(1,2),(2,1);

    my @queue;
    my @visit;

    @queue.push: { :xy($start), :dis(0) }
    @visit[$start[0];$start[1]] = True;

    while @queue
    {
        my %t = shift @queue;
        return %t<dis> if %t<xy> eqv $end;

        for $mv
        {
            my $xy := %t<xy> >>+<< $_;

            if all(all($xy) ~~ ^8, not @visit[$xy[0];$xy[1]])
            {
                @visit[$xy[0];$xy[1]] = True;
                @queue.push: { :$xy, :dis(%t<dis> + 1) }
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

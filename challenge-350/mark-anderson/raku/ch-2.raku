#!/usr/bin/env raku
use Test;

is shuffle-pairs(1, 1000, 1),                 0;
is shuffle-pairs(1500, 2500, 1),              3;
is shuffle-pairs(1_000_000, 1_500_000, 5),    2;
is shuffle-pairs(13_427_000, 14_100_000, 2), 11;
is shuffle-pairs(1030, 1130, 1),              2;

sub shuffle-pairs($from, $to, $count)
{
    my $queue = Channel.new;
    $queue.send($_) for $from..$to;
    $queue.close;

    my @promises = gather for ^$*KERNEL.cpu-cores
    {
        take start process()        
    }

    await @promises;
    return sum @promises>>.result;

    sub process
    {
        my $result = 0;

        while $queue.poll -> $a
        {
            my $c = 0;
            my $a-bag = $a.comb.Bag;
        
            for 2..* -> $k
            {
                my $b = $a * $k;
                my $b-bag = $b.comb.Bag;
                last if $b-bag.total > $a-bag.total;
                $c++ if $a-bag (==) $b-bag
            }
        
            $result++ if $c >= $count
        }

        return $result
    }
}

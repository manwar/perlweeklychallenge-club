#!/usr/bin/env raku

say pandigital(1..5);
say pandigital(1, 1000000, 2000000, 3000000, 3265920);

sub pandigital(+$arr where 3265920 >= .all)
{
    my @polys = |$arr.map(*.pred.polymod(362880));

    my $starts := < 1023456789 2013456789 3012456789 
                    4012356789 5012346789 6012345789 
                    7012345689 8012345679 9012345678 >;

    my @pans = gather for $starts.head.comb.permutations
    {
        .take
    }[@polys>>[0]]>>.join;  

    gather for @pans Z @polys  
    {
        my $div = .tail.tail;
        .head .= trans($starts[0] => $starts[$div]) if $div; 
        take .head;
    }
}

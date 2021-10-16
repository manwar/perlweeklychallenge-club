#!/usr/bin/env raku

# This program only deals with pandigital numbers up to 9,876,543,210 
# (or up to the 3,265,920th)

say pandigital(^5);
say pandigital(0, 1000000, 2000000, 3000000, 3265919);

sub pandigital(+$arr where 3265920 > .all)
{
    my @polys = |$arr.map(*.polymod(362880));

    my $chunks := < 1023456789 2013456789 3012456789 
                    4012356789 5012346789 6012345789 
                    7012345689 8012345679 9012345678 >;

    my @pans = gather for $chunks.head.comb.permutations
    {
        .take
    }[@polys>>[0]]>>.join;  

    gather for @pans Z @polys  
    {
        my $div = .tail.tail;
        .head .= trans($chunks[0] => $chunks[$div]) if $div; 
        take .head;
    }
}

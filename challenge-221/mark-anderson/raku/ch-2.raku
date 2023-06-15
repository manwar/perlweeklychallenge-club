#!/usr/bin/env raku
use Test;

is arithmetic-subsequence([9,4,7,2,10]),       3; 
is arithmetic-subsequence([3,6,9,12]),         4; 
is arithmetic-subsequence([20,1,15,3,10,5,8]), 4; 

# from http://ccgi.campbellsmiths.force9.co.uk/challenge/221/2
is arithmetic-subsequence(
   [26,9,14,10,42,44,42,24,6,14,48,19,33,4,6,4,48,31,46,1,10,
    37,23,28,20,36,43,22,26,43,36,7,40,19,37,8,49,4,49,39,42,
    10,24,22,26,31,19,41,20,33,47,17,33,32,36,46,19,44,47,27,
    20,25,41,14,49,28,30,15,10,2,31,47,28,45,46,36,39,0,37,9,
    6,33,10,38,22,8,23,25,49,34,34,3,24,46,28,43,9,27,48,24]), 6;

sub arithmetic-subsequence(@a)
{
    my $channel = Channel.new;
    $channel.send($_) for @a.pairs.combinations(2);

    my @promises = do for ^$*KERNEL.cpu-cores { start process() }
    await @promises;
    
    $channel.close;

    return max @promises>>.result;

    sub process
    {
        max gather while $channel.poll -> $_
        {
            my @b = @a[.head.key, |(.tail.key..@a.end)];
            my @s = (.head.value, .tail.value...*).head(@b);

            take .elems given do while @b
            {
                shift @s if @b.shift == @s.head
            }
        }
    }
}

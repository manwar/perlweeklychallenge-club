#!/usr/bin/env raku
use Test;

is sum-of-values([2,5,9,11,3], 1),          17;
is sum-of-values([2,5,9,11,3], 2),          11;
is sum-of-values([2,5,9,11,3], 0),           2;
is sum-of-values([^100],       4),        1555;
is sum-of-values([99...0],     4),        1019;
is sum-of-values([^1e6],       8), 52104319732;

sub postfix:<!>($n) { [*] 1..$n }

sub sum-of-values(@ints, $k)
{
    my $end = @ints.end;

    loop
    {
        last if $end.base(2) ~~ m:g/1/ == $k;
        $end--
    }

    my $rank = rank($end.base(2));
    my $chars = $end.base(2).chars;
    my @ones = 1 xx $chars;
    my $combs = $chars-$k;

    return @ints[$end] unless $combs;
 
    my $channel = Channel.new;

    for ^$chars .combinations($combs)
    {
        last if $++ == $rank;
        $channel.send($_)
    }

    $channel.close;

    my @promises = gather for ^$*KERNEL.cpu-cores
    {
        take start process() 
    }

    await @promises;
    
    return sum @promises.map(*.result);

    sub process
    {
        sum gather while $channel.poll -> $combination 
        {
            my @a = @ones;
            $combination.map({ @a[$_] = 0 });
            my $i = ([~] @a).parse-base(2);
            take @ints[$i]
        }
    }
}

sub rank($s)
{
    my @a = $s.comb;
    my @ranks = @a.sort.squish.antipairs.Map{@a}>>.succ;
    my $bag = @ranks.BagHash;

    my @n = gather for @ranks -> $r
    {
        my @less-than = $bag.keys.grep(* < $r);
        take ([+] $bag{@less-than}) / ([*] $bag.values>>!);
        $bag{$r}--
    }
        
    1 + [+] @n Z* (@ranks.end...0)>>!
}

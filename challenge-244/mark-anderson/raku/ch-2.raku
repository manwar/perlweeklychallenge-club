#!/usr/bin/env raku
use Test;
use Benchy;

is group-hero(2,1,4), 141;

benchmark();

sub postfix:<!>($num where * >= 0) { [*] 1..$num }
sub C($n, $r) { $n! / ($r! * ($n - $r)!) }

sub group-hero(*@a)
{
    my $b = @a.Bag;
    
    my %h;

    for $b.keys -> $k
    {
        %h{$k} = sum map { C($b{$k}, $_) }, 1..$b{$k}
    }        

    sum gather for $b.keys.combinations.skip
    {
        take ([*] %h{$_}) * .max² * .min
    }
}

sub group-hero-slow(*@a)
{
    sum gather for @a.combinations.skip 
    {
        take .max² * .min
    }
}

sub benchmark
{
    my @a = 5,5,5,9,4,4,2,2,2,2,7,7,7,7,7,8,9,2,2,1;

    b 1,
    { say group-hero-slow(@a) },
    { say group-hero(@a)      }

    #Old:  44.378420463s
    #New:  0.036338161s
    #NEW version is 1221.26x faster
}    

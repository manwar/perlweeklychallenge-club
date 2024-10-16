#!/usr/bin/env raku
use Test;

my $result = poker-hand-rankings();

is $result<straight-flush>, 40; 
is $result<four>,           624; 
is $result<full-house>,     3744; 
is $result<flush>,          5108; 
is $result<straight>,       10200; 
is $result<three>,          54912; 
is $result<two-pair>,       123552;
is $result<pair>,           1098240; 
is $result<high-card>,      1302540; 

is $result.values.sum, (^52).combinations(5).elems;

sub poker-hand-rankings
{
    my $bh = BagHash.new;

    # <A B C D E> cooresponds to <10 J Q K A> but A..E makes the sorting easier

    my @r        = flat (2..9, <A B C D E>) xx 4;
    my @s        = flat <c> xx 13, <d> xx 13, <h> xx 13, <s> xx 13;
    my $straight = "23456789ABCDE";

    (^52).combinations(5).map(&poker-hand-rankings);

    sub poker-hand-rankings(@i)
    {
        my @suits = @s[@i];
        my $ranks = [~] @r[@i].sort;
    
        if [eq] @suits
        {
            if "2345E" eq $ranks || $straight ~~ / $ranks / { $bh<straight-flush>++ }
    
            else { $bh<flush>++ }
                
            return
        }
    
        given $ranks
        {
            when / (.) $0 $0 $0 / { $bh<four>++ }
    
            when / (.) $0 $0 (.) $1 || (.) $0 (.) $1 $1 / { $bh<full-house>++ }
    
            when "2345E" eq $_ || $straight.match(/ $_ /) { $bh<straight>++ }
    
            when / (.) $0 $0 / { $bh<three>++ }
    
            when / (.) $0 (.) $1 || (.) $0 . (.) $1 / { $bh<two-pair>++ } 
    
            when / (.) $0 / { $bh<pair>++ }
    
            default { $bh<high-card>++ }
        }
    }

    return $bh
}   

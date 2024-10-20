#!/usr/bin/env raku
use Test;

sub postfix:<!>($n where * >= 0) { [*] 1..$n }
sub infix:<C>($n,$k) { $n! / ($k! * ($n - $k)!) }

my %result = poker-hand-rankings();

is %result<straight-flush>, (10 C 1)*(4 C 1);                      # 40 
is %result<four>,           (13 C 1)*(4 C 4)*(12 C 1)*(4 C 1);     # 624 
is %result<full-house>,     (13 C 1)*(4 C 3)*(12 C 1)*(4 C 2);     # 3744 
is %result<flush>,          (13 C 5)*(4 C 1)-(10 C 1)*(4 C 1);     # 5108 
is %result<straight>,       (10 C 1)*(4 C 1)⁵-(10 C 1)*(4 C 1);    # 10200 
is %result<three>,          (13 C 1)*(4 C 3)*(12 C 2)*(4 C 1)²;    # 54912 
is %result<two-pair>,       (13 C 2)*(4 C 2)²*(11 C 1)*(4 C 1);    # 123552
is %result<pair>,           (13 C 1)*(4 C 2)*(12 C 3)*(4 C 1)³;    # 1098240 
is %result<high-card>,     ((13 C 5)-(10 C 1))*((4 C 1)⁵-(4 C 1)); # 1302540 
is %result.values.sum,      (52 C 5);                              # 2598960

sub poker-hand-rankings
{
    # this is for race/atomic ++
    my int ($a, $b, $c, $d, $e, $f, $g, $h, $i);

    my %h;
    %h<straight-flush> := $a;
    %h<four>           := $b;
    %h<full-house>     := $c;
    %h<flush>          := $d;
    %h<straight>       := $e;
    %h<three>          := $f;
    %h<two-pair>       := $g;
    %h<pair>           := $h;
    %h<high-card>      := $i;

    # <A B C D E> cooresponds to <10 J Q K A> but A..E makes the sorting easier

    my @r        = flat (2..9, <A B C D E>) xx 4;
    my @s        = flat <♣> xx 13, <♦> xx 13, <♥> xx 13, <♠> xx 13;
    my $straight = "23456789ABCDE";

    (^52).combinations(5).race.map(&poker-hand-rankings);

    sub poker-hand-rankings(@i)
    {
        my @suits = @s[@i];
        my $ranks = [~] @r[@i].sort;
    
        if [eq] @suits
        {
            if "2345E" eq $ranks || $straight ~~ / $ranks / { %h<straight-flush>⚛++ }
            else                                            { %h<flush>⚛++          }
            return
        }
    
        given $ranks
        {
            when / (.) $0 $0 $0 /                         { %h<four>⚛++       }
            when / (.) $0 $0 (.) $1 || (.) $0 (.) $1 $1 / { %h<full-house>⚛++ }
            when "2345E" eq $_ || $straight.match(/ $_ /) { %h<straight>⚛++   }
            when / (.) $0 $0 /                            { %h<three>⚛++      }
            when / (.) $0 (.) $1 || (.) $0 . (.) $1 /     { %h<two-pair>⚛++   } 
            when / (.) $0 /                               { %h<pair>⚛++       }
            default                                       { %h<high-card>⚛++  }
        }
    }

    return %h
}   

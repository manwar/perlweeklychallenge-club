#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-291/
# https://en.wikipedia.org/wiki/List_of_poker_hands#Straight
# https://en.wikipedia.org/wiki/Poker_probability#5-card_poker_hands
# Runs in about 8.6 seconds on my 2018 computer with perl v5.34
# With "dirtier" code it can be speeded up to 5.9s
# Way faster would be to use combinatorics math

use strict; use warnings;

my %count;

for my $c1 ( 0     .. 51-4 ){
for my $c2 ( $c1+1 .. 51-3 ){
for my $c3 ( $c2+1 .. 51-2 ){
for my $c4 ( $c3+1 .. 51-1 ){
for my $c5 ( $c4+1 .. 51   ){
    my @s = sort { $b <=> $a } map int $_ / 13, $c1, $c2, $c3, $c4, $c5; #suits
    my @r = sort { $b <=> $a } map $_ % 13,     $c1, $c2, $c3, $c4, $c5; #ranks
    my($r1,$r2,$r3,$r4,$r5) = @r;
    my $all_same_suit = $s[0] == $s[-1];                                 #first == last is all same suit
    my $category =
       $all_same_suit && "@r" eq "12 11 10 9 0"     ? 'Royal flush'      #a.k.a. ace-high straight flush
    :  $all_same_suit && $r1 == $r5+4               ? 'Straight flush'   #diff 1 between all and same suit
    :  $r1==$r4                                     ? 'Four'             #4+1
    :  $r2==$r5                                     ? 'Four'             #1+4
    :  $r1==$r3 && $r4==$r5                         ? 'Full house'       #3+2
    :  $r1==$r2 && $r3==$r5                         ? 'Full house'       #2+3
    :  $all_same_suit                               ? 'Flush'            #all same suit
    :  join('', map $r[$_]-$r[$_+1], 0..3) == 1111  ? 'Straight'         #diff 1 between all
    :  "@r" eq "12 11 10 9 0"                       ? 'Straight'         #ace-high straight
    :  $r1==$r3 || $r2==$r4 || $r3==$r5             ? 'Three'            #3+1+1 or 1+3+1 or 1+1+3
    :  $r1==$r2 && $r3==$r4                         ? 'Two pair'         #2+2+1
    :  $r1==$r2 && $r4==$r5                         ? 'Two pair'         #2+1+2
    :  $r2==$r3 && $r4==$r5                         ? 'Two pair'         #1+2+2
    :  $r1==$r2 || $r2==$r3 || $r3==$r4 || $r4==$r5 ? 'Pair'             #2+1+1+1|1+2+1+1|1+1+2+1|1+1+1+2
                                                    : 'High';            #nothing else
    $count{ $category }++;
    $count{'Different 5-card hands'}++;
}}}}}

printf "%-24s %7d\n", "$_:", $count{$_} for sort { $count{$a} <=> $count{$b} } keys %count;

use Test::More;
is $count{'Royal flush'}             =>       4;
is $count{'Straight flush'}          =>      36;
is $count{'Four'}                    =>     624;
is $count{'Full house'}              =>    3744;
is $count{'Flush'}                   =>    5108;
is $count{'Straight'}                =>   10200;
is $count{'Three'}                   =>   54912;
is $count{'Two pair'}                =>  123552;
is $count{'Pair'}                    => 1098240;
is $count{'High'}                    => 1302540;
is $count{'Different 5-card hands'}  => 2598960;
done_testing;

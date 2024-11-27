#!/usr/bin/env perl
# Perl weekly challenge 291
# Task 2:  Poker Hand Rankings
#
# See https://wlmb.github.io/2024/10/14/PWC291/#task-2-poker-hand-rankings
use v5.36;
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(any all sum);
my @cards=map {my $x=$_; map {[$x, $_]}('a'..'d')}(1..13);
my $iter=combinations([@cards],5);
my $count=0;
my $fiveofakind=0;
my $straightflush=0;
my $fourofakind=0;
my $fullhouse=0;
my $flush=0;
my $straight=0;
my $threeofakind=0;
my $twopair=0;
my $onepair=0;
my $highcard=0;
while(my $hand=$iter->next){
    my %ranks;
    my %suits;
    $ranks{$_}++ for map {$_->[0]} @$hand;
    $suits{$_}++ for map {$_->[1]} @$hand;
    my @ranks=sort{$a<=>$b}keys %ranks;
    my @suits=keys %suits;
    my %counts;
    $counts{$_}++ for map {$_->[0]} @$hand;
    my @counts=values %counts;
    ++$count;
    ++$fiveofakind, next if fiveofakind(\@ranks, \@suits);
    ++$straightflush, next if straightflush(\@ranks, \@suits);
    ++$fourofakind, next if fourofakind(\@counts);
    ++$fullhouse, next if fullhouse(\@counts);
    ++$flush, next if flush(\@suits);
    ++$straight, next if straight(\@ranks);
    ++$threeofakind, next if threeofakind(\@counts);
    ++$twopair, next if twopair(\@counts);
    ++$onepair, next if onepair(\@counts);
    ++$highcard, next if highcard();
}
say "Five of a kind: $fiveofakind";
say "Straightflush: $straightflush";
say "Four of a kind: $fourofakind";
say "Full house: $fullhouse";
say "Flush: $flush";
say "Straight: $straight";
say "Three of a kind: $threeofakind";
say "Two pair: $twopair";
say "One pair: $onepair";
say "High card: $highcard";
say "Total: $count";
say "Sum: ", sum ($fiveofakind, $straightflush, $fourofakind, $fullhouse, $flush, $straight,
    $threeofakind, $twopair, $onepair, $highcard);
sub fiveofakind($ranks, $suits){
    return @$ranks==1 && @$suits==1;
}
sub straightflush($ranks, $suits){
    return 0 unless @$suits==1;
    return 1 if $ranks->[0]==1 && $ranks->[1]==10;
    return 1 if $ranks->[-1]-$ranks->[0]==4;
    return 0;
}
sub fourofakind($counts){
    return any {$_==4} @$counts;
}
sub fullhouse($counts){
    return all {$_==3 || $_==2} @$counts;
}
sub flush($suits){
    return @$suits==1;
}
sub straight($ranks){
    return 0 unless @$ranks==5;
    my @diffs=map{$ranks->[$_+1]-$ranks->[$_]} 0..3;
    return  "@diffs" eq "1 1 1 1" || "@diffs" eq "9 1 1 1";
}
sub threeofakind($counts){
    return any {$_==3} @$counts;
}
sub twopair($counts){
    my @pairs=grep{$_==2}@$counts;
    return @pairs==2;
}
sub onepair($counts){
    my @pairs=grep{$_==2}@$counts;
    return @pairs==1;
}
sub highcard(){
    return 1;
}

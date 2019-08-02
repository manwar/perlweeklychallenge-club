#!/usr/bin/env perl6
use v6;

say "\nPart 2 (Rankings)";

# Imagine a running race - times of the runners are:
my @times= 10, 5, 10, 15;

say "Standard: " ~ standard(@times); # 1,2,2,4
say "Modified: " ~ modified(@times); # 1,3,3,4
say "Dense:    " ~ dense(@times); # 1,2,2,3

sub standard(@t){
    my $rank=1;
    my Bag $b=@t.Bag; # note @t.Bag.sort gives a sequence not a bag!
    return gather for $b.keys.sort {
        for ^$b{$_} { take $rank };
        $rank+=$b{$_};
    }
}

sub modified(@t){
    my $rank=0; # change start point
    my $b=@t.Bag;
    return gather for $b.keys.sort {
        $rank+=$b{$_};
        for ^$b{$_} { take $rank };
    }
}

sub dense(@t){
    my $rank=1;
my $b=@t.Bag;
    return gather for $b.keys.sort {
        for ^$b{$_} { take $rank;};
        $rank++;
    }
};

use strict;
use warnings;
##
# You are given file named input.
# Write a script to find the frequency of all the words.
# It should print the result as first column of each line should be the frequency of the 
# word followed by all the words of that frequency arranged in lexicographical order. Also 
# sort the words in the ascending order of frequency.
##
MAIN:{
    my %counts;
    my %count_words;
    my $s;
    {    local $/;
         $s = <DATA>;
    }
    $s =~ s/'s//g;
    $s =~ tr/."(),//d;
    $s =~ tr/-/ /;
    my @words = split(/\s+/, $s);
    for my $word (@words){
        $counts{$word}++;
    }
    for my $k (keys %counts){
        my $count = $counts{$k};
        push @{$count_words{$count}}, $k;
    }
    for my $k (sort keys %count_words){
        print $k . "\t" . join(" ",  sort {$a cmp $b} @{$count_words{$k}}) . "\n";
    }
}


__DATA__ 
West Side Story

The award-winning adaptation of the classic romantic tragedy "Romeo and
Juliet". The feuding families become two warring New York City gangs,
the white Jets led by Riff and the Latino Sharks, led by Bernardo. Their
hatred escalates to a point where neither can coexist with any form of
understanding. But when Riff's best friend (and former Jet) Tony and
Bernardo's younger sister Maria meet at a dance, no one can do anything
to stop their love. Maria and Tony begin meeting in secret, planning to
run away. Then the Sharks and Jets plan a rumble under the
highway--whoever wins gains control of the streets. Maria sends Tony to
stop it, hoping it can end the violence. It goes terribly wrong, and
before the lovers know what's happened, tragedy strikes and doesn't stop
until the climactic and heartbreaking ending.
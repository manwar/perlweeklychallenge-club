use strict;
use warnings;
##
# You are given a string $S.
# Write a script to reverse the 
# order of words in the given string.
##
sub reverse_words{
    my($words) = @_; 
    if(@{$words}){
        my $word = $words->[0];
        my $a = reverse_words([@{$words}[1 .. (@{$words} - 1)]]);
        $a->[@{$a}] = $word;
        return $a;
    }
    return [];
}

MAIN:{
    my($S, $reversed);
    $S = "The Weekly Challenge";
    $reversed = reverse_words([split(/\s+/, $S)]);
    print join(" ", @{$reversed}) . "\n";
    
    $S = "    Perl and   Raku are  part of the same family  ";
    $reversed = reverse_words([split(/\s+/, $S)]);
    print join(" ", @{$reversed}) . "\n";
}
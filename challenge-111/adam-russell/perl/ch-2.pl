use strict;
use warnings;
##
# Write a script to find the longest English words that don't change 
# when their letters are sorted.
##
sub max_sorted{
    my($words) = @_;
    my $max = -1;
    my @length_words; 
    for my $word (@{$words}){
        my $sorted_word = join("", sort { $a cmp $b } split(//, $word));   
        if($word eq $sorted_word && length($word) >= $max){
            $length_words[length($word)] = [] if(!$length_words[length($word)]); 
            push @{$length_words[length($word)]}, $word;  
            $max = length($word);   
        }   
    }
    return $length_words[$max];  
}

MAIN:{
    my @words;
    while(<>){
        chomp;
        push @words, lc($_);  
    }  
    print join("\n", @{max_sorted(\@words)}) . "\n";    
}

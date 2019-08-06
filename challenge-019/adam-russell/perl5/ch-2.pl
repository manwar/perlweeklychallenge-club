use strict;
use warnings;
##
# Write a script that can wrap the given paragraph at a specified column 
# using the greedy algorithm approach.
##
use constant LINE_LENGTH => 72; 

MAIN:{
    my @words;
    my $current_length = 0; 
    while(<DATA>){
        my @w = split(/\s/, $_);
        push @words, @w;
    } 
    while(@words && $current_length < LINE_LENGTH){
        my $word = shift @words;
        $current_length += length($word);
        if($current_length < LINE_LENGTH){
            print "$word ";
        } 
        else{
            print "\n";  
            $current_length = 0; 
            unshift @words, $word; 
        } 
        print "\n" if(!@words);  
    } 
}  

__DATA__
A simple way to do word wrapping is to use a greedy algorithm that puts as many words on a line as possible, then moving on to the next line to do the same until there are no more words left to place. This method is used by many modern word processors, such as OpenOffice.org Writer and Microsoft Word. This algorithm always uses the minimum possible number of lines but may lead to lines of widely varying lengths.

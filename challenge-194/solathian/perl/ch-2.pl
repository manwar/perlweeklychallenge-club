#!usr/bin/perl
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';


# Challange 194 - 2 - Frequency Equalizer
# You are given a string made of alphabetic characters only, a-z.
# Write a script to determine whether removing only one character can make the frequency of the remaining characters the same.

# freqEq('abbc');
# Output: 1 since removing one alphabet 'b' will give us 'abc' where each alphabet frequency is the same.

# freqEq('xyzyyxz');
# Output: 1 since removing 'y' will give us 'xzyyxz'.

# freqEq('xzxz');
# Output: 0 since removing any one alphabet would not give us string with same frequency alphabet.

# freqEq('xzxza');
# Output: 1 since removing 'a' will give us 'xzyyxz'.


sub freqEq($string)
{ 
    my @chracters = split('', $string);
    my @freqArr   = (0) x 26;
    
    map{ $freqArr[ord($_) - ord('a')]++ } @chracters;
    
    say checkForRemove(\@freqArr);
}

sub checkForRemove($freqArray)
{
    my $lastFreq;
    my $lastIndex;
    my $returnVal = 0;

    for(my $i = 0; $i < @$freqArray; $i++)
    {
        my $freq = $freqArray->[$i];
        
        next if($freq == 0);
        
        if(not defined $lastFreq)
        {
            $lastFreq  = $freq;
            $lastIndex = $i;
        }
        
        # do not bother with items of the same frequency
        next if($freq == $lastFreq);
        
        # so we found a different frequency, but it cannot be solved by one character removal
        return 0    if($lastFreq > ($freq + 1) || $lastFreq < ($freq -1));
        
        # it is a difference of one so it might be able to be solved
        if($lastFreq > $freq)
        {
            $freqArray->[$lastIndex]--;
            $returnVal = checkForSameFreq($freqArray);
            $freqArray->[$lastIndex]++;
        }
        elsif($lastFreq < $freq)
        {
            $freqArray->[$i]--;
            $returnVal = checkForSameFreq($freqArray);
            $freqArray->[$i]++;
        }
        
        # if the previos steps did not succeed, sometimes it is a viable option to remove the single element
        if(($returnVal == 0) && ($freqArray->[$lastIndex] == 1) )
        {
            $freqArray->[$lastIndex]--;
            $returnVal = checkForSameFreq($freqArray);
            $freqArray->[$lastIndex]++;
        }
        
        last;
    } 
    
    return $returnVal;
}

sub checkForSameFreq ($freqArray)
{
    my $lastFreq;

    for(my $i = 0; $i < @$freqArray; $i++)
    {
        my $freq = $freqArray->[$i];

        next        if($freq     == 0);     # disregeard 0 elements
        
        if(not defined $lastFreq)
        {
            $lastFreq  = $freq;
        }
        return 0    if($lastFreq != $freq)  # check if the previous element has a different   freq      
    }
    
    # no diffs found return true
    return 1;
}


#!usr/bin/perl
use v5.36;

# Challenge 212 - 1 - Jumping Letters
# You are given a word having alphabetic characters only, and a list of positive integers of the same length

# Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list. 
# The given list would have exactly the number as the total alphabets in the given word.
my $range = ord('z') - ord('a') +1;
jump('Perl', (2, 22, 19, 9));      # Output: Raku
jump('Raku', (24, 4, 7, 17));      # Output: Perl


sub jump($string, @jump)
{
    my @stringArray = split('', $string);
    
    die "String and jumparray does not have the same length"    if(@stringArray != @jump);
    
    foreach my $char (@stringArray)
    {
        my $jump    = shift @jump;
        my $newChar;
        
        if( ord('a') <= ord($char) <= ord('z') )  
        {
            my $offset  = (ord($char) - ord('a') + $jump) % $range; 
            $newChar    = chr(ord('a') + $offset);
        }
        elsif( ord('A') <= ord($char) <= ord('Z') )
        {  
            my $offset  = (ord($char) - ord('A') + $jump) % $range; 
            $newChar    = chr(ord('A') + $offset);   
        }
        else
        {   
            die "Character is not in the range of a-zA-Z!"  
        }
        
        print $newChar;
    }
    
    say "";
}
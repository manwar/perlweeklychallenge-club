use strict;
use warnings;
use Data::Dumper;


# TASK #2 › Rotate String
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson

# Given a word made up of an arbitrary number of x and y characters, that word can be rotated as follows: 
#For the ith rotation (starting at i = 1), i % length(word) characters are moved from the front of the string to the end.
#Thus, for the string xyxx, the initial (i = 1) % 4 = 1 character (x) is moved to the end, forming yxxx. 
#On the second rotation, (i = 2) % 4 = 2 characters (yx) are moved to the end, forming xxyx, and so on. 
#See below for a complete example.

# Your task is to write a function that takes a string of xs and ys and returns the minimum non-zero number 
#of rotations required to obtain the original string. 
#You may show the individual rotations if you wish, but that is not required.
# Example

# Input: $word = 'xyxx';    

    # Rotation 1: you get yxxx by moving x to the end.
    # Rotation 2: you get xxyx by moving yx to the end.
    # Rotation 3: you get xxxy by moving xxy to the end.
    # Rotation 4: you get xxxy by moving nothing as 4 % length(xyxx) == 0.
    # Rotation 5: you get xxyx by moving x to the end.
    # Rotation 6: you get yxxx by moving xx to the end.
    # Rotation 7: you get xyxx by moving yxx to the end which is same as the given word.
my $inputWord = 'xyxx';    
my $rotations = getRotations($inputWord);   
print "$inputWord  needs $rotations rotations\n";

sub getRotations {
    my $word = shift;
    my $lengthWord = length($word);
    my $currentWord = $word ;
    my $i = 0;

    while ($word ne $currentWord || !$i){
        $i++;
        my $c = $i % $lengthWord;
        my $front = substr($currentWord, 0, $c);
        my $back = substr( $currentWord,$c);
        $currentWord = $back.$front;
        print "Rotation $i: you get $currentWord by moving $front to the end.\n";
    }   
    return $i;
}



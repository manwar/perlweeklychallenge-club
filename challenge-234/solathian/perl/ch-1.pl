#!usr/bin/perl
use v5.38;

# Challenge 234 - 1 - Common Characters
# You are given an array of words made up of alphabetic characters only.
# Write a script to return all alphabetic characters that show up in all words including duplicates.


words("cool", "lock", "cook");              # Output: ("c", "o")
words("bella", "label", "roller");          # Output: ("e", "l", "l")
words("java", "javascript", "julia");       # Output: ("j", "a")
words("java", "jjjjjavascript", "julia");   # Output: ("j", "a")

sub words(@words)
{

    my @result;
    


OUTER:
    for(my $i = ord('a'); $i <= ord('z'); $i++)
    {
        my $ch = chr $i;             # the current character
        
        for(my $j = 0; $j < @words; $j++)
        {
            last OUTER     if ( $words[$j] eq "");      # end if one words is empty already
            next           if ( $j == $i);              # jump to next word, do not compare with ourself
            next OUTER     if( $words[$j] !~ m/$ch/);   # jump to next char, if it does not match    
     
        }
                
        # do stuff if we reached this
        s/$ch//    foreach(@words);     # remove the common character
        push @result, $ch;              # store for result
        redo;                           # redo since we might need to capture this character again

    }
    
    # print result
    say join ",", sort   @result;
}


#!usr/bin/perl
use v5.36;

use builtin qw(indexed);
no warnings 'experimental';

use List::Util qw'min max';

# Challenge 214 - 1 - Rank Score
# You are given a list of scores (>=1).
# Write a script to rank each score in descending order. First three will get medals i.e. G (Gold), S (Silver) and B (Bronze). 
# Rest will just get the ranking number.
# Using the standard model of giving equal scores equal rank, then advancing that number of ranks.

rankScore(1,2,4,3,5);       # (5,4,S,B,G)
rankScore(8,5,6,7,4);       # (G,4,B,S,5)
rankScore(3,5,4,2);         # (B,G,S,4)
rankScore(2,5,2,1,7,5,1);   # (4,S,4,6,G,S,6)
    


sub rankScore(@scores)
{
    my @awards      = (0) x @scores;
    my $min         = min(@scores);
    my $currentRank = 1;
    
    # we will always find the greatest scores and give them equal rank
    while(max(@scores) != ($min - 1))       # go until all scores are reduced to $min -  1
    {
        my $nofLastRanks   = 0;
        my $currentMax     = max(@scores);
        
        foreach my ($i, $value) (indexed @scores)
        {
            if( $value == $currentMax)
            {
                $scores[$i] = $min - 1;
                $awards[$i] = $currentRank;

                $nofLastRanks++;
            }
        }
        
        $currentRank += $nofLastRanks;
    }
    
    # modify the ranks
    foreach my $elem (@awards)
    {
        if(   $elem eq 1){ $elem = "G"}
        elsif($elem eq 2){ $elem = "S"}
        elsif($elem eq 3){ $elem = "B"}
    }

    say join(',', @awards);


}
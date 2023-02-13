#!usr/bin/perl
use v5.36;
use builtin 'indexed';
no warnings builtin::indexed;

# Challange 203 - 1 - Special Quadruplets
# You are given an array of integers.
# Write a script to find out the total special quadruplets for the given array.
# Special Quadruplets are such that satisfies the following 2 rules.
# 1) nums[a] + nums[b] + nums[c] == nums[d]
# 2) a < b < c < d


specQuad(1,2,3,6);      # 1
specQuad(3,3,6,4,5);    # 0

sub specQuad(@numbers)
{
    my @foundQuads;

    foreach my ($i, $a) (indexed @numbers)
    {       
        
        foreach my ($j, $b) (indexed @numbers)
        {
            next if( ($i + 1) < $j);
            
            foreach my ($k, $c) (indexed @numbers)
            {
                next if( ($j + 1) < $k);
                
                foreach my ($l, $d) (indexed @numbers)
                {
                    next if( ($k + 1) < $l);
                    
                    if( ($a + $b + $c) == $d)
                    {
                        push(@foundQuads, [$a, $b, $c, $d]);
                    }
                }
            }
        }
    }
    
    say scalar @foundQuads;
}

# did not have time to write for N number of elements
#this is currently feels awkwardly repetitive :D

#!usr/bin/perl
use v5.36;

# Challenge 220 - 2 - Squareful
use Algorithm::Combinatorics qw(permutations);
use builtin qw(true false);

no warnings 'experimental';

# Challenge 220 - 1 - Squareful

# You are given an array of integers, @ints.
# An array is squareful if the sum of every pair of adjacent elements is a perfect square.
# Write a script to find all the permutations of the given array that are squareful.

squareful(1,17,8);
squareful(2, 2, 2);

sub squareful(@list)
{
    die if(@list < 2);
    
    my @permutations = permutations(\@list);
    my @last;
    
    foreach my $permutation (permutations(\@list))
    {
        # check if the last permutation is the same as current one, to overcome issue from n, n, n arrays
        if(@last)
        {
            next    if(@last ~~ @$permutation);
        }
        @last = @$permutation;
        
        my $okFlag = true;
        
        for(my $i = 0; $i < (@$permutation -1); $i++)
        {
            my $sqrt = sqrt($permutation->[$i] + $permutation->[$i + 1]);
            
            
            if( $sqrt != int($sqrt))
            {
                $okFlag = false;
                last;
            }
        }
        
        if($okFlag)
        {
            say join(',',@$permutation);
        }

    }
}
#!usr/bin/perl -w
use strict;
use warnings;
no  warnings 'experimental';

use feature ('say', 'state', 'signatures');
use Data::Dumper;

use constant
{
    TRUE  => 1,
    FALSE => 0,
};

# Challange 187 - 2 - Magical Triplets
# You are given a list of positive numbers, @n, having at least 3 numbers.
# Write a script to find the triplets (a, b, c) from the given list that satisfies the following rules.
    #   1. a + b > c
    #   2. b + c > a
    #   3. a + c > b
    #   4. a + b + c is maximum.
# In case, you end up with more than one triplets having the maximum then pick the triplet where a >= b >= c.

# my @inp0 = (1, 2, 3, 2);
# magic(@inp0);
    # Output: (3, 2, 2)

# my @inp1 = (1, 3, 2);
# magic(@inp1);
    # Output: ()

# my @inp2 = (1, 1, 2, 3);
# magic(@inp2);
    # Output: ()

# my @inp3 = (2, 4, 3);
# magic(@inp3);
    # Output: (4, 3, 2)

# my @inp4 = qw(47 49 46 38 39 61);
# magic(@inp4);

# my @inp5 = qw(100 44 32 38 39 98 20);
# magic(@inp5);
# (100,98,44)


sub isItMagic($a, $b, $c)
{
    state $max = 0;
    my $returnVal = FALSE;

    if(($a + $b > $c) && ($b + $c > $a) && ($a + $c > $b) && ($a + $b + $c > $max))     # heck the rules
    {
        $max = $a + $b + $c;
        $returnVal = TRUE;
    }
    return $returnVal;
}

sub  magic(@array)
{

    my $retVal = "()";
    @array = sort{$b <=> $a} @array;        # this way we will find the greatest a b c combination and do no have to deal with the   a >= b >= c.

    for(my $i = 0, my $length = @array; $i < $length; $i++)
    {
        my $j = 0;
        while(($j + 2) < $length) # if the list is long traverse elements far back
        {
            if(isItMagic($array[$i], $array[($i + $j + 1) % $length], $array[($i + $j + 2) % $length]) == TRUE)
            {
                $retVal = "Output: (".join(',', $array[$i], $array[($i + $j + 1) % $length], $array[($i + $j + 2) % $length]).")";
            }
            $j++;
        }

    }
    say $retVal;
}
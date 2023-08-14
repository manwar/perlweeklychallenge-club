#!usr/bin/perl
use v5.36;

no warnings "experimental";     # suppressing the "for my (...) is experimental"  @L40


# Challenge 229 - 2 - Two out of Three
# You are given three array of integers.
# Write a script to return all the elements that are present in at least 2 out of 3 given arrays.

# going for extra points:  it is configurable and can take N arrays
my $cfg_requiredOcc = 2;    

twoOutOfThreeArr([4], [2, 4], [1, 1, 2, 4]);        # (2, 4)       
twoOutOfThreeArr([4, 1], [2, 4], [1, 2]);           # (1, 2, 4)


sub twoOutOfThreeArr(@arrOfArr)      # ARRRRR
{
    my %hash;

    foreach my $arrRef (@arrOfArr)
    {
        my %tempHash;
        
        foreach my $elem ( @$arrRef)
        {
            $tempHash{$elem} = 1    if(not exists $tempHash{$elem})
        }
        
        # copy to main hash from the temporary
        foreach my $key (keys %tempHash)
        {
            $hash{$key}++;
        }

    }

    # discard entities with only one occurrence
    my @result;
    foreach my ($key, $value) (%hash)
    {
        push(@result, $key)       if($value >= $cfg_requiredOcc);
    }
    say( "(", join(", ", sort @result), ")");

    return \@result;
}


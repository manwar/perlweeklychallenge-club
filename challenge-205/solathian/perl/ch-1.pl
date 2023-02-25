#!usr/bin/perl
use v5.36;

# Challange 205 - 1 - Third Highest
# You are given an array of integers.
# Write a script to find out the Third Highest if found otherwise return the maximum.

thirdHighest(5,4,4,3);  # 3     # First highest is 5. Second highest is 4. Third highest is 3.
thirdHighest(5,6);      # 6     # First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
thirdHighest(5,3,4);    # 3     # First highest is 5. Second highest is 4. Third highest is 3.
thirdHighest();         # Array is empty
thirdHighest(5,5,5);
thirdHighest(5,5,4,4,3,3);

sub trimArray($arrRef)  # remove duplicated elements from the array
{
    my @trimmedArr;
    
    if(@$arrRef > 0)
    {
        @$arrRef = sort @$arrRef;
        
        my $last = $arrRef->[0];
        push(@trimmedArr, $last);
    
        for(my $i = 1; $i < @$arrRef; $i++)
        {
            if($last != $arrRef->[$i])
            {
                $last = $arrRef->[$i];
                push(@trimmedArr, $last);
                
            }
        }
    }
  
    return @trimmedArr;
}

sub thirdHighest(@array)
{
    @array = trimArray(\@array);

    if(@array == 0)     {say "Array is empty."}
    elsif(@array < 3)   {say $array[-1]}
    else                {say $array[-3]}
}
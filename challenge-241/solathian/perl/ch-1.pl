#!usr/bin/perl
use v5.38;

# Challenge 241 - 1 - Arithmetic Triplets

say art(3, 0, 1, 4, 6, 7, 10);
say art(2, 4, 5, 6, 7, 8, 9);

sub art($diff, @nums)
{
    my $number;

    for(my $i = 0; $i < @nums - 2; $i++ )
    {
        for(my $j = $i; $j < @nums - 1; $j++ )
        {
            for(my $k = $j; $k < @nums; $k++ )
            {
                
                if( (($nums[$j] - $nums[$i]) == $diff ) && (($nums[$k] - $nums[$j]) == $diff ))
                {          
                    # say join(",", $nums[$i], $nums[$j], $nums[$k]);
                    $number++;
                }
            }
        }
    }
    
    return $number;
}
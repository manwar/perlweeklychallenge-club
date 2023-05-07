#!usr/bin/perl
use v5.36;

# Challenge 215 - 2 - Number Placement

numberPlacement(1, (1,0,0,0,1));
numberPlacement(2, (1,0,0,0,1));
numberPlacement(3, (1,0,0,0,0,0,0,0,1));


sub numberPlacement($number, @list)
{
    my $string = join('', @list);
    my $retVal = 1;

    for(1..$number)
    {
        if($string !~ s/000/010/)
        {
            $retVal = 0;
            last;
        }
    }
 
    say $retVal;
}
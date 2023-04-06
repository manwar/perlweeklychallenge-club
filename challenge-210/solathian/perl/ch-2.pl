#!usr/bin/perl
use v5.36;

use builtin qw(indexed true false);
no warnings 'experimental';

# Challenge 210 - 2 - Number Collision


main(2, 3, -1);
main(3, 2, -4);
main(1, -1);
main(1, -1, 5);
main(1, -1, 5, -6);
main(1, -2, 5, -6);
main(1, -6, 5, -6);
main(1, -1, 5, -6, 7);
main(-7, 7);
main(-7, -6);
main(-7, -6, 1);
main(-7, -6, 7);

sub isPos($p){ $p>0 ? return true : return false}
sub isNeg($p){ $p<0 ? return true : return false}

sub isPosBoth($p1, $p2) { (isPos($p1) &&  isPos($p2)) ? return true : return false}
sub isNegBoth($p1, $p2) { (isNeg($p1) &&  isNeg($p2)) ? return true : return false}

sub noSignChange($arrRef)
{
    my $retVal = true;
    my $firstVal = $arrRef->[0];
    
    foreach my $val (@$arrRef)
    {
        if( isPos($firstVal) && isNeg($val)  )
        {
            $retVal = false;
            last;
        }
        $firstVal = $val;
    }
    
    return $retVal;
}


sub collision( $arrRef)
{
    foreach my ($i, $currentVal) (indexed @$arrRef)
    {
        last if( ($i + 1) > $#$arrRef);                                                     # skip if we are at the last element
        
        my $nextVal =  $arrRef->[$i + 1];

        next if( isPosBoth($currentVal, $nextVal)  || isNegBoth($currentVal, $nextVal) );   # skip if both elements have the same sign
        next if( isNeg($currentVal) && isPos($nextVal)  );                                  # skip if the left element goes left while the right to the right

            
        if(   abs($nextVal) == abs($currentVal)){ splice(@$arrRef, $i,       2) }
        elsif(abs($nextVal) >  abs($currentVal)){ splice(@$arrRef, $i,       1) }
        elsif(abs($nextVal) <  abs($currentVal)){ splice(@$arrRef, ($i + 1), 1) }

    }
}


sub main(@array)
{
    if( (@array == 0 ) || (noSignChange(\@array)) )
    {
        if( @array == 0){   say "Nothing left in the end."            }
        else            {   say("We are left with: ", join(',', @array))}
    }
    else
    {
        collision(\@array);
        main(@array);
    }
}
#!usr/bin/perl -w

# Created for perl weekly challenge - 179
use strict;
use warnings;

use Math::Round;

binmode(STDOUT, ":utf8");


use constant
{

    FALSE     => 0,
    TRUE      => 1,
    SCALE_MIN => 0,
    SCALE_MAX => 7,
};


# usage on windows: create batch file which calls chcp 65001 before calling the script
# also set console font to 'NSimSun' or 'SimSun-ExtB' since the sparklines are not present in basic font
# must note that console sometimes does not shows things correctly

# the unicode characters
my @sparks = ("\x{2581}", "\x{2582}", "\x{2583}","\x{2584}", "\x{2585}", "\x{2586}", "\x{2587}", "\x{2588}");

# flags
my $scatterFlag     = FALSE;    # scatter the ouput
my $printInputFlag  = TRUE;     # enbale printing the input


sub printArray
{
    my ($arrayRef) = @_;
    
    foreach my $elem (@$arrayRef)
    {
        print $elem."  ";
    }
    
    print "\n";
}


sub normalizeData
{
    my ($arrayRef, $lowest, $highest) = @_;
    
    # if the lowest is not zero move every item down, this way the interval is utilized in a better way
    if( $lowest != SCALE_MIN )
    {
        # decrement each element by the lowest
        for(my $i = 0; $i < @$arrayRef; $i++)
        {
            $arrayRef->[$i] -= $lowest;
        }
        
        # alter the extreme values
        $highest -= $lowest;
        $lowest = 0;
    }
    
    # if the highest is still greater than scale max scale everything down
    if( $highest > SCALE_MAX )
    {
        for(my $j = 0; $j < @$arrayRef; $j++)
        {
            my $value = ($arrayRef->[$j]);
           
            # scaling down linearly to the new interval
            $arrayRef->[$j] =  SCALE_MAX  * ( 1 / $highest)  * $value;
        }
    }
}

sub getMinMax
{
    my $arrayRef = shift;
    my $lowest   = $arrayRef->[0];  # set the lowest as the first element
    my $highest  = 0;
    
    foreach my $elem (@$arrayRef) 
    {
        if($elem < $lowest)
        {
            $lowest = $elem;
        }
        
        elsif($elem > $highest)
        {
            $highest = $elem;
        }
    }
    return $highest, $lowest;
}

sub roundData
{
    my $arrayRef = shift;
    
    for(my $i = 0; $i < @$arrayRef; $i++)
    {
        $arrayRef->[$i] = round($arrayRef->[$i]);      
    }
}

sub printSparks
{
    my $arrayRef = shift;
    
    
    for(my $i = 0; $i < @$arrayRef; $i++)
    {
        my $value = $arrayRef->[$i];
        
        print( $sparks[$value] );
        print("  ")         if($scatterFlag == TRUE);   # add additional spacing if required

    }

    print "\n";
}

sub main
{
    my ($arrayRef) = @_;

    die "Array is empty. Died"  if( not defined $arrayRef );

    # printing input if needed
    printArray($arrayRef) if($printInputFlag == TRUE);
   
    # getting minimum and maximum values
    my( $highest, $lowest ) = getMinMax($arrayRef);
    
    # normalizing data
    normalizeData($arrayRef, $lowest, $highest);
    
    # rounding data
    roundData($arrayRef);
 
    # printing sparks
    printSparks($arrayRef);
}


# sample calls
# my @sampleArr = (3,4,5,8,20);
# my @sampleArr = (1,1,0,5,4,3,6,7,1,7);
# my @sampleArr = (90 ,80, 70, 60, 50, 40, 30,20, 10, 100);

# main(\@sampleArr);
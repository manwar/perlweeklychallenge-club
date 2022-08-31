#!usr/bin/perl -w

# Created for perl weekly challenge - 180 - 1
use strict;
use warnings;
use feature 'say';

#example calls
# findFirstUnique("Perl Weekly ChallengePerl Weekly Challenge");
# findFirstUnique("Perl Weekly Challenge");
# findFirstUnique("Long Live Perl");


sub findFirstUnique
{
    my $string     = shift;
    my $returnVal  = -1;
    my @characters = split(//, $string);
    my $i          = 0;

    foreach my $char (@characters)
    {
        # skip spaces
        if($char ne ' ')
        {
            #count the characters in the string
            if( 1 == ($string =~ s/$char//g ) )
            {
                # if it is one then it is unique
                say( "Output: $i as '$char' is the first unique character");

                $returnVal = $i;
                last;
            }
        }
        $i++;
    }

    if( $returnVal == -1 )
    {
        say( "Output: The given string does not contain unique characters!");
    }

    return $returnVal;
}


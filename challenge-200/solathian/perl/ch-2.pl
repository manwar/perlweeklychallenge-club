#!usr/bin/perl
use v5.36;

# Challange 200 - 2 - Seven Segment 200
# A seven segment display is an electronic component, usually used to display digits. 
# The segments are labeled 'a' through 'g' as shown:
use builtin 'indexed';
no warnings builtin::indexed;

my @truth    = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
my @skeleton = (
                "aaaaaaa",
                "f     b",
                "f     b",
                "f     b",
                "ggggggg",
                "e     c",
                "e     c",
                "e     c",
                "ddddddd",);

hexPrinter(2, 0, 0);
hexPrinter(4, 2);

sub hexPrinter(@numbers)
{
    my @digits;
    
    foreach my $digit (@numbers)
    {
        die"Digit is greater than 9. Died" if($digit > 9 );
        my @swapArray = split('', $truth[$digit]);
        my @digit     = @skeleton;
        
        # try to swap the values in the skeleton
        foreach my $line (@digit)
        {
            # characters need to be swapped
            foreach my $swap (@swapArray)
            {
                if(($swap eq "a") || ($swap eq "g") || ($swap eq "d"))
                {
                    $line =~ s/$swap/\-/g;
                }
                else
                {
                    $line =~ s/$swap/|/g;
                }

            }
            
            # remove the unswapped characters
            $line =~ s/[abcdefg]/ /g;

        }
        
        push(@digits, \@digit);
    }
    
    #merge the digits into output
    my @output;
    
    foreach my $digitArray (@digits)
    {
        foreach my ($i, $line) (indexed @$digitArray)
        {
            $output[$i] .= "  ". $line ;
        } 
    }
    
    map{say $_} @output;
    
}
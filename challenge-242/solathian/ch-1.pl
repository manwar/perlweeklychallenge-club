#!usr/bin/perl
use v5.38;
no warnings 'deprecated'; # giving smartmatch some love
# Challenge 242 - 1 - Missing Members


missingMembers([1, 2, 3], [2, 4, 6]);       # Output: ([1, 3], [4, 6])
missingMembers([1, 2, 3, 3], [1, 1, 2, 2]); # Output: ([3])



sub missingMembers($arrRef1,  $arrRef2)
{
    my @missing1;
    my @missing2;

    foreach my $elem (@$arrRef1)
    {
        next                     if($elem ~~ @$arrRef2);
        push( @missing1, $elem)  unless($elem ~~ @missing1)
    }
    
    foreach my $elem (@$arrRef2)
    {
        next                     if($elem ~~ @$arrRef1);
        push( @missing2, $elem)  unless($elem ~~ @missing2)
    }
    
    say("([", join(', ', @missing1 ), "], [", join(', ', @missing2 ), "])");

}
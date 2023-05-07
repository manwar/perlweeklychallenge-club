#!usr/bin/perl
use v5.36;

# Challenge 215 - 1 - Odd one Out
oddOne('abc', 'xyz', 'tsu');
oddOne('aBc', 'xyz', 'tsu');
oddOne('rat', 'cab', 'dad');
oddOne('x', 'y', 'z');
oddOne('x', 'y', 'z');


sub oddOne(@strings)
{
    my @return;
    
    foreach my $string (@strings)
    {
        # the task does not states that, but lowercase everything
        next    if( $string ne  join('', sort {lc $a cmp lc $b}  split('', $string)));

        push(@return, $string);
    }
    say @strings - @return;     # the number of removed items
    
    return \@return;
}
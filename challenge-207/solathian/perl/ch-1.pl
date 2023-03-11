#!usr/bin/perl
use v5.36;

# Challenge 207 - 1 -Keyboard Word
# You are given an array of words.
# Write a script to print all the words in the given array that can be types using alphabet 
# on only one row of the keyboard.

# Let us assume the keys are arranged as below:
# Row 1: qwertyuiop
# Row 2: asdfghjkl
# Row 3: zxcvbnm

my @target = qw(qwertyuiop asdfghjkl  zxcvbnm);

keyboardWord("Hello","Alaska","Dad","Peace");
keyboardWord("OMG","Bye");

sub keyboardWord(@strings)
{
    my @result;
    
    OUTER:foreach my $string (@strings)
    {
        INNER: foreach my $row (@target)
        {
            map{ next INNER     if ( index($row, $_) == -1)}  split('', lc($string));

            push(@result, $string);
            next OUTER;
        }

    }
    
    say('(', join(', ',@result), ')');
}
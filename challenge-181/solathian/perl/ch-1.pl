#!/usr/bin/perl -w
use warnings;
use strict;
use feature 'say';

# Task 1: Sentence Order
# You are given a paragraph.

# Write a script to order each sentence alphanumerically and print the whole paragraph.

  
sub order
{
    my $paragraph = shift;
   
    # swapping whitespaces into single whitespaces, linebreaks will be removed as well
    $paragraph =~ s/\s+/ /g;

    # splitting by dots
    my @sentenceArray = split(/\./, $paragraph);

    # ordering each sentence
    foreach my $sentence (@sentenceArray)
    {
        # splitting by spaces
        my @wordArr = split(/ /, $sentence);
        
        # sorting case insensitively like shown in the example
        @wordArr = sort {uc($a) cmp uc($b)} @wordArr;

        # saying the output and terminate it with the . which was cut, during the initial split
        say(join(' ', @wordArr), '.');
    }
}
   

# example call
# my $par = "All he could think about was how it would all end. There was
    # still a bit of uncertainty in the equation, but the basics
    # were there for anyone to see. No matter how much he tried to
    # see the positive, it wasn't anywhere to be seen. The end was
    # coming and it wasn't going to be pretty.";
   
   

# order($par);

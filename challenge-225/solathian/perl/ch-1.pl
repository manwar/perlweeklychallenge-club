#!usr/bin/perl
use v5.36;
=Challenge 25 - 1 - Max words
You are given a list of sentences, @list.
A sentence is a list of words that are separated by a single space with no leading or trailing spaces.
Write a script to find out the maximum number of words that appear in a single sentence.
=cut

maxWords("Perl and Raku belong to the same family.",  "I love Perl.",     "The Perl and Raku Conference.");             # 8
maxWords("The Weekly Challenge.", "Python is the most popular guest language.",     "Team PWC has over 300 members.");  # 7


sub maxWords(@array)
{
    my $max = 0;
    foreach my $sentence (@array)
    {
        my $value = scalar split(/\s+/, $sentence);
        
        $max = $value       if $value > $max;
    }
    
    say $max;
}

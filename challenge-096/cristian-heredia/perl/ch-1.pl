=begin

TASK #1 › Reverse Words
Submitted by: Mohammad S Anwar
You are given a string $S.

Write a script to reverse the order of words in the given string. The string may contain leading/trailing spaces. The string may have more than one space between words in the string. Print the result without leading/trailing spaces and there should be only one space between words.

    Example 1:
        Input: $S = "The Weekly Challenge"
        Output: "Challenge Weekly The"
    Example 2:
        Input: $S = "    Perl and   Raku are  part of the same family  "
        Output: "family same the of part are Raku and Perl"

=end
=cut

use strict;
use warnings;

my $input = "    Perl and   Raku are  part of the same family  ";

my @wordsReverse;
my $sentence;

fixSpaces();
reverseString();

sub fixSpaces {
    $input =~ s/^\s+|\s+$//g;
    $input =~ s/\s{2,}/ /g;
}

sub reverseString {
    my @words = split / /, $input;
    for (my $i=0; $i<@words; $i++) {
        unshift(@wordsReverse, $words[$i]);
        unshift(@wordsReverse, " ");
    }
    fixSpaces();
    createString();
}

sub createString {
    for (my $j=0; $j<@wordsReverse; $j++) {
        $sentence = $sentence.$wordsReverse[$j]
    }
    fixSpaces();
    print "$sentence\n";
}







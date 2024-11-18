=begin
You are given a string, $str, and list of words, @words.

Write a script to return true or false whether the given string can be segmented into a space separated sequnce of one or more words from the given list.

Example 1
Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
Output: true
Example 2
Input: $str = "perlrakuperl", @words = ("raku", "perl")
Output: true
Example 3
Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
Output: false

=cut

use strict;
use warnings;
use Test::More tests => 3;

sub isSegmented {
    my $s = shift;
    my $arr = shift;
    my @words = @$arr;

    foreach my $word (@words){
        if($s =~ /$word/ig){
            $s =~ s/$word//;
        }else{
            return 'false'
        }
    }
    return 'true';
}
my ($string1, @w1) = ("weeklychallenge", ("challenge", "weekly"));
is(isSegmented($string1,\@w1),'true');
my ($string2, @w2) = ("perlrakuperl", ("raku", "perl"));
is(isSegmented($string2,\@w2),'true');
my ($string3, @w3) = ("sonsanddaughters", ("sons", "sand", "daughters"));
is(isSegmented($string3,\@w3),'false');
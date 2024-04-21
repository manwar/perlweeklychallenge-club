#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str containing alphnumeric characters and array of strings (alphabetic characters only), @str.

Write a script to find the shortest completing word. If none found return empty string.

    A completing word is a word that contains all the letters in the given string, ignoring space and number. If a letter appeared more than once in the given string then it must appear the same number or more in the word.

Example 1

Input: $str = 'aBc 11c'
       @str = ('accbbb', 'abc', 'abbc')
Output: 'accbbb'

The given string contains following, ignoring case and number:
a 1 times
b 1 times
c 2 times

The only string in the given array that satisfies the condition is 'accbbb'.

Example 2

Input: $str = 'Da2 abc'
       @str = ('abcm', 'baacd', 'abaadc')
Output: 'baacd'

The given string contains following, ignoring case and number:
a 2 times
b 1 times
c 1 times
d 1 times

The are 2 strings in the given array that satisfies the condition:
'baacd' and 'abaadc'.

Shortest of the two is 'baacd'

Example 3

Input: $str = 'JB 007'
       @str = ('jj', 'bb', 'bjb')
Output: 'bjb'

The given string contains following, ignoring case and number:
j 1 times
b 1 times

The only string in the given array that satisfies the condition is 'bjb'.
=cut

# use Data::Dump;
use Test2::V0;


is(completing_word('aBc 11c', ['accbbb', 'abc', 'abbc']), 'accbbb', 'Example 1');
is(completing_word('Da2 abc', ['abcm', 'baacd', 'abaadc']), 'baacd', 'Example 2');
is(completing_word('JB 007', ['jj', 'bb', 'bjb']), 'bjb', 'Example 3');
is(completing_word('PWC 2024', ['pp', 'ww', 'cc']), '', 'Example Empty');
done_testing();





sub completing_word
{
     my ($str, $aref) = @_;
     $str =~ tr/01234567890 //ds;
     my %str_hash = word_hash($str);
     my @output;
     ELM: for my $elm ( @$aref )
     {
          my %elm_hash = word_hash($elm);
          for my $key ( keys %str_hash )
          {
               next ELM if (not exists $elm_hash{$key});
               next ELM if ($elm_hash{$key} < $str_hash{$key});
          }
          push @output, $elm;
     }
     
     if ( scalar @output == 0) { return ''; }
     else
     {
          @output = sort { length($a) <=> length($b) } @output;
          return $output[0];
     }
}


sub word_hash
{
     my $wrd = $_[0];
     my %hash;
     for my $chr ( split(//,$wrd ) )
     {
          $hash{ lc $chr }++;
     }
     return %hash;
}
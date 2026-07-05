#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string consisting of English letters.

Write a script to find the vowel and consonant with maximum frequency. Return the sum of two frequencies.
Example 1

Input: $str = "banana"
Output: 5

Vowel: "a" appears 3 times.
Consonant: "n" appears 2 times, "b" appears 1 time.

Max frequency of vowel: 3
Max frequency of consonant: 2

Example 2

Input: $str = "teestett"
Output: 7

Vowel: "e" appears 3 times.
Consonant: "t" appears 4 times, "s" appears 1 time.

Max frequency of vowel: 3
Max frequency of consonant: 4

Example 3

Input: $str = "aeiouuaa"
Output: 3

Vowel: "a" appears 3 times, "u" 2 times, "e", "i", "o" 1 time each.
Consonant: None.

Max frequency of vowel: 3
Max frequency of consonant: 0

Example 4

Input: $str = "rhythm"
Output: 2

Vowel: None
Consonant: "h" appears 2 times, "r", "y", "t", "m" 1 time each.

Max frequency of vowel: 0
Max frequency of consonant: 2

Example 5

Input: $str = "x"
Output: 1

Vowel: None
Consonant: "x" appears 1 time.

Max frequency of vowel: 0
Max frequency of consonant: 1
=cut




use Test2::V0 -no_srand => 1;
is(sum_of_frequencies("banana"), 5, 'Example 1');
is(sum_of_frequencies("teestett"), 7, 'Example 2');
is(sum_of_frequencies("aeiouuaa"), 3, 'Example 3');
is(sum_of_frequencies("rhythm"), 2, 'Example 4');
is(sum_of_frequencies("x"), 1, 'Example 5');
done_testing();


sub sum_of_frequencies
{
     my $str = $_[0];
     my %vowels;
     my %consonants;
     for my $ltr ( split(//, $str) )
     {
          if ( $ltr =~ /a|e|i|o|u/i ) 
          { 
               $vowels{$ltr}++ 
          }
          else 
          { 
               $consonants{$ltr}++ 
          }
     }
     my $max_vowels = (sort {$b <=> $a} values %vowels)[0] || 0;
     my $max_consonants = (sort {$b <=> $a} values %consonants)[0] || 0;
     return $max_vowels + $max_consonants;
}

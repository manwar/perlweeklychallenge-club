#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string of even length.
Write a script to find out whether the given string can be split into two halves of equal lengths, each with the same non-zero number of vowels.

Example 1

Input: $str = "textbook"
Output: false

1st half: "text" (1 vowel)
2nd half: "book" (2 vowels)


Example 2

Input: $str = "book"
Output: true

1st half: "bo" (1 vowel)
2nd half: "ok" (1 vowel)


Example 3

Input: $str = "AbCdEfGh"
Output: true

1st half: "AbCd" (1 vowel)
2nd half: "EfGh" (1 vowel)

Example 4

Input: $str = "rhythmmyth"
Output: false


1st half: "rhyth" (0 vowel)
2nd half: "mmyth" (0 vowel)


Example 5

Input: $str = "UmpireeAudio"
Output: false

1st half: "Umpire" (3 vowels)
2nd half: "eAudio" (5 vowels)
=cut


use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;


is(string_alike("textbook"), false, 'Example 1');
is(string_alike("book"), true, 'Example 2');
is(string_alike("AbCdEfGh"), true, 'Example 3');
is(string_alike("rhythmmyth"), false, 'Example 4');
is(string_alike("UmpireeAudio"), false, 'Example 5');
done_testing();

sub string_alike
{
     my $str = $_[0];
     my $length = length($str);
     die "Odd length of $str!" if ($length % 2 == 1);
     if ( (count_vowels(substr($str, 0, $length/2)) ==  
          count_vowels(substr($str, $length/2))) and
          count_vowels(substr($str, 0, $length/2)) > 0
     )
     {
          return true;
     }
     return false;
}



sub count_vowels
{
     my $str = lc $_[0];
     my $count = $str =~ tr/aeiou//;
     return $count;
}

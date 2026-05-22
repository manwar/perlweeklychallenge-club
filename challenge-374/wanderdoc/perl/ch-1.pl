#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.

Write a script to return all possible vowel substrings in the given string. A vowel substring is a substring that only consists of vowels and has all five vowels present in it.
Example 1

Input: $str = "aeiou"
Output: ("aeiou")

Example 2

Input: $str = "aaeeeiioouu"
Output: ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu")

NOTE: Updated output [2025-05-18]

Example 3

Input: $str = "aeiouuaxaeiou"
Output: ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua")

NOTE: Updated output [2025-05-18]

Example 4

Input: $str = "uaeiou"
Output: ("aeiou", "uaeio", "uaeiou")

Example 5

Input: $str = "aeioaeioa"
Output: ()
=cut



my %tests = ('Example 1' => ["aeiou", ["aeiou"]],
     'Example 2' => ["aaeeeiioouu", ["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"]],
     'Example 3' => ["aeiouuaxaeiou", ["aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua"]],
     'Example 4' => ["uaeiou", ["aeiou", "uaeio", "uaeiou"]],
     'Example 5' => ["aeioaeioa", []],
);



for my $test ( sort {$a cmp $b} keys %tests )
{
     my @output = vowel_strings($tests{$test}[0]);
     print $test;
     my @check = @{$tests{$test}[1]};
     my %index;
     @index{@check} = (0 .. $#check);
     @output = sort { $index{$a} <=> $index{$b} } @output;

     if ( join('~', @check) eq join('~', @output) )
     {
          print ": success.", $/;
     }
     else
     {
          print ": failure.", $/;
     }
}


sub vowel_strings
{
     my $str = $_[0];
     my $length = length($str);
     my @output;
     return @output if $length < 5;

     for my $start ( 0 .. $length - 5 )
     {
          for my $len_substr ( 5 .. $length - $start )
          {
               my $candidate = substr($str, $start, $len_substr);
               if ( $candidate =~/a/ and $candidate =~/e/ and $candidate =~/i/
                    and $candidate =~/o/ and $candidate =~/u/
                    and $candidate !~ /[bcdfghjklmnprqstvwxyz]/)
               {
                    push @output, $candidate;
               }
          }
     }
     return @output;
}

#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given three strings containing English alphabetic characters.

Find all the longest contiguous substrings common to all three strings that strictly alternate between vowels and consonants.
Example 1

Input: @str = ("relocate", "delocate", "allocate")
Output: ("locate")

Example 2

Input: @str = ("apple", "banana", "cherry")
Output: ()

Example 3

Input: @str = ("navigate", "cavity", "gravity")
Output: ("avi")

Example 4

Input: @str = ("pedalgia", "pedalboard", "pedantic")
Output: ("peda")

Example 5

Input: @strings = ("schoolmaster", "schoolhouse", "schooling")
Output: ("ho", "ol")

=cut






use Test2::V0 -no_srand => 1;

is([alternate_vowels_consonants("relocate", "delocate", "allocate")],
     bag{item 'locate'; end();}, 'Example 1');
is([alternate_vowels_consonants("apple", "banana", "cherry")],
     [], 'Example 2');
is([alternate_vowels_consonants("navigate", "cavity", "gravity")],
     bag{item 'avi'; end();}, 'Example 3');
is([alternate_vowels_consonants("pedalgia", "pedalboard", "pedantic")],
     bag{item 'peda'; end();}, 'Example 4'); 
is([alternate_vowels_consonants("schoolmaster", "schoolhouse", "schooling")],
     bag{item 'ol'; item 'ho'; end();}, 'Example 5');
done_testing();


sub alternate_vowels_consonants
{
     my @arr = @_;
     my $vowel_re = qr/[aeiou]/;
     my $consonant_re = qr/[b-df-hj-np-tv-z]/;
     my $alternate_re_1 = qr/$vowel_re$consonant_re/;
     my $alternate_re_2 = qr/$consonant_re$vowel_re/;
     my (@str_1, @str_2);
     
     for my $word ( @arr )
     {
          my ($alt_str_1) = $word =~ /($alternate_re_1+)/;
          push @str_1, $alt_str_1;
          my ($alt_str_2) = $word =~ /($alternate_re_2+)/;
          push @str_2, $alt_str_2;
     }
     my ($lcs_1, $lcs_2);
     my %output;
     for my $idx ( 1 .. $#str_1 )
     {
          $lcs_1 = longest_common_substring_dp($str_1[0], $str_1[$idx]);
     }
     for my $idx ( 1 .. $#str_2 )
     {
          $lcs_2 = longest_common_substring_dp($str_2[0], $str_2[$idx]);
     }
     # 'peda' and 'eda'
     if ( index($lcs_1, $lcs_2) > -1 )
     {
          $lcs_2 = $lcs_1;
     }
     elsif ( index($lcs_2, $lcs_1) > -1 )
     {
          $lcs_1 = $lcs_2;
     }
     
     @output{($lcs_1, $lcs_2)} = undef;


     return 
          grep { /$alternate_re_1|$alternate_re_2/ } # lcs might be not the alternate string!
          keys %output;
     
}





sub longest_common_substring_dp 
{
     my ($str1, $str2) = @_;
     my $len1 = length($str1);
     my $len2 = length($str2);
     my @dp;
     my $max_length = 0;
     my $end_pos = 0;

     for my $i (0 .. $len1) 
     {
          for my $j (0 .. $len2) 
          {
               $dp[$i][$j] = 0;
          }
     }


     for my $i (1 .. $len1) 
     {
          for my $j (1 .. $len2) 
          {
               if (substr($str1, $i - 1, 1) eq substr($str2, $j - 1, 1)) 
               {
                    $dp[$i][$j] = $dp[$i - 1][$j - 1] + 1;
                    if ($dp[$i][$j] > $max_length) 
                    {
                         $max_length = $dp[$i][$j];
                         $end_pos = $i;
                    }
               }
          }
     }

     
     my $lcs = substr($str1, $end_pos - $max_length, $max_length);
     return $lcs;
}

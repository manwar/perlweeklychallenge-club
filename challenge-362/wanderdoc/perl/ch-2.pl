#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.

Write a script to return them in alphabetical order, in any language of your choosing. Default language is English.
Example 1

Input: (6, 7, 8, 9 ,10)
Output: (8, 9, 7, 6, 10)

eight, nine, seven, six, ten

Example 2

Input: (-3, 0, 1000, 99)
Output: (-3, 99, 1000, 0)

minus three, ninety-nine, one thousand, zero

Example 3

Input: (1, 2, 3, 4, 5)

Output: (5, 2, 4, 3, 1) for French language
cinq, deux, quatre, trois, un

Output: (5, 4, 1, 3, 2) for English language
five, four, one, three, two

Example 4

Input: (0, -1, -2, -3, -4)
Output: (-4, -1, -3, -2, 0)

minus four, minus one, minus three, minus two, zero


Example 5

Input: (100, 101, 102)
Output: (100, 101, 102)

one hundred, one hundred and one, one hundred and two
=cut


use Test2::V0 -no_srand => 1;
is([spellbound_sorting([6, 7, 8, 9 ,10])], [8, 9, 7, 6, 10], 'Example 1');
is([spellbound_sorting([-3, 0, 1000, 99])], [-3, 99, 1000, 0], 'Example 2');
is([spellbound_sorting([1, 2, 3, 4, 5])], [5, 4, 1, 3, 2], 'Example 3 en');
is([spellbound_sorting([1, 2, 3, 4, 5], 'fr')], [5, 2, 4, 3, 1], 'Example 3 fr');
is([spellbound_sorting([0, -1, -2, -3, -4])], [-4, -1, -3, -2, 0], 'Example 4');
is([spellbound_sorting([100, 101, 102])], [100, 101, 102], 'Example 5');


done_testing();

sub spellbound_sorting
{
     my ($num_aref, $language) = @_;
     $language = 'en' unless $language;
     if ( 'en' eq $language )
     {
          my $len = eval
          {
            require Lingua::EN::Numbers;
            Lingua::EN::Numbers ->import(qw(num2en));
            1;
          };

          if($len)
          {
               return sort { num2en($a) cmp num2en($b) } @$num_aref;
          }
          else
          {
               die "Module Lingua::EN::Numbers is not loaded!";
          }
     }
     elsif ('fr' eq $language)
     {
          my $lfn = eval
          {
            require Lingua::FR::Numbers;
            Lingua::FR::Numbers ->import(qw(number_to_fr));
            1;
          };

          if($lfn)
          {
               return sort { number_to_fr($a) cmp number_to_fr($b) } @$num_aref;
          }
          else
          {
               die "Module Lingua::FR::Numbers is not loaded!";
          }
     }
     else
     {
          die "Language not implemented!";
     }
}

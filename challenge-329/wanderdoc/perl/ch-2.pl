#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string made up of lower and upper case English letters only.
Write a script to return the longest substring of the give string which is nice. A string is nice if, for every letter of the alphabet that the string contains, it appears both in uppercase and lowercase.

Example 1

Input: $str = "YaaAho"
Output: "aaA"


Example 2

Input: $str = "cC"
Output: "cC"


Example 3

Input: $str = "A"
Output: ""

No nice string found.
=cut

use Test2::V0 -no_srand => 1;

is(nice_string("YaaAho"), 'aaA', 'Example 1');
is(nice_string("cC"), 'cC', 'Example 2');
is(nice_string("A"), '', 'Example 3');

is(nice_string_2("YaaAho"), 'aaA', 'Example 1');
is(nice_string_2("cC"), 'cC', 'Example 2');
is(nice_string_2("A"), '', 'Example 3');

done_testing();

sub nice_string
{
     my $str = $_[0];
     my @arr = split(//, $str);
     my @ascii;
     for my $ltr ( @arr )
     {
          $ascii[ord($ltr)] = $ltr;
     }
     @arr = grep { 
          (defined($ascii[ord($_) - 32]) and $ascii[ord($_) - 32] eq uc($_)) 
               or
          (defined($ascii[ord($_) + 32]) and $ascii[ord($_) + 32] eq lc($_)) 
          } @arr;
     return join('', @arr);
}



sub nice_string_2
{
     my $str = $_[0];
     my (%lc, %uc);
     my @arr = split(//, $str);
     for my $ltr ( @arr )
     {
          $ltr =~ /[a-z]/ ? undef $lc{$ltr} : undef $uc{$ltr};
     }
     @arr = grep { (exists $lc{$_} and exists $uc{uc($_)})
                    or
                   (exists $uc{$_} and exists $lc{lc($_)})} @arr;
     return join('', @arr);
}

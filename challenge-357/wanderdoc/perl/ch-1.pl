#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a function that takes a 4-digit integer and returns how many iterations are required to reach Kaprekar’s constant (6174). For more information about Kaprekar's Constant please follow the wikipedia page.
Example 1

Input: $int = 3524
Output: 3

Iteration 1: 5432 - 2345 = 3087
Iteration 2: 8730 - 0378 = 8352
Iteration 3: 8532 - 2358 = 6174


Example 2

Input: $int = 6174
Output: 0


Example 3

Input: $int = 9998
Output: 5

Iteration 1: 9998 - 8999 = 0999
Iteration 2: 9990 - 0999 = 8991
Iteration 3: 9981 - 1899 = 8082
Iteration 4: 8820 - 0288 = 8532
Iteration 5: 8532 - 2358 = 6174


Example 4

Input: $int = 1001
Output: 4

Iteration 1: 1100 - 0011 = 1089
Iteration 2: 9810 - 0189 = 9621
Iteration 3: 9621 - 1269 = 8352
Iteration 4: 8532 - 2358 = 6174


Example 5

Input: $int = 9000
Output: 4

Iteration 1: 9000 - 0009 = 8991
Iteration 2: 9981 - 1899 = 8082
Iteration 3: 8820 - 0288 = 8532
Iteration 4: 8532 - 2358 = 6174


Example 6

Input: $int = 1111
Output: -1

The sequence does not converge on 6174, so return -1.

=cut



use Test2::V0 -no_srand => 1;
is(kaprekar(3524),  3, 'Example 1');
is(kaprekar(6174),  0, 'Example 2');
is(kaprekar(9998),  5, 'Example 3');
is(kaprekar(1001),  4, 'Example 4');
is(kaprekar(9000),  4, 'Example 5');
is(kaprekar(1111), -1, 'Example 6');
done_testing();

sub kaprekar
{
     my $int = $_[0]; 
     return -1 if $int =~ /^(\d)\g{1}+$/;
     my $iter = 0;
     my @padding = (0) x 3;
     while ( $int != 6174 )
     {
          my @kaprekar_form = sort {$b <=> $a} split(//, $int);
          my @reverse_kaprekar = reverse @kaprekar_form;
          my $first =  substr(join('', @kaprekar_form, @padding), 0, 4);
          # my $second = sprintf("%04d", join('', @reverse_kaprekar));
          my $second = substr(join('', @padding, @reverse_kaprekar), -4);
          $int = $first - $second; 
          $iter++;
     }
     return $iter;
}

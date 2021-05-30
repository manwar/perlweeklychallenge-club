#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to find out the next Palindrome Number higher than the given integer $N.
Example   Input: $N = 1234 Output: 1331
          Input: $N = 999 Output: 1001
=cut









sub create_next_palindrom
{
     my $num = $_[0];
     my $answer = "${num}: ";
     $num++ if $num eq scalar reverse $num;

     my $length = length($num);

     my ($left, $right);
     my $center = '';

     if ( 0 == $length % 2 )
     {
          $left = substr($num, 0, $length/2);
          $right = substr($num, $length/2);
     }
     else
     {
          $left = substr($num, 0, int($length)/2);
          $right = substr($num, int($length)/2 + 1);
          $center = substr($num, int($length)/2, 1);
     }
     my $reversed_left = reverse $left;


     if ( $reversed_left > $right )
     {
          $answer .= join('', $left, $center, $reversed_left);
     }


     else
     {
          my $left_and_center = join('', $left, $center);


          if ( substr($left_and_center, -1, 1) < 9 )
          {
               substr($left_and_center, -1, 1)++;

               $answer .= join('', $left_and_center, 
                         scalar reverse ($center ? $left : $left_and_center));
          }
          else
          {

               my @arr = split(//, $left_and_center);
               my $wheel = $#arr; # odometer MJD

               while ( $wheel >= 0 and $arr[$wheel] == 9 )
               {
                    $arr[$wheel] = 0;
                    $wheel--;
               }

               if ( $wheel < 0 )
               {

                    unshift @arr, 1;
               }
               else
               {
                    $arr[$wheel]++;
               }
               $left = $center eq '' ? join('', @arr[0 .. $#arr]) : join('', @arr[0 .. $#arr - 1]); 
               $center = $center eq '' ? '' : $arr[$#arr];

               $answer .= join('', $left, $center, scalar reverse $left);
          }
     }
     return $answer;
}




print create_next_palindrom(1234), $/;
print create_next_palindrom(999), $/;
print create_next_palindrom(1234999), $/;
print create_next_palindrom(99999_99999_99999), $/;
print create_next_palindrom(787), $/;
#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer $N.Write a script to swap the two nibbles of the binary representation of the given number and print the decimal number of the new binary representation.
A nibble is a four-bit aggregation, or half an octet.
To keep the task simple, we only allow integer less than or equal to 255.
Example

Input: $N = 101
Output: 86

Binary representation of decimal 101 is 1100101 or as 2 nibbles (0110)(0101).
The swapped nibbles would be (0101)(0110) same as decimal 86.

Input: $N = 18
Output: 33

Binary representation of decimal 18 is 10010 or as 2 nibbles (0001)(0010).
The swapped nibbles would be (0010)(0001) same as decimal 33.

=cut




sub swap_nibbles
{
     my $bin = sprintf("%b",$_[0]);
     my $swapped = $bin;
     if ( length($bin) > 4 )
     {
          while ( length($bin) % 4 )
          {
               $bin = 0 . $bin;
          } 
          my @nibbles = unpack("(A4)*", $bin);


          @nibbles = @nibbles[-1, 0];
          $swapped = join('', @nibbles);
     }

     return oct("0b" . $swapped);
}





for my $num ( 1 .. 255 )
{

     print join("\t", $num, swap_nibbles($num)), $/;
}
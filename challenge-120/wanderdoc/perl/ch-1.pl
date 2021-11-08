#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer $N less than or equal to 255. Write a script to swap the odd positioned bit with even positioned bit and print the decimal equivalent of the new binary representation.
Example

Input: $N = 101 Output: 154
Binary representation of the given number is 01 10 01 01.
The new binary representation after the odd/even swap is 10 01 10 10.
The decimal equivalent of 10011010 is 154.

Input: $N = 18 Output: 33
Binary representation of the given number is 00 01 00 10.
The new binary representation after the odd/even swap is 00 10 00 01.
The decimal equivalent of 100001 is 33.
=cut


use Scalar::Util qw(looks_like_number);

sub swap_bits
{
     my $num = $_[0];

     die "Number in range 1 to 255?$/" 
          unless looks_like_number($num) and
          $num == int($num) and
          ($num > 0 and $num < 256);
     my $binary = dec_to_bin($num);
     $binary = length($binary) % 2 ? 0 . $binary : $binary;
     my @bits = split(//, $binary);
     @bits[((grep {$_ % 2 == 0} 0 .. $#bits), (grep {$_ % 2 == 1} 0 .. $#bits))] =
     @bits[((grep {$_ % 2 == 1} 0 .. $#bits), (grep {$_ % 2 == 0} 0 .. $#bits))];
     $binary = join('', @bits);
     $num = bin_to_dec($binary);
     return $num;


}



for my $n ( 1 .. 255 )
{
     print join(' -> ', $n, swap_bits($n)), $/;
}

sub dec_to_bin { return sprintf("%b",$_[0]); }
sub bin_to_dec { return oct("0b" . $_[0]); }